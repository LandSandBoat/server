-----------------------------------
-- Area: Beaucedine Glacier
--   NM: Humbaba
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  219.250, y =   0.500, z =  107.140 },
    { x =  246.720, y =   0.130, z = -200.300 },
    { x = -116.850, y =   0.310, z = -370.300 },
    { x =   90.330, y = -39.700, z =   38.400 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(3600, 4200)) -- When server restarts, reset timer

    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, { power = 50, origin = mob })
    mob:getStatusEffect(xi.effect.ICE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
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

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 314)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(3600, 4200)) -- 60 to 70 minutes
end

return entity
