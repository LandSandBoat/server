-----------------------------------
-- Spell: Ice Spikes
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
    local duration = calculateDuration(SPIKE_EFFECT_DURATION, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local typeEffect = tpz.effect.ICE_SPIKES

    local int = caster:getStat(tpz.mod.INT)
    local magicAtk = caster:getMod(tpz.mod.MATT)
    local power = ((int + 10) / 20 + 2) * (1 + magicAtk / 100)

    if target:addStatusEffect(typeEffect, power, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

   return typeEffect
end

return spell_object
