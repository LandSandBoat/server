-----------------------------------
-- Area: Lufaise Meadows
--   NM: Megalobugard
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -175.852, y = -7.811, z =  22.823 }
}

entity.phList =
{
    [ID.mob.MEGALOBUGARD - 21] = ID.mob.MEGALOBUGARD, -- -137.168 -15.390 91.016
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.REGEN, 25)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 439)
    xi.magian.onMobDeath(mob, player, optParams, set{ 154, 368, 582 })
end

return entity
