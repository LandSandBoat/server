-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--   NM: Ah Puch
-----------------------------------
local ID = zones[xi.zone.OUTER_HORUTOTO_RUINS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -418.000, y = -1.000, z =  629.000 },
    { x = -419.000, y = -1.000, z =  570.000 },
    { x = -419.000, y = -1.000, z =  581.000 },
    { x = -418.000, y = -1.000, z =  590.000 },
    { x = -418.000, y = -1.000, z =  597.000 },
    { x = -417.000, y = -1.000, z =  640.000 },
    { x = -419.000, y = -1.000, z =  615.000 },
    { x = -417.000, y = -1.000, z =  661.000 }
}

entity.phList =
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
    xi.hunts.checkHunt(mob, player, 291)
    xi.magian.onMobDeath(mob, player, optParams, set{ 513 })
end

return entity
