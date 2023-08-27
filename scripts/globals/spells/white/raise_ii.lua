-----------------------------------
-- Spell: Raise
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:isPC() then
        target:sendRaise(2)
    elseif bit.band(target:getBehaviour(), xi.behavior.RAISABLE) == xi.behavior.RAISABLE then
        target:triggerListener("RAISE_RECEIVED", target, 2)
    end

    spell:setMsg(xi.msg.basic.MAGIC_CASTS_ON)

    return 2
end

return spellObject
