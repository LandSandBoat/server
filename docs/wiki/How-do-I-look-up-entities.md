# How do I look up entities?

## Why can't I just hard-code my IDs with the IDs from the client or database?

We pin the the current retail client version - which updates every month. Every time there is a retail client update, various things in the client shift around - including entity IDs. If you hard-code something and then it shifts in a version update, your hard-coded code will break. If you do a lookup by name a load-time or run-time there is a better chance things won't break between updates since we have tooling that can (mostly) handle those ID shifts, but only in the database.

## Load-time

When the server is first starting up a lot of information you might expect to be available hasn't yet been loaded, so you need to be careful about how you do entity lookup.

Currently, the best way to do entity lookup at load-time is through the various zone IDs.lua files. These are pre-loaded before a lot of other parts of the system. While these are being pre-loaded they have special TEMPORARY functions injected into them that access a TEMPORARY cache mapping entity names to IDs.

Since a lot of things aren't loaded, these are only capable of getting the IDs of any entities you're trying to look up, rather than the entity itself. You'll have to do a follow-up lookup of the actual entity at runtime.

These are also available while hot-reloading these files.

While doing lookup by name, you want to use either `mobname` from `mob_spawn_points.sql` or `name` from `npc_list.sql`.

**WARNING:** If you cache the results of these lookups somewhere and then you hot-reload the IDs file, you might get results you don't expect. Be careful!

### GetFirstID

This will go through `mob_spawn_points` and `npc_list` and return the ID of the first entity that matches the name you provide.

```lua
    mob =
    {
        SOME_MOB = GetFirstID('Some_Mob'),
    }
```

This is the numeric ID, so you can look up one entity and then look up its neighbors.

```lua
    mob =
    {
        SOME_MOBS_FRIEND = GetFirstID('Some_Mob') + 1,
    }
```

### GetTableOfIDs (full)

This will go through `mob_spawn_points` and `npc_list` and return a table of ALL THE ENTITIES that match the name you provide. Be careful if you're looking up groups of entities that might have non-functional versions used in events.

```lua
...
    npc =
    {
        LOGGING = GetTableOfIDs("Logging_Point"),
    }
...
```

### GetTableOfIDs (range)

This will go through `mob_spawn_points` and `npc_list` and return a table of entities starting at the first entity that matches the name you provide, continuing to the range you provide - inclusively.

```lua
...
    npc =
    {
        LOGGING = GetTableOfIDs("Logging_Point", 4),
    }
...
```

In this example you'd get back the equivalent of:

```lua
    npc =
    {
        LOGGING =
        {
            GetFirstID('Logging_Point') + 0,
            GetFirstID('Logging_Point') + 1,
            GetFirstID('Logging_Point') + 2,
            GetFirstID('Logging_Point') + 3,
        }
    }
```

## Run-time

Once everything is loaded and the server is ticking, you're in run-time.

Since everything is loaded we no longer have to look up things from the database and hold onto their IDs for later use. We can either use IDs we've looked up from the zone IDs.lua files, or we can query current zone objects:

```lua
    local results = zone:queryEntitiesByName(name)
    for _, entity in pairs(results) do
        -- Do something with entity
        doSomething(entity)
    end
```

Here we're querying the zone for all entities that match the name we provide, and we're returning a table of the full entities - rather than the IDs.
