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
    skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.DEFENSE_BOOST, 100, 0, 60))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
