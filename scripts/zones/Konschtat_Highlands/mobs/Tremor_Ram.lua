-----------------------------------
-- Area: Konschtat Highlands
--   NM: Tremor Ram
-----------------------------------
local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

local rampagingPHTable =
{
    [ID.mob.TREMMOR_RAM[1]] = ID.mob.RAMPAGING_RAM, -- -163.198 62.392 568.282
    [ID.mob.TREMMOR_RAM[2]] = ID.mob.RAMPAGING_RAM, -- 21 40 514
    [ID.mob.RAMPAGING_RAM]  = ID.mob.STEELFLEECE, -- Rampaging can't spawn if Steelfleece is up
}

local steelfacePHTable =
{
    [ID.mob.TREMMOR_RAM[1]] = ID.mob.STEELFLEECE, -- -163.198 62.392 568.282
    [ID.mob.TREMMOR_RAM[2]] = ID.mob.STEELFLEECE, -- 21 40 514
    [ID.mob.RAMPAGING_RAM]  = ID.mob.STEELFLEECE, -- 160 24 121
    [ID.mob.STEELFLEECE]    = ID.mob.RAMPAGING_RAM, -- Steelfleece can't spawn if Rampaging is up
}

entity.onMobDeath = function(mob, player, optParams)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    -- If Steelflect doesn't pop next, fallback onto Rampaging Ram
    if not xi.mob.phOnDespawn(mob, steelfacePHTable, 10, 75600) then -- 21 hours
        xi.mob.phOnDespawn(mob, rampagingPHTable, 10, 1200) -- 20 min
    end
end

return entity
