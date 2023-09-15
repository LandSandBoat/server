-----------------------------------
--  Water Shield
--
--  Description: Enhances evasion.
--  Type: Enhancing
--  Utsusemi/Blink absorb: N/A
--  Range: Self
--  Notes: Very sharp evasion increase.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 25
    if skill:getID() == 1869 then -- Nightmare Makara - +50 EVASION_BOOST
        power = 50
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, power, 0, math.random(120, 600)))

    return xi.effect.EVASION_BOOST
end

return mobskillObject
