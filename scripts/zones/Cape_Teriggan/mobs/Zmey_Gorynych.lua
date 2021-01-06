------------------------------
-- Area: Cape Teriggan
--   NM: Zmey Gorynych
------------------------------
require("scripts/globals/hunts")
------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 406)
end

return entity
