-----------------------------------
-- Area: La Theine Plateau
--   NM: Bloodtear Baldurf
-----------------------------------
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/draw_in'),
}
require('scripts/quests/tutorial')
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.LUMBERING_LAMBERT] = ID.mob.BLOODTEAR, -- -216 -8 -107
    [ID.mob.BLOODTEAR]         = ID.mob.LUMBERING_LAMBERT, -- Bloodtear can't spawn if Lumbering is up
}

entity.spawnPoints =
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

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIGHTY_STRIKES, hpp = math.random(90, 95), cooldown = 120 } -- "Special Attacks: ... Mighty Strikes (multiple times)"
        }
    })
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.THE_HORNSPLITTER)
    xi.tutorial.onMobDeath(player)
end

return entity
