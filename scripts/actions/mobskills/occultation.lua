-----------------------------------
-- Occultation
--
-- Description: Creates 25 shadows
-- Type: Magical (Wind)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local base = 10

    if mob:isNM() then
        base = math.random(10, 25)
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.COPY_IMAGE, 1, 0, 300, 0, base))
    return xi.effect.BLINK
end

return mobskillObject
