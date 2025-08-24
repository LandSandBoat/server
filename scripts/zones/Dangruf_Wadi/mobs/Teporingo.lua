-----------------------------------
-- Area: Dangruf Wadi
--   NM: Teporingo
-----------------------------------
local ID = zones[xi.zone.DANGRUF_WADI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TEPORINGO - 1] = ID.mob.TEPORINGO,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 223)
    xi.magian.onMobDeath(mob, player, optParams, set{ 776 })
end

return entity
