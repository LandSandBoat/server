-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Seww the Squidlimbed
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 374)
end
