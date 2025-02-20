-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Tulwar Scorpion
-- Note: PH for Calchas
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
---@type TMobEntity
local entity = {}

local calchasPHTable =
{
    [ID.mob.CALCHAS - 2] = ID.mob.CALCHAS,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 137, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, calchasPHTable, 10, 3600) -- 1 hour
end

return entity
