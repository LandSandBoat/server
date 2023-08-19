-----------------------------------
-- Area: The Boyahda Tree
--   NM: Ellyllon
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 357)
end

return entity
