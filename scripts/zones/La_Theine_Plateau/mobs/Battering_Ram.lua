-----------------------------------
-- Area: La Theine Plateau
--  Mob: Battering Ram
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
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

entity.onMobDeath = function(mob, player, optParams)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    if not xi.mob.phOnDespawn(mob, bloodtearPHTable, 10, 75600) then -- 21 hours
        xi.mob.phOnDespawn(mob, lumberingLambertPHTable, 10, 1200) -- 20 min
    end
end

return entity
