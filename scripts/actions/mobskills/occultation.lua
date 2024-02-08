-----------------------------------
-- Occultation
--
-- Description: Creates 25 shadows
-- Type: Magical (Wind)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local base = math.random(10, 25)

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BLINK, base, 0, 120))
    return xi.effect.BLINK
end

return mobskillObject
