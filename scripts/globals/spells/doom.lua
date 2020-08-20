-----------------------------------------
-- Spell: Doom
-- Gives you 30 seconds to live.
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.DOOM
    if (target:hasStatusEffect(effect) == false) then
        spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB) -- gains effect
        target:addStatusEffect(effect, 10, 3, 30)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
    end

    return effect
end
