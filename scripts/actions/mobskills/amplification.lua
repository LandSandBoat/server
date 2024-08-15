-----------------------------------
-- Amplification
-- Enhances Magic Attack and Magic Defense. Bonus stacks when used by mobs.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, 30, 0, 120))
    xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_ATK_BOOST, 30, 0, 120)

    return xi.effect.MAGIC_DEF_BOOST
end

return mobskillObject
