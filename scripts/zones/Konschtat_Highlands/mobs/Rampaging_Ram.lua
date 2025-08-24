-----------------------------------
-- Area: Konschtat Highlands
--   NM: Rampaging Ram
-- Note: PH for Steelfleece, spawned by Tremor Ram
-----------------------------------
local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TREMOR_RAM[1]] = ID.mob.RAMPAGING_RAM, -- -163.198 62.392 568.282
    [ID.mob.TREMOR_RAM[2]] = ID.mob.RAMPAGING_RAM, -- 21 40 514
    [ID.mob.RAMPAGING_RAM] = ID.mob.STEELFLEECE, -- Rampaging can't spawn if Steelfleece is up
}

entity.spawnPoints =
{
    { x = 160.000, y = 24.000, z = 121.000 },
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 205)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    local params =
    {
        doNotEnablePhSpawn = true,
    }
    xi.mob.phOnDespawn(mob, ID.mob.STEELFLEECE, 10, 75600, params) -- 21 hours minimum, do not re-enable rampaging ram spawn after killing steelfleece
end

return entity
