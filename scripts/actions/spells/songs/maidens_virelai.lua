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

    -- Per wiki, Virelai wipes all shadows even if it resists or the target is immune to charm
    -- This can't be done in the onSpellCast function (that runs after it "hits")
    spell:setFlag(xi.magic.spellFlag.WIPE_SHADOWS)
    -- TODO:
    -- 1. move "spell:setFlag()" to a SpellFlags group of get/set/add/del functions
    -- 2. move spell flags to the spell table, so we don't have to do hacky things inside the casting check!

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enfeebling.useEnfeeblingSong(caster, target, spell)
end

return spellObject
