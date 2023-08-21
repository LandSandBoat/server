-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Royal Leech
-- Note: PH for Masan
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 804, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MASAN_PH, 10, 14400) -- 4 hours
end

return entity
