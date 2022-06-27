-----------------------------------
--  Syphon Discharge
--
--  Family: Xzomit
--  Type: Breath
--  Can be dispelled: N/A
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes: Water Damage Knockback.
-----------------------------------
local mobskill_object = {}

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")

-----------------------------------
mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 1.25, xi.magic.ele.WATER, 200)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg

end

return mobskill_object
