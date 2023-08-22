-----------------------------------
--  Silence Gas
--
--  Description: Emits a noxious cloud in a fan-shaped area of effect, dealing Wind damage to all targets. Additional effect: silence
--  Type: Magical Wind (Element)
--
--
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    local dmgmod = 1
    if mob:getMaster() then
        dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.1, 2, xi.magic.ele.DARK, 300)
    else
        dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.25, 2, xi.magic.ele.DARK, 800)
    end

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
    return dmg
end

return mobskillObject
