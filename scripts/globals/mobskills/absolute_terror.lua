-----------------------------------
-- Absolute Terror
-- Causes Terror, which causes the victim to be stunned for the duration of the effect, this can not be removed.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) or
        mob:hasStatusEffect(xi.effect.SUPER_BUFF) or
        mob:hasStatusEffect(xi.effect.INVINCIBLE) or
        mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) or
        target:isBehind(mob, 96) or
        mob:getAnimationSub() == 1
    then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    local power = 30
    -- Three minutes is WAY too long, especially on Wyrms. Reduced to Wiki's definition of 'long time'. Reference: http://wiki.ffxiclopedia.org/wiki/Absolute_Terror
    local duration
    if skill:isAoE() then
        duration = math.random(10, 18)
    else
        duration = 10 + math.random(0, 40)
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    return typeEffect
end

return mobskillObject
