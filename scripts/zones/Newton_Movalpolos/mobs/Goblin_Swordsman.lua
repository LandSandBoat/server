-----------------------------------
-- Area: Newton Movalpolos
--  Mob: Goblin Swordsman
-- Note: PH for Swashstox Beadblinker
-----------------------------------
local ID = zones[xi.zone.NEWTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SWASHSTOX_BEADBLINKER[1], 15, 10800)
end

return entity
