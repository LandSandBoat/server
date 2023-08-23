-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Processionaire
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 724, 1, xi.regime.type.GROUNDS)
end

return entity
