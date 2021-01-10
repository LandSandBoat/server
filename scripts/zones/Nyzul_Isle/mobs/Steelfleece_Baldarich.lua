-----------------------------------
-- Area: Nyzul Isle
--   NM: Steelfleece Baldarich
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.THE_HORNSPLITTER)
end

return entity
