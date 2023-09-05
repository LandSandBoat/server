-----------------------------------
-- Spell: Viruna
-- Removes disease or plague from target.
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:delStatusEffect(xi.effect.DISEASE) then
        spell:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT)
        return xi.effect.DISEASE
    elseif target:delStatusEffect(xi.effect.PLAGUE) then
        spell:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT)
        return xi.effect.PLAGUE
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return 0
end

return spellObject
