-----------------------------------------
-- Spell: Erase
--
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = target:eraseStatusEffect()

    if (effect == tpz.effect.NONE) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
    else
        spell:setMsg(tpz.msg.basic.MAGIC_ERASE)
    end

    return effect
end
