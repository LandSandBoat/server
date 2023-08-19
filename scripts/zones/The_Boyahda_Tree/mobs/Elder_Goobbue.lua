-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Elder Goobbue
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 722, 2, xi.regime.type.GROUNDS)
end

return entity
