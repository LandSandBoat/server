-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Dark Elemental
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 750, 1, xi.regime.type.GROUNDS)
end

return entity
