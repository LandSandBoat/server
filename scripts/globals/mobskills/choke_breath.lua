---------------------------------------------
--  Choke Breath
--
--  Description: Damages enemies in a fan-shaped area of effect. Additional effect: Paralysis & Silence
--  Type: Physical
-- 100 physical damage slashing * pdif
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_FLAT, 1, 1, 1)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 25, 0, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SILENCE, 1, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end

return mobskillObject
