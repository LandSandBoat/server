-----------------------------------
-- Refueling
-- Increases attack speed.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 1000, 0, 300))

    return xi.effect.HASTE
end

return mobskillObject
