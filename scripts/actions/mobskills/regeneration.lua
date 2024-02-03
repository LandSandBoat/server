-----------------------------------
-- Regeneration
--
-- Description: Adds a Regen xi.effect.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = mob:getMainLvl() / 10 * 4 + 5

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REGEN, power, 3, 60))

    return xi.effect.REGEN
end

return mobskillObject
