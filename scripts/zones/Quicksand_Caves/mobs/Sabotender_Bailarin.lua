-----------------------------------
-- Area: Quicksand Caves
--   NM: Sabotender Bailarin
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.SABOTENDER_BAILARIN - 3] = ID.mob.SABOTENDER_BAILARIN, -- 604 -5.5 -680
    [ID.mob.SABOTENDER_BAILARIN - 2] = ID.mob.SABOTENDER_BAILARIN, -- 600 -5.5 -673
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 9000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 9000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 433)
end

return entity
