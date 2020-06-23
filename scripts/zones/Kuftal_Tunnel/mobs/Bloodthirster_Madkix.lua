-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Bloodthirster Madkix
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 421)
end
