-----------------------------------
-- Area: Quicksand Caves
--   NM: Nussknacker
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  195.000, y =  1.000, z =  5.000 }
}

entity.phList =
{
    [ID.mob.NUSSKNACKER - 7] = ID.mob.NUSSKNACKER, -- 189 2 4
    [ID.mob.NUSSKNACKER - 6] = ID.mob.NUSSKNACKER, -- 200 2 -4
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 435)
end

return entity
