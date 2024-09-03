-----------------------------------
-- Area: Gusgen Mines
--  Mob: Gallinipper
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 684, 2, xi.regime.type.GROUNDS)
end

return entity
