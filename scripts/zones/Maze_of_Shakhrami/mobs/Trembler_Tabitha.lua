------------------------------
-- Area: Maze of Shakhrami
--   NM: Trembler Tabitha
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 293)
end
