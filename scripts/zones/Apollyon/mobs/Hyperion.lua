-----------------------------------
-- Area: Apollyon NE, Floor 4
--  Mob: Hyperion
-----------------------------------
require("scripts/zones/Apollyon/helpers/apollyon_ne")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGMAGIC, -10000)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_ne.handleMobDeathFloorFour(mob, player, isKiller, noKiller)
end

return entity
