-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Bog Sahagin
-- Note: PH for Mouu the Waverider
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

local mouuPHTable =
{
    [ID.mob.MOUU_THE_WAVERIDER - 1] = ID.mob.MOUU_THE_WAVERIDER, -- -60.728 19.884 53.966
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 806, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 807, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 808, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, mouuPHTable, 10, 7200) -- 2 hours
end

return entity
