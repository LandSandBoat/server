-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Giant Spider
-- Note: PH for Dune Widow
-----------------------------------
local ID = zones[xi.zone.EASTERN_ALTEPA_DESERT]
-----------------------------------
---@type TMobEntity
local entity = {}

local duneWidowPHTable =
{
    [ID.mob.DUNE_WIDOW - 1] = ID.mob.DUNE_WIDOW,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 109, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, duneWidowPHTable, 10, math.random(3600, 18000)) -- 1 to 5 hours
end

return entity
