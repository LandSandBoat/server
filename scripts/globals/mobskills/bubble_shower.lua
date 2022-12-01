-----------------------------------
-- Bubble Shower
-- Deals Water damage in an area of effect. Additional effect: STR Down
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.STR_DOWN
    local bubbleCap = 0
    local hpdmg = 1 / 16

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 10, 3, 120)

    if mob:getMaster() then
        bubbleCap = 2000
    else
        bubbleCap = 200
    end

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, hpdmg, 1, xi.magic.ele.WATER, bubbleCap)
    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg
end

return mobskillObject
