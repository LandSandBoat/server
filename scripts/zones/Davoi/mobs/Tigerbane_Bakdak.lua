-----------------------------------
-- Area: Davoi
--   NM: Tigerbane Bakdak
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TIGERBANE_BAKDAK - 1] = ID.mob.TIGERBANE_BAKDAK, -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 193)
end

return entity
