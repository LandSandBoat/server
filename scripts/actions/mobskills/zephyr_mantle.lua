-----------------------------------
--  Zephyr Mantle
--  Description: Creates shadow images that each absorb a single attack directed at you.
--  Type: Magical (Wind)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local base = math.random(4, 10)

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BLINK, base, 0, 180))
    return xi.effect.BLINK
end

return mobskillObject
