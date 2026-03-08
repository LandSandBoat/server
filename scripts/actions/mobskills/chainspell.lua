-----------------------------------
-- Chainspell
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    xi.mobskills.mobBuffMove(mob, xi.effect.CHAINSPELL, 1, 0, 60)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.CHAINSPELL
end

return mobskillObject
