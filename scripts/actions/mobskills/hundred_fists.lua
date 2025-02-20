-----------------------------------
-- Hundred Fists
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- note that captures show that mobskill hundred fists is still 45 seconds on retail
    xi.mobskills.mobBuffMove(mob, xi.effect.HUNDRED_FISTS, 1, 0, 45)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.HUNDRED_FISTS
end

return mobskillObject
