-----------------------------------
-- Spell: Doom
-- Gives you 30 seconds to live.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local effect = xi.effect.DOOM
    if (target:hasStatusEffect(effect) == false) then
        spell:setMsg(xi.msg.basic.MAGIC_ENFEEB) -- gains effect
        target:addStatusEffect(effect, 10, 3, 30)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    end

    return effect
end

return spell_object
