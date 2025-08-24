-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Worr the Clawfisted
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.WORR_THE_CLAWFISTED - 3] = ID.mob.WORR_THE_CLAWFISTED, -- -308.649 17.344 -52.316
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 381)
end

return entity
