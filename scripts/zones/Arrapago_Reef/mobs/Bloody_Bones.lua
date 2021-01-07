------------------------------
-- Area: Arrapago Reef
--   NM: Bloody Bones
------------------------------
require("scripts/globals/hunts")
------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 472)
end

return entity
