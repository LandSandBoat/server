-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Marsh Sahagin
-- Note: PH for Worr the Clawfisted and Voll the Sharkfinned
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 806, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 807, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 808, 1, xi.regime.type.GROUNDS)
end

return entity
