------------------------------
-- Area: Crawlers Nest [S]
--   NM: Abatwa
------------------------------
require("scripts/globals/hunts")
------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 514)
end

return entity
