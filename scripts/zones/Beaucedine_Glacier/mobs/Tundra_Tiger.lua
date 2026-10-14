-----------------------------------
-- Area: Beaucedine Glacier (111)
--  Mob: Tundra Tiger
-- Note: PH for Nue, Kirata
-----------------------------------
---@type TMobEntity
local entity = {}
entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 46, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 47, 1, xi.regime.type.FIELDS)
end

return entity
