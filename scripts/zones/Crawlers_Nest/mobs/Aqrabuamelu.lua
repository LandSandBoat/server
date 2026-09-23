-----------------------------------
-- Area: Crawlers' Nest
--   NM: Aqrabuamelu
-----------------------------------
---@type TMobEntity
local entity = {}

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
    mob:setRespawnTime(math.randomInt(7200, 7800)) -- 120 to 130 min
end

return entity
