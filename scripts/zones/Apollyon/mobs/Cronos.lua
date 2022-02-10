-----------------------------------
-- Area: Apollyon NE, Floor 4
--  Mob: Cronos
-----------------------------------
require("scripts/zones/Apollyon/helpers/apollyon_ne")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGPHYS, -10000)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_ne.handleMobDeathFloorFour(mob, player, isKiller, noKiller)
end

return entity
