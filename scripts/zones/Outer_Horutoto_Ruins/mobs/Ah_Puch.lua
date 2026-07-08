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
    [ID.mob.AH_PUCH - 7]  = ID.mob.AH_PUCH, -- Confirmed on retail
    [ID.mob.AH_PUCH - 3]  = ID.mob.AH_PUCH, -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 291)
    xi.magian.onMobDeath(mob, player, optParams, set{ 513 })
end

return entity
