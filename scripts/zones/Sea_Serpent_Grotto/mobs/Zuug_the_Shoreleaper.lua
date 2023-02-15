-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Zuug the Shoreleaper
-----------------------------------
require("scripts/globals/hunts")
mixins = 
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/claim_shield")
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 382)
end

return entity
