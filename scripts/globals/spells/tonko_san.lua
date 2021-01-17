-----------------------------------
-- Spell: Tonko: san
-- Lessens chance of being detected by sound
-- Duration is 7 minutes (non-random duration)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    if (target:hasStatusEffect(tpz.effect.INVISIBLE) == false) then
        target:addStatusEffect(tpz.effect.INVISIBLE, 0, 10, 420)
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no tpz.effect.
    end
    return tpz.effect.INVISIBLE
end

return spell_object
