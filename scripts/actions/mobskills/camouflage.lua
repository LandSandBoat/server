-----------------------------------
--  Camouflage
--      TODO: Created for by not in use by Rohemolipaud. Mobskill sql currently calls the wrong animation category.
--  Description: Makes you harder to detect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.CAMOUFLAGE, 5000, 0, 180))

    return xi.effect.CAMOUFLAGE
end

return mobskillObject
