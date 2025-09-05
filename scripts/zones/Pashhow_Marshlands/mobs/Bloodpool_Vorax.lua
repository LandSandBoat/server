-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Bloodpool Vorax
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -351.884, y =  24.014, z =  513.531 }
}

entity.phList =
{
    [ID.mob.BLOODPOOL_VORAX - 5] = ID.mob.BLOODPOOL_VORAX, -- -351.884 24.014 513.531
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 211)
    xi.magian.onMobDeath(mob, player, optParams, set{ 216 })
end

return entity
