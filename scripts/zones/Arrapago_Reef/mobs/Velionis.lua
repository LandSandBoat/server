-----------------------------------
-- Area: Arrapago Reef
--  ZNM: Velionis
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, { power = 250, origin = mob }) -- Wiki says "180-230" and we have NO DATA! We don't know what the players conditions/gear was.
    mob:getStatusEffect(xi.effect.BLAZE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setAutoAttackEnabled(false)
    mob:setMod(xi.mod.FASTCAST, 15)
    mob:setLocalVar('HPP', 90)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
end

entity.onMobFight = function(mob, target)
    local fastCast = mob:getLocalVar('HPP')
    if mob:getHPP() <= fastCast then
        if mob:getHPP() > 10 then
            mob:addMod(xi.mod.FASTCAST, 15)
            mob:setLocalVar('HPP', mob:getHPP() - 10)
        end
    end
end

entity.onSpikesDamage = function(mob, target, damage)
    if mob:getCurrentAction() == xi.action.category.MAGIC_CASTING then
        return 0, 0, 0
    end

    local pTable =
    {
        basePower       = damage,
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.FIRE,
        actorStat       = xi.mod.INT,
        canMAB          = true,
        canResist       = true,
        canResistExtra  = true,
    }

    return xi.combat.action.executeSpikesDamage(mob, target, pTable)
end

return entity
