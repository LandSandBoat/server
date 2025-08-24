-----------------------------------
-- Area: Davoi
--   NM: Steelbiter Gudrud
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.STEELBITER_GUDRUD - 7] = ID.mob.STEELBITER_GUDRUD, -- 252.457 3.501 -248.655
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 194)
end

return entity
