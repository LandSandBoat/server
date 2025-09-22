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

    -- Check for Dia
    local dia = target:getStatusEffect(xi.effect.DIA)
    if dia and dia:getPower() > 2 then
        return damage
    else
        target:delStatusEffect(xi.effect.DIA)
    end

    -- Calculate DoT effect
    -- http://wiki.ffo.jp/html/1954.html
    local power = caster:getSkillLevel(xi.skill.DARK_MAGIC)
    power       = math.floor((power + 29) / 40)
    power       = utils.clamp(power, 3, 8)

    target:addStatusEffect(xi.effect.BIO, power, 3, 120, 0, 15, 2)

    return damage
end

return spellObject
