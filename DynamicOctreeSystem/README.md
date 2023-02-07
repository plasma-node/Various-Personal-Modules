# Dynamic Octree System
This module relies on [Quenty's Octree module](https://quenty.github.io/NevermoreEngine/api/Octree/) (included here) and allows you to easily track and update moving objects in an Octree.

## Documentation

```lua
local Grid = DOS.New("Name", 4, 512); -- Name, Depth (default 4), Size (default 512)
```

**Adding entry:**   
Entries can be any data type that Quenty's octree module supports. 
```lua
Grid:Add(SomeInstance, Vector3.zero); -- Item, Position
```

You can also add static entries, that is items which will not be destroyed or moved within the lifespan of the DOS grid.    
``Grid:AddStatic(Item, Position)``

**Update entry:**    
When an entry moves, you can update it by calling the ``Grid:UpdateFor`` function and sending a new position plus the item itself:

```lua
Grid:UpdateFor(Item, Position);
```

**Auto update entry:**    
WARNING! This is mainly for convenience, and should not be relied on or used for a large number of entries. It's useful because you can give it an instance,
including a model (so long as it has a primary part) and a set interval at how often it should update. For a large number of dynamic entries,
it is best to implement your own update solution.

```lua
local tracked = Grid:Track(SomeInstance, 0.1); -- Instance, Update Frequency (Default: 0.1s)
```

You can destroy the entry by calling ``tracked:Destroy();``

**Cleanup:**   
```lua
Grid:Destroy();
```