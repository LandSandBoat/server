-----------------------------------
-- Area: Crawlers' Nest
--   NM: Aqrabuamelu
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -140.000, y = -1.500, z =  209.000 },
    { x = -221.000, y = -0.500, z =  205.000 },
    { x = -229.000, y = -0.500, z =  191.000 },
    { x = -245.000, y = -0.250, z =  196.000 },
    { x = -227.000, y = -0.900, z =  224.000 },
    { x = -210.000, y = -0.500, z =  232.000 },
    { x = -219.000, y = -0.500, z =  214.000 },
    { x = -206.000, y = -0.500, z =  212.000 },
    { x = -221.000, y = -0.500, z =  205.000 },
    { x = -245.000, y = -0.250, z =  196.000 },
    { x = -188.000, y = -0.500, z =  209.000 },
    { x = -221.000, y = -0.500, z =  205.000 },
    { x = -229.000, y = -0.500, z =  191.000 },
    { x = -245.000, y = -0.250, z =  196.000 },
    { x = -227.000, y = -0.900, z =  224.000 },
    { x = -210.000, y = -0.500, z =  232.000 },
    { x = -219.000, y = -0.500, z =  214.000 },
    { x = -206.000, y = -0.500, z =  212.000 },
    { x = -227.000, y = -0.900, z =  224.000 },
    { x = -140.000, y = -1.500, z =  209.000 },
    { x = -183.000, y = -0.900, z =  206.000 },
    { x = -221.000, y = -0.500, z =  205.000 },
    { x = -229.000, y = -0.500, z =  191.000 },
    { x = -245.000, y = -0.250, z =  196.000 },
    { x = -227.000, y = -0.900, z =  224.000 },
    { x = -210.000, y = -0.500, z =  232.000 },
    { x = -219.000, y = -0.500, z =  214.000 },
    { x = -206.000, y = -0.500, z =  212.000 },
    { x = -210.000, y = -0.500, z =  232.000 },
    { x = -188.000, y = -0.500, z =  209.000 },
    { x = -194.000, y = -1.250, z =  215.000 },
    { x = -221.000, y = -0.500, z =  205.000 },
    { x = -229.000, y = -0.500, z =  191.000 },
    { x = -245.000, y = -0.250, z =  196.000 },
    { x = -227.000, y = -0.900, z =  224.000 },
    { x = -210.000, y = -0.500, z =  232.000 },
    { x = -219.000, y = -0.500, z =  214.000 },
    { x = -206.000, y = -0.500, z =  212.000 },
    { x = -219.000, y = -0.500, z =  214.000 },
    { x = -183.000, y = -0.900, z =  206.000 },
    { x = -140.000, y = -1.500, z =  209.000 },
    { x = -221.000, y = -0.500, z =  205.000 },
    { x = -229.000, y = -0.500, z =  191.000 },
    { x = -245.000, y = -0.250, z =  196.000 },
    { x = -227.000, y = -0.900, z =  224.000 },
    { x = -210.000, y = -0.500, z =  232.000 },
    { x = -219.000, y = -0.500, z =  214.000 },
    { x = -206.000, y = -0.500, z =  212.000 },
    { x = -206.000, y = -0.500, z =  212.000 },
    { x = -194.000, y = -1.250, z =  215.000 }
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, { power = 50, origin = mob })
    mob:getStatusEffect(xi.effect.ICE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onSpikesDamage = function(mob, target, damage)
    local pTable =
    {
        basePower       = damage,
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.ICE,
        actorStat       = xi.mod.INT,
        canMAB          = true,
        canResist       = true,
        canResistExtra  = true,
    }

    return xi.combat.action.executeSpikesDamage(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 238)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(7200, 7800)) -- 120 to 130 min
end

return entity
