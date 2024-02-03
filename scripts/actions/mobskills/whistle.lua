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

    skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.AGI_BOOST, power, 3, duration))

    return xi.effect.AGI_BOOST
end

return mobskillObject
