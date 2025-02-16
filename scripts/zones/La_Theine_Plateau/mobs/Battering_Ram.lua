-----------------------------------
-- Area: La Theine Plateau
--  Mob: Battering Ram
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

local lumberingLambertPHTable =
{
    [ID.mob.BATTERING_RAM[1]]  = ID.mob.LUMBERING_LAMBERT, -- -372 -16 -6
    [ID.mob.BATTERING_RAM[2]]  = ID.mob.LUMBERING_LAMBERT, -- -117 -1 -136
    [ID.mob.LUMBERING_LAMBERT] = ID.mob.BLOODTEAR, -- Lumbering can't spawn if Bloodtear is up
}

local bloodtearPHTable =
{
    [ID.mob.BATTERING_RAM[1]]  = ID.mob.BLOODTEAR, -- -372 -16 -6
    [ID.mob.BATTERING_RAM[2]]  = ID.mob.BLOODTEAR, -- -117 -1 -136
    [ID.mob.LUMBERING_LAMBERT] = ID.mob.BLOODTEAR, -- -216 -8 -107
    [ID.mob.BLOODTEAR]         = ID.mob.LUMBERING_LAMBERT, -- Bloodtear can't spawn if Lumbering is up
}

local sheepNMSpawnPoints =
{
    { x = 79.000,   y = 8.000,   z = -241.000 },
    { x = 159.000,  y = 7.000,   z = -216.000 },
    { x = 64.000,   y = 8.000,   z = -165.000 },
    { x = -23.000,  y = 7.000,   z = -141.000 },
    { x = -90.000,  y = 0.000,   z = -97.000  },
    { x = -97.000,  y = 7.000,   z = -307.000 },
    { x = -41.000,  y = 8.000,   z = -264.000 },
    { x = -155.000, y = -7.000,  z = -187.000 },
    { x = -207.000, y = -7.000,  z = -132.000 },
    { x = -266.000, y = -7.000,  z = -49.000  },
    { x = -331.000, y = -15.000, z = -112.000 },
    { x = -320.000, y = -15.000, z = -14.000  },
    { x = -343.000, y = -7.000,  z = 50.000   },
}

entity.onMobDeath = function(mob, player, optParams)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    local params = { }
    params.spawnPoints = sheepNMSpawnPoints

    if not xi.mob.phOnDespawn(mob, bloodtearPHTable, 10, 75600, params) then -- 21 hours
        xi.mob.phOnDespawn(mob, lumberingLambertPHTable, 10, 1200, params) -- 20 min
    end
end

return entity
