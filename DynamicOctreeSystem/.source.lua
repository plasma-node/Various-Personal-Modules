-- Dynamic Octree System (DOS), by plasma_node, using Octree by Quenty
-- Creates Octrees that are able to remember objects, useful for
-- grids where objects will need to move or disappear.


local Octree = require(script.Octree)
local R = Random.new(os.clock() * os.time());

--- This
local DOS = {};

--- Const
local OCTREE_DEFAULTS = {
    Depth = 4;
    Size = 512;
};

--- Grid Class
local Grid = {};
Grid.__index = Grid;

-- Used to add items which will not
-- be destroyed or moved within the lifespan
-- of the DOS grid
function Grid:AddStatic (Item, Position)
    table.insert(self._trash, self.Tree:CreateNode(Position or Vector3.zero, Item));
end

function Grid:Add (Item, Position)
    self.Entries[Item] = self.Tree:CreateNode(Position or Vector3.zero, Item);
end

--[=[
    Track object:

    This function will automatically update the objects position, and
    automatically remove stale nodes.

    ! WARNING ! Not intended for large scale use, as it will cause perf issues

    Usage:
    ```lua
    local g = Grid:Track(Model, 0.1);
    task.wait(2);
    g:Destroy();
    ```
]=]
function Grid:Track (Item, Interval)
    assert(typeof(Item) == "Instance", "Object must be an instance");

    local operate = true;
    Interval = math.clamp(Interval or 0.1, 0, 10);

    if (Item:IsA("Model")) then
        task.defer(function ()
            while self.Update and operate do
                pcall(function ()
                    self.Tracked[Item]:Destroy();
                end);
                self.Tracked[Item] = self.Tree:CreateNode(Item.PrimaryPart.Position, Item);
                task.wait(Interval);
            end
        end);
    else
        task.defer(function ()
            while self.Update and operate do
                pcall(function ()
                    self.Tracked[Item]:Destroy();
                end);
                self.Tracked[Item] = self.Tree:CreateNode(Item.Position, Item);
                task.wait(Interval);
            end
        end);
    end

    return {
        Destroy = function ()
            operate = false;
            task.wait(Interval);
            pcall(function () self.Tracked[Item]:Destroy(); end);
            self.Tracked[Item] = nil
        end
    };
end

function Grid:Remove (Item)
    if (self.Entries[Item]) then
        self.Entries[Item]:Destroy();
    end
    self.Entries[Item] = nil;
end

function Grid:UpdateFor (Item, Position)
    if (self.Entries[Item]) then
        self.Entries[Item]:Destroy();
    end
    self:Add(Item, Position);
end

-- Destroy the grid
function Grid:Destroy ()
    self.Update = false;

    for _, g in self._trash do
        g:Destroy();
    end
    
    for _, entry in self.Entries do
        entry:Destroy();
    end

    self.Tree = nil;
end

function Grid:_init ()
    self.Update = true;
end


---- DOS ----

function DOS.New (Name, Depth, Size)
    local grid = {
        Name = Name or ("Unnamed DOS Grid ~~"..R:NextInteger(1000,9999)); -- Not a unique ID, just helps to distinguish things in the log if something goes wrong
        Tree = Octree.new(Depth or OCTREE_DEFAULTS.Depth, Size or OCTREE_DEFAULTS.Size);
        Update = false;

        Entries = {}; -- List of all objects/items stored
        Tracked = {}; -- List of all objects being tracked

        _trash = {};
    }

    grid = setmetatable(grid, Grid);
    grid:_init();
    
    return grid;
end

return DOS;