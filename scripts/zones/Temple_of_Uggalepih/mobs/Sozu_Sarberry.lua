-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Sozu Sarberry
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  94.330, y =  0.000, z = -14.457 }
}

entity.phList =
{
    [ID.mob.SOZU_SARBERRY - 3] = ID.mob.SOZU_SARBERRY, -- 89 0.499 -23
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 388)
end

return entity
