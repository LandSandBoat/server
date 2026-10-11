-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Giant Lobber
-- Note: PH for Rhoitos and Polybotes
-----------------------------------
---@type TMobEntity
local entity = {}
entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 783, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 784, 2, xi.regime.type.GROUNDS)
end

return entity
