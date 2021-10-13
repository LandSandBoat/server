-----------------------------------
-- Artifical Gravity w/ 2 Gears
-- Damage plus Weight effect
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, MOBSKILL_PHYSICAL, MOBPARAM_BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    MobStatusEffectMove(mob, target, xi.effect.WEIGHT, 30, 0, 60)
    target:delHP(dmg)
    return dmg
end

return mobskill_object
