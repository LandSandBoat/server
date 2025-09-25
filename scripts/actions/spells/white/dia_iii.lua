-----------------------------------
-- Spell: Dia III
-- Lowers an enemy's defense and gradually deals light elemental damage.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local damage = xi.spells.damage.useDamageSpell(caster, target, spell)

    -- Check for Bio
    local bio = target:getStatusEffect(xi.effect.BIO)
    if bio and bio:getTier() >= 3 then
        return damage
    else
        target:delStatusEffect(xi.effect.BIO)
    end

    -- Apply effect.
    local power = 3 + caster:getMod(xi.mod.DIA_DOT)

    target:addStatusEffect(xi.effect.DIA, power, 3, 180, 0, 20, 3)

    return damage
end

return spellObject
