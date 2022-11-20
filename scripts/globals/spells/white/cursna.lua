-----------------------------------
-- Spell: Cursna
-- Removes curse and bane from target.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local curse = target:getStatusEffect(xi.effect.CURSE_I)
    local curse2 = target:getStatusEffect(xi.effect.CURSE_II)
    local bane = target:getStatusEffect(xi.effect.BANE)
    local bonus = caster:getMod(xi.mod.ENHANCES_CURSNA) + target:getMod(xi.mod.ENHANCES_CURSNA_RCVD)
    local power = 25 * ((100 + bonus) / 100) -- This 25 is temp until the skill calculation is in.
    local final = nil

    spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    if target:hasStatusEffect(xi.effect.DOOM) and power > math.random(1, 100) then
        -- remove doom
        final = xi.effect.DOOM
        target:delStatusEffect(xi.effect.DOOM)
        spell:setMsg(xi.msg.basic.NARROWLY_ESCAPE)
    elseif curse ~= nil and curse2 ~= nil and bane ~= nil then
        target:delStatusEffect(xi.effect.CURSE_I)
        target:delStatusEffect(xi.effect.CURSE_II)
        target:delStatusEffect(xi.effect.BANE)
        final = xi.effect.CURSE_II
        spell:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT)
    elseif curse ~= nil and bane ~= nil then
        target:delStatusEffect(xi.effect.CURSE_I)
        target:delStatusEffect(xi.effect.BANE)
        final = xi.effect.CURSE_I
        spell:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT)
    elseif curse2 ~= nil and bane ~= nil then
        target:delStatusEffect(xi.effect.CURSE_II)
        target:delStatusEffect(xi.effect.BANE)
        final = xi.effect.CURSE_II
        spell:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT)
    elseif curse ~= nil then
        target:delStatusEffect(xi.effect.CURSE_I)
        final = xi.effect.CURSE_I
        spell:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT)
    elseif curse2 ~= nil then
        target:delStatusEffect(xi.effect.CURSE_II)
        final = xi.effect.CURSE_II
        spell:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT)
    elseif bane ~= nil then
        target:delStatusEffect(xi.effect.BANE)
        final = xi.effect.BANE
        spell:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT)
    end

    return final
end

return spellObject
