-----------------------------------
-- Refueling
-- Increases attack speed.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 2000, 0, 180))

    return xi.effect.HASTE
end

return mobskillObject
