-----------------------------------
-- Area: Tahrongi Canyon
--   NM: Herbage Hunter
-----------------------------------
local ID = zones[xi.zone.TAHRONGI_CANYON]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -127.000, y =  30.000, z =  466.000 },
    { x = -134.000, y =  24.000, z =  441.000 },
    { x = -144.000, y =  24.000, z =  460.000 }
}

entity.phList =
{
    [ID.mob.HERBAGE_HUNTER - 1] = ID.mob.HERBAGE_HUNTER, -- -119.301, 24.087, 448.636
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 45)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 259)
    xi.magian.onMobDeath(mob, player, optParams, set{ 431 })
end

return entity
