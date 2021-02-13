-----------------------------------
-- Spell: Dread Spikes
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local duration = calculateDuration(SPIKE_EFFECT_DURATION, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local typeEffect = tpz.effect.DREAD_SPIKES
    local drainAmount = target:getMaxHP() / 2

    if target:addStatusEffect(typeEffect, 0, 0, duration, 0, drainAmount, 1) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spell_object
