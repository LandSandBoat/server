-----------------------------------
-- Area: The Boyahda Tree
--   NM: Unut
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 359)
end

return entity
