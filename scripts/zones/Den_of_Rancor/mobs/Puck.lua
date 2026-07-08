-----------------------------------
-- Area: Den of Rancor
--  Mob: Puck
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 802, 2, xi.regime.type.GROUNDS)
end

return entity
