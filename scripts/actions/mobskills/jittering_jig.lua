-----------------------------------
-- Jittering Jig
-- Family: Spriggan
-- Description: Enhances attacks.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.ATTACK_BOOST, 46, 0, 60))

    return xi.effect.ATTACK_BOOST
end

return mobskillObject
