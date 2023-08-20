-----------------------------------
-- Rinpyotosha
--
-- Description: Grants the effect of Warcry to user and any linked allies.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self and nearby mobs of same family and/or force up to 20'.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 25
    local duration = 180

    local typeEffect = xi.effect.WARCRY
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end

return mobskillObject
