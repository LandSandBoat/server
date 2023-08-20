-----------------------------------
-- Frog Cheer
-- Increases magical attack and grants Elemental Seal xi.effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.MAGIC_ATK_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 25, 0, 300))
    return typeEffect
end

return mobskillObject
