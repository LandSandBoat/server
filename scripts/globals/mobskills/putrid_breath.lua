---------------------------------------------
-- Putrid Breath
-- Family: Morbol
-- Description:
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: Conal up to 15'
-- Notes: Some Morbol NMs
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/mobskills")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local cap = mob:getLocalVar("putridbreathcap")
    local dmgmod = xi.mobskills.MobBreathMove(mob, target, 0.15, 3, xi.magic.ele.EARTH, cap)
    local dmg = xi.mobskills.MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)

    return dmg
end

return mobskill_object
