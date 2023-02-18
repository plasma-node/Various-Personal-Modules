-- Mini queue system, double-buffered/message queue 
local MiniQueue = {};

local Queue = {};
Queue.__index = Queue;

function Queue:Flush (Callback)
    local old = self._mode;
    self._mode = if old == 1 then 2 else 1

    Callback(self._list[old]); -- Run code before we clear it. DO NOT CREATE NEW COROUTINE

    self._list[old] = {};
end

function Queue:Add (Item)
    table.insert(self._list[self._mode], Item);
end

function Queue:Set (Key, Item) -- Sub tables, useful for grouping. Queue:Set("Rocks", someRock) -> Create Queue.Rocks if not exist, then add rock
    if (self._list[self._mode][Key]) then
        table.insert(self._list[self._mode][Key], Item);
    else
        self._list[self._mode][Key] = {Item}
    end
end

function MiniQueue.New ()
    local self = {
        _list = {{}, {}};
        _mode = 1;
    };

    setmetatable(self, Queue)
    return self;
end

return MiniQueue;