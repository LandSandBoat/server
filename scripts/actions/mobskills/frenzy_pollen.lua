-----------------------------------
-- Frenzy Pollen
-- Description: Grants Hundred Fists.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    -- Retail gives a Monipulator 20 seconds. Mobs get the same until captured.
    -- TODO: JP wiki says a mob's Hundred Fists lasts under 10 seconds.
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.HUNDRED_FISTS, 1, 0, 20))

    return xi.effect.HUNDRED_FISTS
end

return mobskillObject
