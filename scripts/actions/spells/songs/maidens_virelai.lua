-----------------------------------
-- Spell: Maiden's Virelai
-- Charms pet
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if caster:getPet() ~= nil then
        return xi.msg.basic.ALREADY_HAS_A_PET
    elseif target:getMaster() ~= nil and target:getMaster():isPC() then
        return xi.msg.basic.THAT_SOMEONES_PET
    end

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enfeebling.useEnfeeblingSong(caster, target, spell)
end

return spellObject
