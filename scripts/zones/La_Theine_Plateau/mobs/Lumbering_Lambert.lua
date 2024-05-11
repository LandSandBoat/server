-----------------------------------
-- Area: La Theine Plateau
--  Mob: Lumbering Lambert
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
local entity = {}

local bloodtearPHTable =
{
    [ID.mob.BATTERING_RAM[1]]  = ID.mob.BLOODTEAR, -- -372 -16 -6
    [ID.mob.BATTERING_RAM[2]]  = ID.mob.BLOODTEAR, -- -117 -1 -136
    [ID.mob.LUMBERING_LAMBERT] = ID.mob.BLOODTEAR, -- -216 -8 -107
    [ID.mob.BLOODTEAR]         = ID.mob.LUMBERING_LAMBERT, -- Bloodtear can't spawn if Lumbering is up
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 156)
    xi.tutorial.onMobDeath(player)
    xi.magian.onMobDeath(mob, player, optParams, set{ 579 })
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, bloodtearPHTable, 10, 75600) -- 21 hours
end

return entity
