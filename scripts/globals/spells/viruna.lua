-----------------------------------------
-- Spell: Viruna
-- Removes disease or plague from target.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    if (target:delStatusEffect(tpz.effect.DISEASE)) then
        spell:setMsg(tpz.msg.basic.MAGIC_REMOVE_EFFECT)
        return tpz.effect.DISEASE
    elseif (target:delStatusEffect(tpz.effect.PLAGUE)) then
        spell:setMsg(tpz.msg.basic.MAGIC_REMOVE_EFFECT)
        return tpz.effect.PLAGUE
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return 0
end
