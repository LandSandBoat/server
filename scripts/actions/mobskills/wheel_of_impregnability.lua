-----------------------------------
-- Wheel of Impregnability
-- Animation sub is changed by the mixin: mobskill_animation_sub.lua
-----------------------------------
local ID = zones[xi.zone.EMPYREAL_PARADOX]
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        mob:hasStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        return 1
    end

    mob:showText(mob, ID.text.PROMATHIA_TEXT + 5)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:addStatusEffect(xi.effect.PHYSICAL_SHIELD, 1, 0, 0)

    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.PHYSICAL_SHIELD
end

return mobskillObject
