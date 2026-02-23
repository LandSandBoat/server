-----------------------------------
-- Area: Abyssea - Misareaux
--   NM: Kutharei
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.KUTHAREI_UNHORSER)
    end
end

return entity
