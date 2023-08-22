-----------------------------------
--  Rime Spray
--  Description: Deals Ice damage to enemies within a fan-shaped area, inflicting them with Frost and All statuses down.
--  Type: Breath
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- local typeEffect = xi.effect.FROST

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FROST, 15, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AGI_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 20, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHR_DOWN, 20, 3, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.element.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end

return mobskillObject
