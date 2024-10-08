-----------------------------------
-- Amber Scutum
-- Family: Wamouracampa
-- Description: Increases defense.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 20

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, 120))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
