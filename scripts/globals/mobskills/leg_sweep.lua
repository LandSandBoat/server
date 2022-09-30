-----------------------------------
-- Leg Sweep
-- Description: Damage varies with TP.
-- Type: Physical
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target,mob,skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.8
    local typeEffect = xi.effect.STUN

    local info = xi.mobskills.mobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,xi.mobskills.physicalTpBonus.DMG_VARIES,2.5,2.75,3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg,mob,skill,target, xi.attackType.PHYSICAL, xi.damageType.BLUNT,info.hitslanded)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 3))
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskill_object
