-----------------------------------
-- Spell: Foil
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

-- https://www.ffxiah.com/forum/topic/56696/foil-potency-and-decay-testing/#3625542
spell_object.onSpellCast = function(caster, target, spell)

    if target:addStatusEffect(xi.effect.FOIL, 150, 3, 30) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.FOIL
end

return spell_object
