-----------------------------------
-- Lamentation
--
-- Description: Deals Light damage to all targets in range. Additional effect: Dia
-- Range: 10' cone
-- Wipes Shadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.LIGHT, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DIA, 8, 3, 30, 0, 20)

    local effect1 = target:getStatusEffect(xi.effect.DIA)
    if effect1 then
        effect1:delEffectFlag(xi.effectFlag.ERASABLE)
    end

    return damage
end

return mobskillObject
