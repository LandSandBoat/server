-----------------------------------
-- Spell: Bio II
-- Deals dark damage that weakens an enemy's attacks and gradually reduces its HP.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local damage = xi.spells.damage.useDamageSpell(caster, target, spell)
    local tier   = 4

    -- Check for Dia.
    local dia = target:getStatusEffect(xi.effect.DIA)
    if
        not dia or
        (dia and dia:getTier() < tier)
    then
        target:delStatusEffect(xi.effect.DIA)

        -- Calculate DoT effect: http://wiki.ffo.jp/html/1954.html
        local power = caster:getSkillLevel(xi.skill.DARK_MAGIC)
        power       = math.floor((power + 29) / 40)
        power       = utils.clamp(power, 3, 8)

        target:addStatusEffect(xi.effect.BIO, power, 3, 120, 0, 15, tier)
    end

    return damage
end

return spellObject
