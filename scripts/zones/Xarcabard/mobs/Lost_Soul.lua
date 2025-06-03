-----------------------------------
-- Area: Xarcabard
--  Mob: Lost Soul
-- Note: PH for Timeworn Warrior
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

local timewornPHTable =
{
    [ID.mob.TIMEWORN_WARRIOR - 4] = ID.mob.TIMEWORN_WARRIOR,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 51, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 52, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 53, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 54, 3, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, timewornPHTable, 5, 5400) -- 90 minutes
end

return entity
