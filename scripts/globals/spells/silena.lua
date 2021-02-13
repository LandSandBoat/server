-----------------------------------
-- Spell: Silena
-- Removes silence and mute from target.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    if (target:delStatusEffect(tpz.effect.SILENCE)) then
        spell:setMsg(tpz.msg.basic.MAGIC_REMOVE_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end
    return tpz.effect.SILENCE
end

return spell_object
