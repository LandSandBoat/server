-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Lagoon Sahagin
-- Note: PH for Yarr the Pearleyed and Novv the Whitehearted
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

local yarrPHTable =
{
    [ID.mob.YARR_THE_PEARLEYED - 2] = ID.mob.YARR_THE_PEARLEYED, -- 1.654 19.914 -113.913
}

local novvPHTable =
{
    [ID.mob.NOVV_THE_WHITEHEARTED - 1] = ID.mob.NOVV_THE_WHITEHEARTED,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 806, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 807, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 808, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, yarrPHTable, 10, 3600) -- 1 hour
    xi.mob.phOnDespawn(mob, novvPHTable, 10, 7200) -- 2 hours
end

return entity
