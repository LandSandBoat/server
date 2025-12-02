-----------------------------------
-- Area: Beaucedine Glacier
--   NM: Calcabrina
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
    { x = -224.000, y = -80.000, z =  -130.000 },
    { x =  134.000, y = -21.200, z =   133.000 },
    { x =  297.000, y =  20.000, z =   446.000 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 6000)) -- When server restarts, reset timer

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.MAGIC, xi.detects.SCENT)) -- TODO: Verify scent tracking on retail.
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 313)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 6000)) -- 90 to 100 minutes
end

return entity
