-----------------------------------
-- Heat Wave
-- Description : A fiery wave that inflicts an extremely potent burn to targets in the area
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' Area of Effect
-- Heat Wave is only used by large or giant bombs.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.floor((mob:getMainLvl() - 5) / 2)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, power, 3, 180))

    return xi.effect.BURN
end

return mobskillObject
