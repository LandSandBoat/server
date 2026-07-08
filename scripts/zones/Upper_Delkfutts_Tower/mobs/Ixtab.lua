-----------------------------------
-- Area: Upper Delkfutts Tower
--   NM: Ixtab
-----------------------------------
local ID = zones[xi.zone.UPPER_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -360.000, y = -175.500, z =  80.000 }
}

entity.phList =
{
    [ID.mob.IXTAB[1] - 1] = ID.mob.IXTAB[1], -- Confirmed on retail
    [ID.mob.IXTAB[2] - 1] = ID.mob.IXTAB[2], -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 9)
    mob:setMod(xi.mod.BIND_RES_RANK, 10)
    mob:setMod(xi.mod.BLIND_RES_RANK, 10)
    mob:setMod(xi.mod.STUN_RES_RANK, 10)
    mob:setMod(xi.mod.DARK_RES_RANK, 10)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 332)
end

return entity
