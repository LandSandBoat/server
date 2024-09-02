-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Delta Sahagin
-- Note: PH for Zuug the Shoreleaper
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

local zuugPHTable =
{
    [ID.mob.ZUUG_THE_SHORELEAPER - 4] = ID.mob.ZUUG_THE_SHORELEAPER,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 806, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 807, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 808, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, zuugPHTable, 10, 7200) -- 2 hours
end

return entity
