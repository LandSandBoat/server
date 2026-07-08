# Modules

Please see `init.txt` for how to load modules.

Please see [the module guide on the wiki](https://github.com/LandSandBoat/server/wiki/Module-Guide) for a comprehensive guide on how to write and use Lua, C++, and SQL modules.

## Era Accuracy Modules

Lua era-accuracy modules live under `era/lua/` and mirror the main `scripts/` tree where practical. These modules should use `xi.module.isContentEnabled(contentTag)` to decide whether an era override should register. If the relevant content is enabled, return a data-only table such as `{ name = moduleName }`.

Common content tags are:

- COP     : Chains of Promathia (September 2004 - March 2006)
- TOAU    : Treasures of Aht Urhgan (April 2006 - October 2007)
- WOTG    : Wings of the Goddess (November 2007 - May 2010)
- ABYSSEA : Abyssea Add-ons (June 2010 - February 2013)
- SOA     : Seekers of Adoulin (March 2013 - April 2015)
- ROV     : Rhapsodies of Vana'diel (May 2015 - July 2020)
- TVR     : The Voracious Resurgence (August 2020 - Present)

For example, if a Lua module reverts a December 2010 change, place it in the matching mirrored path under `era/lua/` and guard its override with `not xi.module.isContentEnabled('ABYSSEA')`.
