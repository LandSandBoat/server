-----------------------------------
-- Area: Newton Movalpolos
--  Mob: Goblin Swordsman
-- Note: PH for Swashstox Beadblinker
-----------------------------------
local ID = zones[xi.zone.NEWTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

local swashstoxPHTable =
{
    [ID.mob.SWASHSTOX_BEADBLINKER[1] - 10] = ID.mob.SWASHSTOX_BEADBLINKER[1], -- 92.145, 15.500, 66.595
    [ID.mob.SWASHSTOX_BEADBLINKER[2] + 4]  = ID.mob.SWASHSTOX_BEADBLINKER[2], -- 88.412, 15.421, -19.950
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, swashstoxPHTable, 15, 10800)
end

return entity
