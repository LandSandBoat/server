-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Wadi Crab
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 640, 2, xi.regime.type.GROUNDS)
end

return entity
