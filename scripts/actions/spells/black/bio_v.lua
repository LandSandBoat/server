-----------------------------------
-- Spell: Bio V
-- Deals dark damage that weakens an enemy's attacks and gradually reduces its HP.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local damage = xi.spells.damage.useDamageSpell(caster, target, spell)
    local tier   = 10

    -- Check for Dia.
    local dia = target:getStatusEffect(xi.effect.DIA)
    if dia and dia:getTier() < tier then
        target:delStatusEffect(xi.effect.DIA)

        -- Calculate DoT effect (rough, though fairly accurate)
        local power = 5 + math.floor(caster:getSkillLevel(xi.skill.DARK_MAGIC) / 50)

        target:addStatusEffect(xi.effect.BIO, power, 3, 180, 0, 25, tier)
    end

    return damage
end

return spellObject
