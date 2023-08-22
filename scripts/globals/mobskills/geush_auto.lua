-----------------------------------
-- Geush Urvan Auto Attack
-- Skill used by Guesh Urvan in place of his auto attack. Wipes shadows, and knockbacks.
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
    local dmgmod = 7
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod,  xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end

return mobskillObject
