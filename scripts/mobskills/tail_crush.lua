-----------------------------------
--  Tail Crush
--  Description: Smashes a single target with its tail. Additional effect: Poison
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local typeEffect = xi.effect.POISON
    local power = mob:getMainLvl() / 10 + 10
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 3, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
