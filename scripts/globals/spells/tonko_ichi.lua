-----------------------------------------
-- Spell: Tonko: Ichi
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
    if (not target:hasStatusEffect(tpz.effect.INVISIBLE)) then
        target:addStatusEffect(tpz.effect.INVISIBLE, 0, 10, math.floor(420 * SNEAK_INVIS_DURATION_MULTIPLIER))
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no tpz.effect.
    end

    return tpz.effect.INVISIBLE
end
