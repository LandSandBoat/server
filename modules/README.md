# Modules

Please see `init.txt` for how to load modules.

Please see [the module guide on the wiki](https://github.com/LandSandBoat/server/wiki/Module-Guide) for a comprehensive guide on how to write and use Lua, C++, and SQL modules.

## Era Accuracy Modules

Lua era-accuracy modules live under `era/lua/` and mirror the main `scripts/` tree where practical. These modules should use `xi.module.isContentEnabled(contentTag)` to decide whether an era override should register.

`Module:new` is the registration point: every constructed `Module` adds itself to `xi.module.registry`, which the loader processes after all module files have run. Module files do not return anything so a content gate is just a plain `return`:

```lua
local m = Module:new('era_magic_burst')

if xi.module.isContentEnabled('SOA') then
    return
end

m:addOverride('xi.spells.damage.calculateIfMagicBurst', function(...)
    -- ...
end)
```

Create the `Module` object **before** any content gate: registration happens at construction, so the module always shows up in the startup log and in loader validation, even when a gate means it registers zero overrides.

Modules that only mutate data tables at load time (no overrides) look exactly the same. Since the module object is never used after creation, skip the local (an unused `local m` is a luacheck warning):

```lua
Module:new('original_pdif_caps')

if xi.module.isContentEnabled('WOTG') then
    return
end

xi.combat.physical.pDifWeaponCapTable[xi.skill.HAND_TO_HAND] = 2
-- ...
```

Data/library files that other modules `require()` are not modules, they simply return their data table. Since the loader ignores return values, no wrapper or marker is needed, and `require()` gives consumers their own dependency ordering independent of the loader's scan order:

```lua
return
{
    guaranteedItems = guaranteedItems,
    zonePoolMap     = zonePoolMap,
}
```

Command modules register themselves explicitly instead of returning their command table:

```lua
xi.module.registerCommand('test', commandObj)
```

Common content tags are:

- COP     : Chains of Promathia (September 2004 - March 2006)
- TOAU    : Treasures of Aht Urhgan (April 2006 - October 2007)
- WOTG    : Wings of the Goddess (November 2007 - May 2010)
- ABYSSEA : Abyssea Add-ons (June 2010 - February 2013)
- SOA     : Seekers of Adoulin (March 2013 - April 2015)
- ROV     : Rhapsodies of Vana'diel (May 2015 - July 2020)
- TVR     : The Voracious Resurgence (August 2020 - Present)

For example, if a Lua module reverts a December 2010 change, place it in the matching mirrored path under `era/lua/` and guard its override with `not xi.module.isContentEnabled('ABYSSEA')`.
