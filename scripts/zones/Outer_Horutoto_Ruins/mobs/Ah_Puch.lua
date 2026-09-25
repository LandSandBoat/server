-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--   NM: Ah Puch
-----------------------------------
local ID = zones[xi.zone.OUTER_HORUTOTO_RUINS]
-----------------------------------
---@type TMobEntity
local entity = {}

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
