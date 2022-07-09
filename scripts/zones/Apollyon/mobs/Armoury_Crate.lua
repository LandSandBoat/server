-----------------------------------
-- Area: Apollyon SW, Floor 3
--  Mob: Armoury Crate
-----------------------------------
require("scripts/zones/Apollyon/bcnms/sw_apollyon_helper")
-- require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 21)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_sw.handleMobDeathFloorThree(mob, player, isKiller, noKiller)
end

entity.onMobDespawn = function(mob)
    xi.apollyon_sw.handleMobDespawnFloorThree(mob)
end

return entity
