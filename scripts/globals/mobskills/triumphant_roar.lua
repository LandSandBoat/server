-----------------------------------
--  Triumphant Roar
--  Family: Gargouille
--  Description: Enhances Attack.
--  Type: Enhancing
--  Utsusemi/Blink absorb: N/A
--  Range: Self
--  Notes: Only used when standing
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() ~= 4 then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 15
    local duration = 90
    local typeEffect = xi.effect.ATTACK_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end

return mobskillObject
