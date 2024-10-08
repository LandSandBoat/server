-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Viseclaw
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 726, 1, xi.regime.type.GROUNDS)
end

return entity
