# Dev Status
Dev Status is a module I created to help me debug games. You can have it show the status of current variables, change size, color, and prefix of various entries.

### [Disclaimer](https://github.com/plasma-node/RandomPublicModules/blob/master/DISCLAIMER.md)

## Usage
*Requires `DevStatusPanelGui` from Resources.rbxm if you cloned the code directly into visual studio code*    


**Creating an entry:**    
```lua
DEV.New(NameIdentifier, DisplayName, Value, Size (Default=1), Color (False = Skip), Tag)
```

``NameIdentifier`` is the name of the entry you will use to access it. 
``Tag`` is a prefix. For example, I use `"C"` as a tag for client booleans, and might also set the color to ``DEV.Colors.Blue``.

**API:**   
+ ``DEV.Show(Name)`` - Show an entry    
+ ``DEV.Hide(Name)`` - Hide an entry     
+ ``DEV.False(Name)`` - Sets boolean entry to false    
+ ``DEV.True(Name)`` - Sets boolean entry to true
+ ``DEV.Size(Name, Size)`` - Set height of entry
+ ``DEV.Destroy(Name)`` - Destroy an entry
+ ``DEV.Color(Name, Color <Color3>)`` - Change entry color
+ ``DEV.Tag(Name, Tag)`` - Change entry tag
+ ``DEV.Nil(Name)`` - Sets value to `NIL` and dark red color
+ ``DEV.Clear(Name)`` - Sets value to empty and makes grey


**Example:**     

```lua
local DEV = require(script.DevStatus)

DEV.Set(script.Parent.DevStatusPanel);

DEV.New("Bool1", "SomeBoolean", false, 1, false, "C")
DEV.False("Bool1")

DEV.New("walkmode", "Walk Mode", "default", 0, false, "C");
DEV.Color("walkmode", DEV.Colors.Blue);
```

![Example](https://gcdnb.pbrd.co/images/fc3WadMmn3HG.png?o=1)
