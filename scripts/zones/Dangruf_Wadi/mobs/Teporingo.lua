-----------------------------------
-- Area: Dangruf Wadi
--   NM: Teporingo
-----------------------------------
local ID = zones[xi.zone.DANGRUF_WADI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -189.000, y =  3.000, z =  79.000 }
}

entity.phList =
{
    [ID.mob.TEPORINGO - 1] = ID.mob.TEPORINGO,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 223)
    xi.magian.onMobDeath(mob, player, optParams, set{ 776 })
end

return entity
