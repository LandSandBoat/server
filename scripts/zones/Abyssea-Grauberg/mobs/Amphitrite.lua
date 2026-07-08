-----------------------------------
-- Area: Abyssea - Grauberg
--   NM: Amphitrite
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.AMPHITRITE_SHUCKER)
    end
end

return entity
