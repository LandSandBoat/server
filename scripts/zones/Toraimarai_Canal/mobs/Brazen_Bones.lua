-----------------------------------
-- Area: Toraimarai Canal
--   NM: Brazen Bones
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, 45, 0, 0)
    mob:getStatusEffect(xi.effect.ICE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.ICE_MEVA, 100)
end

-- TODO: Fix onSpikesDamage bug causing spikes to apply damage twice. Commented out until it is resolved.
-- entity.onSpikesDamage = function(mob, target, damage)
--     local intDiff = mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

--     if intDiff > 20 then
--         intDiff = 20 + (intDiff - 20) * 0.5 -- INT above 20 is half as effective.
--     end

--     local dmg = (damage + intDiff) * 1.3 -- INT adjustment and base damage averaged together.
--     local params = {}
--     params.bonusmab = 0
--     params.includemab = false
--     dmg = addBonusesAbility(mob, xi.element.ICE, target, dmg, params)
--     dmg = dmg * applyResistanceAddEffect(mob, target, xi.element.ICE, 0)
--     dmg = adjustForTarget(target, dmg, xi.element.ICE)
--     dmg = finalMagicNonSpellAdjustments(mob, target, xi.element.ICE, dmg)

--     if dmg < 0 then
--         dmg = 0
--     end

--     return xi.subEffect.ICE_SPIKES, xi.msg.basic.SPIKES_EFFECT_DMG, dmg
-- end

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
