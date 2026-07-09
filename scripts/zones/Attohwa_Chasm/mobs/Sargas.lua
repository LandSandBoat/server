-----------------------------------
-- Area: Attohwa Chasm
--   NM: Sargas
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.SHOCK_SPIKES, { power = 50, origin = mob })
    mob:getStatusEffect(xi.effect.SHOCK_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 40)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, { chance = 65, duration = math.randomInt(5, 15) })
end

entity.onSpikesDamage = function(mob, target, damage)
    local pTable =
    {
        basePower       = damage,
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.THUNDER,
        actorStat       = xi.mod.INT,
        canMAB          = true,
        canResist       = true,
        canResistExtra  = true,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 279)
end

entity.onMobDespawn = function(mob)
    -- xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(7200, 10800)) -- 2 to 3 hrs
end

return entity
