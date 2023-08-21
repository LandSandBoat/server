-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Lagoon Sahagin
-- Note: PH for Yarr the Pearleyed and Novv the Whitehearted
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 806, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 807, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 808, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.YARR_THE_PEARLEYED_PH, 10, 3600) -- 1 hour
    xi.mob.phOnDespawn(mob, ID.mob.NOVV_THE_WHITEHEARTED_PH, 10, 7200) -- 2 hours
end

return entity
