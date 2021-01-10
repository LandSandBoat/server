-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Cwn Cyrff
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 191)
end

return entity
