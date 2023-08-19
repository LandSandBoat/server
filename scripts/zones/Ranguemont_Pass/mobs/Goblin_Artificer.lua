-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Artificer
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 609, 2, xi.regime.type.GROUNDS)
end

return entity
