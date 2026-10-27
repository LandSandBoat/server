-----------------------------------
-- Gilded Torpor
-- Family: Mimic (A.M.A.N. Trove)
-- Description: Puts targets around the mimic to sleep.
-- TODO: Capture needed. The duration.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 30))

    return xi.effect.SLEEP_I
end

return mobskillObject
