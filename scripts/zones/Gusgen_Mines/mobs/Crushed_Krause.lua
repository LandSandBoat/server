-----------------------------------
-- Area: Gusgen Mines
--   NM: Crushed Krause
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 231)
end

return entity
