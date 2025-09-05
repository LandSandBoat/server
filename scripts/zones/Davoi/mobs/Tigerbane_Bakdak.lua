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

entity.spawnPoints =
{
    { x =  174.212, y =  2.068, z = -20.285 }
}

entity.phList =
{
    [ID.mob.TIGERBANE_BAKDAK - 4] = ID.mob.TIGERBANE_BAKDAK, -- 158 -0.662 -18
    [ID.mob.TIGERBANE_BAKDAK - 3] = ID.mob.TIGERBANE_BAKDAK, -- 153.880 -0.769 -18.092
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 193)
end

return entity
