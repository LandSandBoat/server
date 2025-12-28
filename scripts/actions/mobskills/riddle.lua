-----------------------------------
-- Riddle
--
-- Description: Reduces maximum MP in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 15' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = utils.clamp(math.floor(4.7 + target:getStat(xi.mod.INT) / 2), 0, 90)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_MP_DOWN, power, 0, 60))

    return xi.effect.MAX_MP_DOWN
end

return mobskillObject
