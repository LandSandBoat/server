-----------------------------------
-- Spell: Protectra IV
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
    local power = 120
    local duration = calculateDuration(1800, spell:getSkillType(), spell:getSpellGroup(), caster, target, false)
    duration = calculateDurationForLvl(duration, 63, target:getMainLvl())

    local typeEffect = tpz.effect.PROTECT
    if target:addStatusEffect(typeEffect, power, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
    end

    return typeEffect
end

return spell_object
