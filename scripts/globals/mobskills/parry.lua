-----------------------------------
-- Parry
-- Enhances defense.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST
    local power = 25 -- 25% Defense Boost

    if mob:isInDynamis() then
        typeEffect = xi.effect.EVASION_BOOST
        power      = mob:getMod(xi.mod.EVA) * 0.25 -- 25% Evasion Boost in Dyna
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, 60))
    return typeEffect
end

return mobskillObject
