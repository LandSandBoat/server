-----------------------------------
-- Sand Breath
-- Deals Earth damage to enemies within a fan-shaped area. Additional effect: Blind
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 20
    if skill:getID() == 1873 then -- Nightmare Leech - -80 acc BLINDNESS
        power = 80
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, power, 0, 180)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.085, 1, xi.magic.ele.EARTH, 333)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)
    return dmg
end

return mobskillObject
