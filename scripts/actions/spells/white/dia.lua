-----------------------------------
-- Spell: Dia
-- Lowers an enemy's defense and gradually deals light elemental damage.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local damage = xi.spells.damage.useDamageSpell(caster, target, spell)
    local tier   = 1

    -- Check for Bio
    local bio = target:getStatusEffect(xi.effect.BIO)
    if bio and bio:getTier() < tier then
        target:delStatusEffect(xi.effect.BIO)
        local power = 1 + caster:getMod(xi.mod.DIA_DOT)

        target:addStatusEffect(xi.effect.DIA, power, 3, 60, 0, 10, tier)
    end

    return damage
end

return spellObject
