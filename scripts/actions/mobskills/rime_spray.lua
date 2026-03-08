-----------------------------------
-- Rime Spray
-- Family: Clionidae
-- Description: Deals Ice damage to enemies within a fan-shaped area, inflicting them with Frost and All statuses down.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 5, 5, 5 } -- TODO: Capture fTPs
    params.element        = xi.element.ICE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.ICE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/durations
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FROST, 15, 3, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 20, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 20, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, 20, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AGI_DOWN, 20, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, 20, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 20, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHR_DOWN, 20, 3, 60)
    end

    return info.damage
end

return mobskillObject
