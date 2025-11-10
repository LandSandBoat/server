-----------------------------------
--  Vacuous Osculation
--
--  Description: Deals damage to a single target. Additional effect: Poison, Plague
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local ftp = 3
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.NONE, ftp, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PLAGUE, 3, 3, 30)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, 8, 3, 60)

    return damage
end

return mobskillObject
