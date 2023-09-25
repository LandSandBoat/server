-----------------------------------
-- Viscid Secretion
-- Inflicts slow and Gravity in a conal area
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getName() == "Pasuk" or
        mob:getName() == "Gnyan"
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local slow = xi.effect.SLOW
    local gravity = xi.effect.WEIGHT
    local duration = math.random(120, 180)

    local gravityMessage = xi.mobskills.mobStatusEffectMove(mob, target, gravity, 50, 0, duration)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, slow, 5000, 0, duration))

    if
        skill:getMsg() == xi.msg.basic.SKILL_MISS or
        skill:getMsg() == xi.msg.basic.SKILL_NO_EFFECT
    then
        skill:setMsg(gravityMessage)
        return gravity
    end

    return slow
end

return mobskillObject
