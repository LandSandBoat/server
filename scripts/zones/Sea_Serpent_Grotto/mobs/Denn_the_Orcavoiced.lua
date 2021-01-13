-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Denn the Orcavoiced
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 379)
end

return entity
