-----------------------------------
-- Area: Meriphataud Mountains [S]
--  Mob: Sandworm
-- Note: Title Given if Sandworm does not Doomvoid
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.SANDWORM_WRANGLER)
end

return entity
