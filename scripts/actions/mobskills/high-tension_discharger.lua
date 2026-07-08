-----------------------------------
-- High-Tension_Discharger
-- Family: Ultima
-- Description: Discharges a powerful current that deals Thunder damage to players in a fan-shaped area. Additional Effect: Stun
-- TODO: Figure out damage values for Ultima/Omega Master Trial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.05
    params.damageCap        = mob:getMainLvl() < 65 and 490 or 750
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.THUNDER
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.THUNDER
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 3, 4)

        if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
            target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
        end
    end

    mob:setLocalVar('nuclearWaste', 0)

    return info.damage
end

return mobskillObject
