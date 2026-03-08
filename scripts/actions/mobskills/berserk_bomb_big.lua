-----------------------------------
-- Berserk (Growing Bomb)
-- Description: Increases attack power at the cost of defense.
-- Type: Buff
-- Berserk (Growing Bomb) is only used by small bombs.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BERSERK, 50, 0, 180))
    return xi.effect.BERSERK
end

return mobskillObject
