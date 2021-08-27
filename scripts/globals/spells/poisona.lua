-----------------------------------
-- Spell: Poisona
-- Removes poison from target.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    if (target:delStatusEffect(xi.effect.POISON)) then
        spell:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end
    return xi.effect.POISON
end

return spell_object
