-----------------------------------
--  Whistle
--
--  Description: Increases agility.
--  Type: Enhancing
--  Utsusemi/Blink absorb: N/A
--  Range: Self
--  Notes: When used by the Nightmare Dhalmel in Dynamis - Buburimu, it grants an Evasion Boost instead.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = target:getMainLvl() / 10 * 3.75 + 5
    local duration = 60

    local typeEffect = xi.effect.AGI_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(target, typeEffect, power, 3, duration))

    return typeEffect
end

return mobskillObject
