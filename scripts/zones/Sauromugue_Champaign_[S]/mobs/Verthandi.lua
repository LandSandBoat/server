-----------------------------------
-- Area: Sauromugue Champaign [S]
--  VNM: Verthandi
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.VERTHANDI_ENSNARER)
end
