-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Ghoul
-- Note: Place holder for Ah Puch
-----------------------------------
local ID = zones[xi.zone.OUTER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}

local ahPuchPHTable =
{
    [ID.mob.AH_PUCH - 10] = ID.mob.AH_PUCH, -- -418, -1, 629
    [ID.mob.AH_PUCH - 9]  = ID.mob.AH_PUCH, -- -419, -1, 570
    [ID.mob.AH_PUCH - 8]  = ID.mob.AH_PUCH, -- -419, -1, 581
    [ID.mob.AH_PUCH - 7]  = ID.mob.AH_PUCH, -- -418, -1, 590
    [ID.mob.AH_PUCH - 6]  = ID.mob.AH_PUCH, -- -418, -1, 597
    [ID.mob.AH_PUCH - 5]  = ID.mob.AH_PUCH, -- -417, -1, 640
    [ID.mob.AH_PUCH - 4]  = ID.mob.AH_PUCH, -- -419, -1, 615
    [ID.mob.AH_PUCH - 3]  = ID.mob.AH_PUCH, -- -417, -1, 661
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ahPuchPHTable, 20, 3600) -- 1 to 3 hours
end

return entity
