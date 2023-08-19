-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Wadi Hare
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 641, 1, xi.regime.type.GROUNDS)
end

return entity
