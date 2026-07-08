-----------------------------------
-- Frog Cheer
-- Increases magical attack and grants Elemental Seal effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.MAGIC_ATK_BOOST, 25, 0, 300))
    target:addStatusEffect(xi.effect.ELEMENTAL_SEAL, { power = 1, duration = 60, origin = mob })

    return xi.effect.MAGIC_ATK_BOOST
end

return mobskillObject
