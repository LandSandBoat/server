-----------------------------------
-- Spell: Blindna
-- Removes blindness from target.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:delStatusEffect(xi.effect.BLINDNESS) then
        spell:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.BLINDNESS
end

return spellObject
