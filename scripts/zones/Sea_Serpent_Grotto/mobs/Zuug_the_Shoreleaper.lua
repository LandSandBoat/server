-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Zuug the Shoreleaper
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 382)
end

return entity
