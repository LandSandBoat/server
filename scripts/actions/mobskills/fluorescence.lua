-----------------------------------
-- Fluorescence
-- Description: Emits radiation to boost next attack.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local subPower = 1

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BOOST, 400, 0, 180, nil, subPower))

    return xi.effect.BOOST
end

return mobskillObject
