-----------------------------------
-- Area: Gusgen Mines
--  Mob: Myconid
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 683, 2, xi.regime.type.GROUNDS)
end

return entity
