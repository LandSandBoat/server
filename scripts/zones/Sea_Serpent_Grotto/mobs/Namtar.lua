-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Namtar
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.NAMTAR - 6] = ID.mob.NAMTAR, -- -128.762 9.595 164.996
    [ID.mob.NAMTAR - 1] = ID.mob.NAMTAR, -- -157.606 9.905 168.518
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 369)
    xi.regime.checkRegime(player, mob, 805, 2, xi.regime.type.GROUNDS)
    xi.magian.onMobDeath(mob, player, optParams, set{ 366 })
end

return entity
