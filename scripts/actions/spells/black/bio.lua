-----------------------------------
-- Spell: Bio
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
    if dia and dia:getPower() > 1 then
        return damage
    else
        target:delStatusEffect(xi.effect.DIA)
    end

    -- Calculate DoT effect
    -- http://wiki.ffo.jp/html/1954.html
    local power = caster:getSkillLevel(xi.skill.DARK_MAGIC)
    power       = math.ceil(power / 40)
    power       = utils.clamp(power, 1, 3)

    target:addStatusEffect(xi.effect.BIO, power, 3, 60, 0, 10, 1)

    return damage
end

return spellObject
