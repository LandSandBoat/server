-----------------------------------
--  Water Shield
--  Description: Enhances evasion.
--  Type: Enhancing
--  Utsusemi/Blink absorb: N/A
--  Range: Self
--  Notes: Very sharp evasion increase.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, 25, 0, 90))  -- The duration of this ability may vary all the way to 9 minutes with a HEAVY weight towards 90 seconds.

    return xi.effect.EVASION_BOOST
end

return mobskillObject
