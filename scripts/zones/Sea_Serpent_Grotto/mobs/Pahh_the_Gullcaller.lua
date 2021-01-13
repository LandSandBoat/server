-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Pahh the Gullcaller
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 375)
end

return entity
