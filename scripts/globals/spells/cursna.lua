-----------------------------------------
-- Spell: Cursna
-- Removes curse and bane from target.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local curse = target:getStatusEffect(tpz.effect.CURSE_I)
    local curse2 = target:getStatusEffect(tpz.effect.CURSE_II)
    local bane = target:getStatusEffect(tpz.effect.BANE)
    local bonus = caster:getMod(tpz.mod.ENHANCES_CURSNA) + target:getMod(tpz.mod.ENHANCES_CURSNA_RCVD)
    local power = 25*((100+bonus)/100) -- This 25 is temp until the skill calculation is in.

    spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    if (target:hasStatusEffect(tpz.effect.DOOM) and power > math.random(1, 100)) then
        -- remove doom
        final = tpz.effect.DOOM
        target:delStatusEffect(tpz.effect.DOOM)
        spell:setMsg(tpz.msg.basic.NARROWLY_ESCAPE)
    elseif (curse ~= nil and curse2 ~= nil and bane ~= nil) then
        target:delStatusEffect(tpz.effect.CURSE_I)
        target:delStatusEffect(tpz.effect.CURSE_II)
        target:delStatusEffect(tpz.effect.BANE)
        final = tpz.effect.CURSE_II
        spell:setMsg(tpz.msg.basic.MAGIC_REMOVE_EFFECT)
    elseif (curse ~= nil and bane ~= nil) then
        target:delStatusEffect(tpz.effect.CURSE_I)
        target:delStatusEffect(tpz.effect.BANE)
        final = tpz.effect.CURSE_I
        spell:setMsg(tpz.msg.basic.MAGIC_REMOVE_EFFECT)
    elseif (curse2 ~= nil and bane ~= nil) then
        target:delStatusEffect(tpz.effect.CURSE_II)
        target:delStatusEffect(tpz.effect.BANE)
        final = tpz.effect.CURSE_II
        spell:setMsg(tpz.msg.basic.MAGIC_REMOVE_EFFECT)
    elseif (curse ~= nil) then
        target:delStatusEffect(tpz.effect.CURSE_I)
        final = tpz.effect.CURSE_I
        spell:setMsg(tpz.msg.basic.MAGIC_REMOVE_EFFECT)
    elseif (curse2 ~= nil) then
        target:delStatusEffect(tpz.effect.CURSE_II)
        final = tpz.effect.CURSE_II
        spell:setMsg(tpz.msg.basic.MAGIC_REMOVE_EFFECT)
    elseif (bane ~= nil) then
        target:delStatusEffect(tpz.effect.BANE)
        final = tpz.effect.BANE
        spell:setMsg(tpz.msg.basic.MAGIC_REMOVE_EFFECT)
    end

    return final
end
