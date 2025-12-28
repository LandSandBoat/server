-----------------------------------
--  Venom
--  Description: Deals damage in a fan shaped area. Additional effect: poison
--  Type: Magical: Water
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 10' cone
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power  = math.floor(mob:getMainLvl() / 6 + 1)

    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.WATER, 1.5, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, 60)

    return damage
end

return mobskillObject
