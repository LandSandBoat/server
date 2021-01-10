-----------------------------------
-- Area: Bhaflau Remnants
--  Mob: Long-Bowed Chariot
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.COMET_CHARIOTEER)
end

return entity
