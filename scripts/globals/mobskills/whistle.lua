-----------------------------------
--  Whistle
--
--  Description: Increases agility.
--  Type: Enhancing
--  Utsusemi/Blink absorb: N/A
--  Range: Self
--  Notes: When used by the Nightmare Dhalmel in Dynamis - Buburimu, it grants an Evasion Boost instead.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.AGI_BOOST, 10, 10, 210))

    return xi.effect.AGI_BOOST
end

return mobskillObject
