-----------------------------------
-- Area: Jugner Forest
--  Mob: Stag Beetle
-- Note: PH for Panzer Percival
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 12, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 13, 2, xi.regime.type.FIELDS)
end

return entity
