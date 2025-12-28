-----------------------------------
-- Spell: Garuda
-- Summons Garuda to fight by your side
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.pet.onCastingCheck(caster, target, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    xi.pet.spawnPet(caster, xi.petId.GARUDA, spell)

    return 0
end

return spellObject
