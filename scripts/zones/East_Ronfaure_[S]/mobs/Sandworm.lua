-----------------------------------
-- Area: East Ronfaure [S]
--  Mob: Sandworm
-- Note:  Title Given if Sandworm does not Doomvoid
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.SANDWORM_WRANGLER)
end

return entity
