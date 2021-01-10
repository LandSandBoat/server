------------------------------
-- Area: Crawlers Nest [S]
--   NM: Lugh
------------------------------
require("scripts/globals/hunts")
------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 516)
end

return entity
