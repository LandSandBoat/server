-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Rime Gigas
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 50, 1, xi.regime.type.FIELDS)
end

return entity
