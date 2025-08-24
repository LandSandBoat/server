-----------------------------------
-- Area: Buburimu Peninsula (118)
--  Mob: Helldiver
-----------------------------------
local ID = zones[xi.zone.BUBURIMU_PENINSULA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.HELLDIVER - 1] = ID.mob.HELLDIVER, -- 509.641 0.151 -267.664
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 262)
    xi.magian.onMobDeath(mob, player, optParams, set{ 69 })
end

return entity
