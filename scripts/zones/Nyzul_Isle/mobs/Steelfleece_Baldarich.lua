-----------------------------------
-- Area: Nyzul Isle
--   NM: Steelfleece Baldarich
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.THE_HORNSPLITTER)
end

return entity
