-----------------------------------
-- Area: The Eldieme Necropolis
-- NM: Skull of Envy
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 189)
    player:addTitle(xi.title.SKULLCRUSHER)
end

return entity
