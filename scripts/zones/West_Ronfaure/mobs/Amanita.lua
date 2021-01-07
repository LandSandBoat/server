-----------------------------------
-- Area: West Ronfaure
--   NM: Amanita
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 149)
end

return entity
