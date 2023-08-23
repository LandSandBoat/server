-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Gambler
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 604, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 605, 2, xi.regime.type.GROUNDS)
end

return entity
