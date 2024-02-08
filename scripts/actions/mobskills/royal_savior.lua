-----------------------------------
-- Royal Savior
-- Grants effect of Protect
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PROTECT, 175, 0, 300))

    return xi.effect.PROTECT
end

return mobskillObject
