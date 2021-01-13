-----------------------------------
-- Area: Davoi
--   NM: Poisonhand Gnadgad
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 195)
end

return entity
