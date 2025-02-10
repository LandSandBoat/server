-----------------------------------
-- Area: The Eldieme Necropolis
-- NM: Skull of Wrath
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 190)
    player:addTitle(xi.title.SKULLCRUSHER)
end

return entity
