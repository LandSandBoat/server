-----------------------------------
-- Area: Apollyon SW, Floor 3
--  Mob: Armoury Crate
-----------------------------------
-- -----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 21)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.apollyon_sw.handleMobDeathFloorThree(mob, player, optParams.isKiller, optParams.noKiller)
end

entity.onMobDespawn = function(mob)
    xi.apollyon_sw.handleMobDespawnFloorThree(mob)
end

return entity
