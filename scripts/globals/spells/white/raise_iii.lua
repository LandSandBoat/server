-----------------------------------
-- Spell: Raise
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:isPC() then
        target:sendRaise(3)
    elseif bit.band(target:getBehaviour(), xi.behavior.RAISABLE) == xi.behavior.RAISABLE then
        target:triggerListener("RAISE_RECEIVED", target, 3)
    end

    spell:setMsg(xi.msg.basic.MAGIC_CASTS_ON)

    return 3
end

return spellObject
