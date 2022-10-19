-----------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Sandworm
-- Note: Title Given if Sandworm does not Doomvoid
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.SANDWORM_WRANGLER)
end

return entity
