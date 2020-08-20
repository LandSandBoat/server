-----------------------------------
-- Area: Palborough Mines
--   NM: Zi'Ghi Boneeater
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/hunts")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 220)
end
