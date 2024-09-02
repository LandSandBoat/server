-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Sand Beetle
-- Note: PH for Donnergugi
-----------------------------------
local ID = zones[xi.zone.EASTERN_ALTEPA_DESERT]
-----------------------------------
---@type TMobEntity
local entity = {}

local donnergugiPHTable =
{
    [ID.mob.DONNERGUGI - 10] = ID.mob.DONNERGUGI,
    [ID.mob.DONNERGUGI - 5]  = ID.mob.DONNERGUGI,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 110, 3, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, donnergugiPHTable, 10, 3600) -- 1 hour
end

return entity
