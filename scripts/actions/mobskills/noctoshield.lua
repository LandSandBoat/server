-----------------------------------
-- Noctoshield
--
-- Description: Gives the effect of "Phalanx."
-- Type: Magical
-- TODO: More precise effect power/duration
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PHALANX, 13, 0, 120))
    return xi.effect.PHALANX
end

return mobskillObject
