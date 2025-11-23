-----------------------------------
-- Area: Toraimarai Canal
--   NM: Brazen Bones
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  169.270, y =   8.028, z = -110.580 },
    { x =  155.792, y =   8.334, z = -124.494 },
    { x =  169.525, y =  11.964, z = -128.288 }
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, 50, 0, 0)
    mob:getStatusEffect(xi.effect.ICE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.ICE_MEVA, 100)
end

entity.onSpikesDamage = function(mob, target, damage)
    -- "damage" is the power of the status effect up in onMobinitialize.
    local intDiff = mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local dmg = damage + intDiff
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(mob, xi.element.ICE, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(mob, target, xi.element.ICE, 0)
    dmg = math.floor(dmg * xi.spells.damage.calculateAbsorption(target, xi.element.ICE, true))
    dmg = math.floor(dmg * xi.spells.damage.calculateNullification(target, xi.element.ICE, true, false))
    dmg = finalMagicNonSpellAdjustments(mob, target, xi.element.ICE, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return xi.subEffect.ICE_SPIKES, xi.msg.basic.SPIKES_EFFECT_DMG, dmg
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENBLIZZARD)
end

entity.onMobFight = function(mob, target)
    -- Double Attack rate increases as HP decreases
    local doubleAttack = (100 - mob:getHPP()) * 0.5
    if mob:getMod(xi.mod.DOUBLE_ATTACK) ~= utils.clamp(doubleAttack, 1, 100) then
        mob:setMod(xi.mod.DOUBLE_ATTACK, utils.clamp(doubleAttack, 1, 100))
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 286)
end

return entity
