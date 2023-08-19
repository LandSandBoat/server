-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Trimmer
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 646, 1, xi.regime.type.GROUNDS)
end

return entity
