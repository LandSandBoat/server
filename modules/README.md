# Modules

Please see `init.txt` for how to load modules.

Please see [the module guide on the wiki](https://github.com/LandSandBoat/server/wiki/Module-Guide) for a comprehensive guide on how to write and use Lua, C++, and SQL modules.

## Era Accuracy Modules

When creating modules to revert or adjust content for era accuracy, place them in the folder corresponding to the expansion when the change was introduced:

- cop/     : Chains of Promathia (September 2004 - March 2006)
- toau/    : Treasures of Aht Urhgan (April 2006 - October 2007)
- wotg/    : Wings of the Goddess (November 2007 - May 2010)
- abyssea/ : Abyssea Add-ons (June 2010 - February 2013)
- soa/     : Seekers of Adoulin (March 2013 - April 2015)
- rov/     : Rhapsodies of Vana'diel (May 2015 - July 2020)
- tvr/     : The Voracious Resurgence (August 2020 - Present)

For example, if a change occurred in December 2010 and you want a module to revert it, place it in the abyssea/ folder.
