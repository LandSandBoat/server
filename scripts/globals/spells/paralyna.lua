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
    if (target:getStatusEffect(tpz.effect.PARALYSIS) ~= nil) then
        target:delStatusEffect(tpz.effect.PARALYSIS)
        spell:setMsg(tpz.msg.basic.MAGIC_REMOVE_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end
    return tpz.effect.PARALYSIS
end

return spell_object
