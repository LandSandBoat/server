-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Autarch
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.MAGIC, xi.detects.SCENT)) -- TODO: Verify scent tracking on retail.
    mob:addStatusEffect(xi.effect.SHOCK_SPIKES, { power = 40, origin = mob })
    mob:getStatusEffect(xi.effect.SHOCK_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.ATT, 50)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 25)
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
    xi.hunts.checkHunt(mob, player, 333)
end

entity.onMobDespawn = function(mob)
    -- xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(1800, 10800)) -- 30 minutes to 3 hrs
end

return entity
