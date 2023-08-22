-----------------------------------
--  Poison Pick
--
--  Description: Deals damage to a single target. Additional effect: poison
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
--  Notes:
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    local power = 5

    if mob:getMainLvl() >= 56 then
        power = power + (mob:getMainLvl() - 55)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, power, 3, 180)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end

return mobskillObject
