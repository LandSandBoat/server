-----------------------------------
-- Area: The Boyahda Tree
--   NM: Ellyllon
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 357)
end

return entity
