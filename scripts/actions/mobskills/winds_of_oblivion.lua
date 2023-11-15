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
    -- Subpower 100 prevents removal by Ecphoria Ring
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 30, 0, 75, 100))
    return typeEffect
end

return mobskillObject
