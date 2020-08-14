-----------------------------------------
-- Spell: Haste
-- Composure increases duration 3x
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 180

    if caster:hasStatusEffect(tpz.effect.COMPOSURE) and caster:getID() == target:getID() then
       duration = duration * 3
    end

    local power = 1465 -- 150/1024 ~14.65%

    if not target:addStatusEffect(tpz.effect.HASTE, power, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.HASTE
end
