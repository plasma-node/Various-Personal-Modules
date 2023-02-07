--[=[

	DevStatusPanel
	
	A control panel used to display information without having to look through a clogged up Output log.
	Made by plasma_node for himself during the development of imperial dracaria
	

	EXAMPLE USAGE:

	```lua
	local DEV = require(script.DevStatus)

	DEV.Set(script.Parent.DevStatusPanel);

	DEV.New("Bool1", "SomeBoolean", false, 1, false, "C")
	DEV.False("Bool1")

	DEV.New("walkmode", "Walk Mode", "default", 0, false, "C");
	DEV.Color("walkmode", DEV.Colors.Blue);
	```
]=]
local module = {}

-- Note to self add security settings so this doesnt show to everyone later, lol.




local Player = game.Players.LocalPlayer;

-- WARNING: YOU MUST DOWNLOAD THE DEVSTATUSPANELGUI RESOURCE FROM RELEASES!!
local Gui = Player.PlayerGui:WaitForChild("DevStatusPanel", 1);
----------------------------------------------------------------------------

module.Settings = {
	CreateNilEntries = false; -- Automatically create an entry if we search for it and it does not exist
	HideAutoCreatedEntries = true; -- Automatically hide an entry which was created automatically because it was index and didn't exist	
};

module.Colors = {
	Default = Color3.fromRGB(200,200,200);
	DarkRed = Color3.fromRGB(125, 21, 21);
	Red = Color3.fromRGB(255, 70, 70);
	Green = Color3.fromRGB(39, 198, 36);
	Blue = Color3.fromRGB(96, 107, 255);
	Lime = Color3.fromRGB(62, 255, 139)
};

module.Sizes = {
	Size3 = 60;
	Size2 = 45;
	Size1 = 35;
	Size0 = 25;
}

function Get (Name, Silence)
	if not (Gui and Gui:FindFirstChild("Container")) then return false; end
	local S = Gui.Container.Window.Content.Scroll:FindFirstChild("->"..Name);
	if (S) then
		return S;
	else
		if (not Silence) then
			---print("->DEV.Module ("..tostring(Name)..") That entry does NOT exist!");
			--return error("WTF")
		end
	end
end

function SetSize (E, Height)
	if (E) then
		E.Size = UDim2.new(E.Size.X.Scale, 0, 0, Height);
	end
end


function module.New (Name, Title, Value, Size, Color, Tag, Group) -- Make new entry
	-- Default group is 0, this will be expanded upon later
	if (Get(Name, true)) then
		print("->DEV.Module That entry ALREADY exists!");
		return false;
	end
	
	local M = script.Template:Clone();
	
	M.Name = "->"..Name;
	M.Title.Text = Title or "EMPTY_TITLE";
	M.Value.Text = Value or "";
	M.Parent = Gui.Container.Window.Content.Scroll;
	
	if (Color) then
		module.Color(Name, Color);
	end
	
	if (Tag) then
		module.Tag(Name, Tag);
	end
	
	if (Size) then
		module.Size(Name, Size);
	end
	
	-- Todo group
end

function module.Size (Name, Size)
	local E = Get(Name);
	if (E) then
		if (Size == 3) then 
			-- big
			SetSize(E, module.Sizes.Size3);
		elseif (Size == 2) then
			-- default, medium
			SetSize(E, module.Sizes.Size2);

		elseif (Size == 1) then
			-- small medium
			SetSize(E, module.Sizes.Size1);

		elseif (Size == 0) then
			-- extra small
			SetSize(E, module.Sizes.Size0);

		else
			-- default, lol
			SetSize(E, module.Sizes.Size2);

		end
	end	
end
 
function module.BulkAdd (List) -- Adds entries in bulk
	for i, Entry in pairs(List) do
		module.New(List[1], List[2] or "EMPTY_TITLE", List[3] or "", List[4] or module.Sizes.Size2, List[5] or false, List[6] or "", List[7] or 0)
	end
end


function module.Destroy (Name) -- Deletes an entry, probably shouldn't do this if you have dependencies lol
	local E = Get(Name);
	if (E) then
		E:Destroy();
	end
end

function module.Color (Name, Color) -- Recolor an entry
	local E = Get(Name);
	if (E) then
		E.BackgroundColor3 = Color or module.Colors.Default;
	end
end

function module.Tag (Name, Tag) -- Change the tag of an entry 
	local E = Get(Name);
	if (E) then
		E.Tag.Text = Tag or "";
	end
end

function module.Rename (Name, Change) -- Rename an entry
	local E = Get(Name);
	if (E) then
		E.Name = "->"..Change;
	end
end

function module.Change (Name, Value) -- Change the value of an entry
	local E = Get(Name);
	if (E) then
		E.Value.Text = Value;
	end
end

function module.True (Name) -- Sets value to "true" and green
	local E = Get(Name);
	if (E) then
		E.Value.Text = "TRUE";
		E.Value.BackgroundColor3 = module.Colors.Green;
	end
end

function module.False (Name) -- Sets value to "false" and red
	local E = Get(Name);
	if (E) then
		E.Value.Text = "FALSE";
		E.Value.BackgroundColor3 = module.Colors.Red;
	end
end

function module.Bool (Name, Bool) -- Sets value to true/false/(nil, sometimes?) based on value
	local E = Get(Name);
	if (E) then
		if (Bool == true) then
			module.True(Name);
		elseif (Bool == false) then
			module.False(Name);
		elseif (Bool == nil) then
			module.Nil(Name);
		else
			module.Clear(Name);
		end
	end	
end

function module.Nil (Name) -- Sets value to "nil" and dark red
	local E = Get(Name);
	if (E) then
		E.Value.Text = "NIL";
		E.Value.BackgroundColor3 = module.Colors.DarkRed;
	end
end

function module.Clear (Name) -- Makes the value empty and grey
	local E = Get(Name);
	if (E) then
		E.Value.Text = "";
	end
end


function module.Hide (Name) -- Hide an entry
	local E = Get(Name);
	if (E) then
		E.Visible = false;
	end
end

function module.Show (Name) -- Show an entry
	local E = Get(Name);
	if (E) then
		E.Visible = true;
	end
end

function module.Get (Name)
	return Get(Name);
end

function module.DeleteAllEntries(Confirm)
	if (Confirm == "CONFIRM") then
		warn("DEV->module.DeleteAllEntries TODO!!");
	end
end

function module.Set(G)
	Gui = G;
end

return module
