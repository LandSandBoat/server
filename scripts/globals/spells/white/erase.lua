-----------------------------------
-- Spell: Erase
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local effect = target:eraseStatusEffect()

    if (effect == xi.effect.NONE) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    else
        spell:setMsg(xi.msg.basic.MAGIC_ERASE)
    end

    return effect
end

return spell_object
