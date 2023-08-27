---------------------------------------------
-- Putrid Breath
-- Family: Morbol
-- Description:
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: Conal up to 15'
-- Notes: Some Morbol NMs
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local cap = mob:getLocalVar("putridbreathcap")
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.15, 3, xi.magic.ele.EARTH, cap)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH)

    if dmg == nil then
        dmg = 0
    end

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)

    return dmg
end

return mobskillObject
