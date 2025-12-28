-----------------------------------
-- Area: Beadeaux (254)
--   NM: Da'Dha Hundredmask
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.DA_DHA_HUNDREDMASK - 1] = ID.mob.DA_DHA_HUNDREDMASK,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 241)
end

return entity
