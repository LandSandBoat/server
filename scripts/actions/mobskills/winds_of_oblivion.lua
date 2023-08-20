-----------------------------------
--  Winds of Oblivion
-----------------------------------
local ID = zones[xi.zone.EMPYREAL_PARADOX]
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    mob:showText(mob, ID.text.PROMATHIA_TEXT + 6)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.AMNESIA
    local power = 30
    local duration = 75

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect
end

return mobskillObject
