-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Mourning Crawler
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 726, 3, xi.regime.type.GROUNDS)
end

return entity
