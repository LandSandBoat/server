-----------------------------------
-- Area: South Gustaberg
--  Mob: Ornery Sheep
-- Note: PH for Carnero
-----------------------------------
local ID = zones[xi.zone.SOUTH_GUSTABERG]
-----------------------------------
local entity = {}

local carneroPHTable =
{
    [ID.mob.CARNERO - 2]  = ID.mob.CARNERO, -- 186.081 -39.990 -367.942
    [ID.mob.CARNERO - 1]  = ID.mob.CARNERO, -- 164.245 -39.900 -347.878
    [ID.mob.CARNERO + 11] = ID.mob.CARNERO, -- 160.304 -39.990 -460.400
    [ID.mob.CARNERO + 12] = ID.mob.CARNERO, -- 201.021 -39.904 -500.721
    [ID.mob.CARNERO + 25] = ID.mob.CARNERO, -- 277.891 -39.854 -413.354
    [ID.mob.CARNERO + 32] = ID.mob.CARNERO, -- 274.561 -39.972 -476.762
    [ID.mob.CARNERO + 33] = ID.mob.CARNERO, -- 275.135 -39.977 -477.840
    [ID.mob.CARNERO + 35] = ID.mob.CARNERO, -- 213.010 -59.983 -442.766
    [ID.mob.CARNERO + 36] = ID.mob.CARNERO, -- 211.745 -59.938 -441.313
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, carneroPHTable, 5, 1) -- Pure lottery
end

return entity
