-----------------------------------
-- Area: Abyssea - Konschtat (15)
--   NM: Kukulkan
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.KUKULKAN_DEFANGER)
end

return entity
