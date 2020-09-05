-----------------------------------------
-- Spell: Monomi: Ichi
-- Lessens chance of being detected by sound
-- Duration is 3 minutes (non-random duration)
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    if (not target:hasStatusEffect(tpz.effect.SNEAK)) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
        target:addStatusEffect(tpz.effect.SNEAK, 0, 10, math.floor(420 * SNEAK_INVIS_DURATION_MULTIPLIER))
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no tpz.effect.
    end

    return tpz.effect.SNEAK
end
