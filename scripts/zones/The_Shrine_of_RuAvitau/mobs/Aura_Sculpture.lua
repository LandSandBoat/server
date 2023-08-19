-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Aura Sculpture
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 749, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 754, 1, xi.regime.type.GROUNDS)
end

return entity
