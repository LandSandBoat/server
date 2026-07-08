-----------------------------------
-- Area: Quicksand Caves
--   NM: Diamond Daig
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -81.000, y = -0.500, z = -217.000 }
}

entity.phList =
{
    [ID.mob.DIAMOND_DAIG + 3]  = ID.mob.DIAMOND_DAIG, -- Confirmed on retail
    [ID.mob.DIAMOND_DAIG + 6]  = ID.mob.DIAMOND_DAIG, -- Confirmed on retail
    [ID.mob.DIAMOND_DAIG + 9]  = ID.mob.DIAMOND_DAIG, -- Confirmed on retail
    [ID.mob.DIAMOND_DAIG + 12] = ID.mob.DIAMOND_DAIG, -- Confirmed on retail
    [ID.mob.DIAMOND_DAIG + 16] = ID.mob.DIAMOND_DAIG, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1200)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 428)
end

return entity
