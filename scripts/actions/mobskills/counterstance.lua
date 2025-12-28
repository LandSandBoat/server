-----------------------------------
-- Ability: Counterstance
-- Increases chance to counter but lowers defense.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.COUNTERSTANCE, 45, 0, 300)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.COUNTERSTANCE
end

return mobskillObject
