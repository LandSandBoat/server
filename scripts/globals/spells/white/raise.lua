-----------------------------------
-- Spell: Raise
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:isPC() then
        target:sendRaise(1)
    elseif bit.band(target:getBehaviour(), xi.behavior.RAISABLE) == xi.behavior.RAISABLE then
        target:triggerListener("RAISE_RECEIVED", target, 1)
    end

    spell:setMsg(xi.msg.basic.MAGIC_CASTS_ON)

    return 1
end

return spellObject
