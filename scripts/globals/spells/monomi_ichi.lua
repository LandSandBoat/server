-----------------------------------
-- Spell: Monomi: Ichi
-- Lessens chance of being detected by sound
-- Duration is 3 minutes (non-random duration)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    if (not target:hasStatusEffect(xi.effect.SNEAK)) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
        target:addStatusEffect(xi.effect.SNEAK, 0, 10, math.floor(420 * SNEAK_INVIS_DURATION_MULTIPLIER))
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no xi.effect.
    end

    return xi.effect.SNEAK
end

return spell_object
