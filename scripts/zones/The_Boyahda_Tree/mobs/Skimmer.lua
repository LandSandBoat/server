-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Skimmer
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 723, 1, xi.regime.type.GROUNDS)
end

return entity
