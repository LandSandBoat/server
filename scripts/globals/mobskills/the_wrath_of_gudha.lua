require("scripts/globals/mobskills")

-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.WEIGHT

    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 80, 0, 10)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    end

    return dmg
end

return mobskillObject
