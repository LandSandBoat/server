-----------------------------------
-- Memento Mori
-- Enhances Magic Attack.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_ATK_BOOST, 20, 0, 300))

    return xi.effect.MAGIC_ATK_BOOST
end

return mobskillObject
