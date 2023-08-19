-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Leecher
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 605, 1, xi.regime.type.GROUNDS)
end

return entity
