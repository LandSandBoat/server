-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Spring Sahagin
-- Note: PH for Wuur the Sandcomber
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
local entity = {}

local wuurPHTable =
{
    [ID.mob.WUUR_THE_SANDCOMBER - 4] = ID.mob.WUUR_THE_SANDCOMBER, -- 14.044 0.494 109.487
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 806, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 807, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 808, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, wuurPHTable, 10, 7200) -- 2 hours
end

return entity
