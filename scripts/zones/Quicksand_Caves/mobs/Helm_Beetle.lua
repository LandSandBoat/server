-----------------------------------
-- Area: Quicksand Caves
--  Mob: Helm Beetle
-- Note: PH for Diamond Daig
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 813, 1, xi.regime.type.GROUNDS)
end

return entity
