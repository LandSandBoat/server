-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Hecteyes
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 606, 2, xi.regime.type.GROUNDS)
end

return entity
