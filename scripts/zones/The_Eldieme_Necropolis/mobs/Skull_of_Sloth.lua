-----------------------------------
-- Area: The Eldieme Necropolis
-- NM: Skull of Sloth
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.SKULLCRUSHER)
        xi.hunts.checkHunt(mob, player, 186)
    end
end

return entity
