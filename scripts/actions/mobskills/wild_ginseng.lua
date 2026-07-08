-----------------------------------
-- Wild Ginseng
-- Description: Adds Haste, Protect, Shell, Regen, and Blink to user.
-- NOTE: These values are ripped from the monstrosity version of this skill, and may not be 100% accurate.
-- TODO: Capture accurate values.
-----------------------------------

---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 2000, 0, 180)
    xi.mobskills.mobBuffMove(mob, xi.effect.PROTECT, 60, 0, 180)
    xi.mobskills.mobBuffMove(mob, xi.effect.SHELL, 1750, 0, 180)
    xi.mobskills.mobBuffMove(mob, xi.effect.REGEN, 30, 0, 180)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BLINK, 3, 0, 180))

    return xi.effect.BLINK
end

return mobskillObject
