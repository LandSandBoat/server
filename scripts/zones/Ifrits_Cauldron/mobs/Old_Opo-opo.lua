-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Old Opo-opo
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 756, 1, xi.regime.type.GROUNDS)
end

return entity
