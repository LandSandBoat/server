-----------------------------------
-- Jumping Thrust
-- Jumping Attack, only used by dragoons
-- 100% TP: ??? / 200% TP: ??? / 300% TP: ???
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, 1, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end

return mobskillObject
