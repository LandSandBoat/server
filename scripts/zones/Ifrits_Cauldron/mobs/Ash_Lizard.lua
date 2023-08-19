-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Ash Lizard
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 761, 1, xi.regime.type.GROUNDS)
end

return entity
