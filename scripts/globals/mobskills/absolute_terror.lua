-----------------------------------
-- Absolute Terror
-- Causes Terror, which causes the victim to be stunned for the duration of the effect, this can not be removed.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) or
        mob:hasStatusEffect(xi.effect.SUPER_BUFF) or
        mob:hasStatusEffect(xi.effect.INVINCIBLE) or
        mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) or
        not target:isInfront(mob, 128) or
        mob:getAnimationSub() == 1
    then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = 30
    local duration = 30 --  Reference: http://wiki.ffxiclopedia.org/wiki/Absolute_Terror

    if skill:isAoE() then
        duration = 10
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, power, 0, duration))

    return xi.effect.TERROR
end

return mobskillObject
