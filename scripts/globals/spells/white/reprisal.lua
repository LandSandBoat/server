-----------------------------------
-- Spell: Reprisal
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local duration = calculateDuration(60, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local maxReflectedDamage = target:getMaxHP() * 2
    local reflectedPercent = 33
    local typeEffect = xi.effect.REPRISAL

    if target:addStatusEffect(typeEffect, reflectedPercent, 0, duration, 0, maxReflectedDamage) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spell_object
