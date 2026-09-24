-----------------------------------
--  Whistle
--
--  Description: Increases evasion.
--  Type: Enhancing
--  Utsusemi/Blink absorb: N/A
--  Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local power    =  30
    local duration = 180

    skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.EVASION_BOOST, power, 3, duration))

    return xi.effect.EVASION_BOOST
end

return mobskillObject
