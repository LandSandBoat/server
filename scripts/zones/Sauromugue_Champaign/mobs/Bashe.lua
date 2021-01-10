-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Bashe
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 273)
end

return entity
