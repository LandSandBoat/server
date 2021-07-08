-----------------------------------
-- Spell: Tonko: Ichi
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
    if (not target:hasStatusEffect(xi.effect.INVISIBLE)) then
        target:addStatusEffect(xi.effect.INVISIBLE, 0, 10, math.floor(420 * xi.settings.SNEAK_INVIS_DURATION_MULTIPLIER))
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no xi.effect.
    end

    return xi.effect.INVISIBLE
end

return spell_object
