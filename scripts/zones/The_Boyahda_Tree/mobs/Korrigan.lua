-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Korrigan
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 722, 1, xi.regime.type.GROUNDS)
end

return entity
