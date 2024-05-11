-----------------------------------
-- Area: Konschtat Highlands
--   NM: Rampaging Ram
-----------------------------------
local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

local steelfacePHTable =
{
    [ID.mob.TREMMOR_RAM[1]] = ID.mob.STEELFLEECE, -- -163.198 62.392 568.282
    [ID.mob.TREMMOR_RAM[2]] = ID.mob.STEELFLEECE, -- 21 40 514
    [ID.mob.RAMPAGING_RAM]  = ID.mob.STEELFLEECE, -- 160 24 121
    [ID.mob.STEELFLEECE]    = ID.mob.RAMPAGING_RAM, -- Steelfleece can't spawn if Rampaging is up
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 205)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, steelfacePHTable, 10, 75600) -- 21 hours minimum
end

return entity
