-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Ooze
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 603, 2, xi.regime.type.GROUNDS)
end

return entity
