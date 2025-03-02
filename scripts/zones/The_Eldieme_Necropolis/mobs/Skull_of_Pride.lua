-----------------------------------
-- Area: The Eldieme Necropolis
-- NM: Skull of Pride
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 188)
    player:addTitle(xi.title.SKULLCRUSHER)
end

return entity
