-----------------------------------
-- Area: Arrapago Reef
--   NM: Bloody Bones
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 472)
end

return entity
