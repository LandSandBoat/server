-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Mugger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 604, 1, xi.regime.type.GROUNDS)
end

return entity
