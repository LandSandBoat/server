-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Riparian Sahagin
-- Note: PH for Seww the Squidlimbed and Fyuu the Seabellow
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}
entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 806, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 807, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 808, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SEWW_THE_SQUIDLIMBED, 10, 7200) -- 2 hours
    xi.mob.phOnDespawn(mob, ID.mob.FYUU_THE_SEABELLOW, 10, 7200) -- 2 hours
end

return entity
