-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Targe Beetle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 661, 2, xi.regime.type.GROUNDS)
end

return entity
