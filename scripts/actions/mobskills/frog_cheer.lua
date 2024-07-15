-----------------------------------
-- Frog Cheer
-- Increases magical attack and grants Elemental Seal effect
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.MAGIC_ATK_BOOST, 25, 0, 300))
    target:addStatusEffect(xi.effect.ELEMENTAL_SEAL, 1, 0, 60)

    return xi.effect.MAGIC_ATK_BOOST
end

return mobskillObject
