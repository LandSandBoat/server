-----------------------------------
--  Shield Bash
--
--  Description:  Delivers an attack that can stun the target. Shield required.
--  Type: Physical
--  Range: Melee
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
    local dmgmod = 0.8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 2, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 5)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end

return mobskillObject
