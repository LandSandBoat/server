-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Mugger
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 604, 1, xi.regime.type.GROUNDS)
end

return entity
