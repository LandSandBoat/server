-----------------------------------
-- Area: Zhayolm Remnants
--   NM: Battleclad Chariot
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.STAR_CHARIOTEER)
end
