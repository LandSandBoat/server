-----------------------------------
-- Mana_Screen
-- Description: Magic Shield
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_SHIELD, 1, 0, 60))

    return xi.effect.MAGIC_SHIELD
end

return mobskillObject
