-----------------------------------
-- Berserk
-- Berserk Ability used by Volker. Maybe other humanoids?
-- Gives Warcry effect instead of Berserk. No defence penalty.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.WARCRY, 25, 0, 180))

    return xi.effect.WARCRY
end

return mobskillObject
