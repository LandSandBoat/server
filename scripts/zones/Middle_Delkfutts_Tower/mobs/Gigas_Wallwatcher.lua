-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Gigas Wallwatcher
-- Note: PH for Ogygos
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

local ogygosPHTable =
{
    [ID.mob.OGYGOS + 1] = ID.mob.OGYGOS, -- -503 -127.715 24
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 783, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 784, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ogygosPHTable, 5, math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
