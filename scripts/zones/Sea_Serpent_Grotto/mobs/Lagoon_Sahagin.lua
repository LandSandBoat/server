-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Lagoon Sahagin
-- Note: PH for Yarr the Pearleyed and Novv the Whitehearted
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 806, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 807, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 808, 1, xi.regime.type.GROUNDS)
end

return entity
