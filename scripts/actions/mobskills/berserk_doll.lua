-----------------------------------
-- Berserk
-- Berserk Ability for Doll family
-- Gives Warcry effect instead of Berserk. No defence penalty.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.WARCRY, 33, 0, 120))

    return xi.effect.WARCRY
end

return mobskillObject
