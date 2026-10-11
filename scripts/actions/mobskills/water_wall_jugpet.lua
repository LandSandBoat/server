-----------------------------------
-- Water Wall
-- Enhances defense.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.DEFENSE_BOOST, 100, 0, 90)) -- The duration of this ability may vary all the way to 9 minutes with a HEAVY weight towards 90 seconds.

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
