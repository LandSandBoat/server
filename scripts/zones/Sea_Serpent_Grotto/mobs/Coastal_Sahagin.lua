-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Coastal Sahagin
-- Note: PH for Denn the Orcavoiced
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
local entity = {}

local dennPHTable =
{
    [ID.mob.DENN_THE_ORCAVOICED - 3] = ID.mob.DENN_THE_ORCAVOICED, -- -102.127 9.797 -308.149
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 806, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 807, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 808, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, dennPHTable, 10, 7200) -- 2 hours
end

return entity
