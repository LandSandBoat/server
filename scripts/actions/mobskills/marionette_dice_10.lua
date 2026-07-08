-----------------------------------
--  Marionette Dice (Defense Boost)
--  Description: Rolls the dice and gives a 10% defense boost to the target for 30 seconds.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    target:addStatusEffect(xi.effect.DEFENSE_BOOST, { power = 10, duration = 30, origin = mob })

    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
