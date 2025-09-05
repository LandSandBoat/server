-----------------------------------
-- Area: Garlaige Citadel (164)
--   NM: Hovering Hotpot
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  158.000, y =  0.000, z =  20.000 }
}

entity.phList =
{
    [ID.mob.HOVERING_HOTPOT - 5] = ID.mob.HOVERING_HOTPOT, -- Fallen_Major: 182.157 -0.012 29.941
    [ID.mob.HOVERING_HOTPOT - 3] = ID.mob.HOVERING_HOTPOT, -- Fallen_Mage:  188.229 -0.018 20.151
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 301)
    xi.magian.onMobDeath(mob, player, optParams, set{ 7, 517, 896 })
end

return entity
