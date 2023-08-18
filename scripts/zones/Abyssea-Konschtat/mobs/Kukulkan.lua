-----------------------------------
-- Area: Abyssea - Konschtat (15)
--   NM: Kukulkan
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.KUKULKAN_DEFANGER)
end

return entity
