-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Digger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 814, 1, xi.regime.type.GROUNDS)
end

return entity
