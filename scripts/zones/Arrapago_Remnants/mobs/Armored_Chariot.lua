-----------------------------------
-- Area: Arrapago Remnants
--   NM: Armored Chariot
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.SUN_CHARIOTEER)
end
