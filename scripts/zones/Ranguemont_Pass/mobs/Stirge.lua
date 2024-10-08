-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Stirge
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 606, 1, xi.regime.type.GROUNDS)
end

return entity
