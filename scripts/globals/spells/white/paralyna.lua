-----------------------------------
-- Spell: Paralyna
-- Removes paralysis from target.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    if (target:getStatusEffect(xi.effect.PARALYSIS) ~= nil) then
        target:delStatusEffect(xi.effect.PARALYSIS)
        spell:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end
    return xi.effect.PARALYSIS
end

return spell_object
