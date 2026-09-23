-----------------------------------
-- Module: Damage Ninjutsu Adjustments
-- Revert the San ninjutsu merits to a per-rank MATT/MACC bonus applied for the cast.
-- Source: https://forum.square-enix.com/ffxi/threads/55648-July.-8-2019-%28JST%29-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('damage_ninjutsu_adjustments', xi.pre(xi.expansion.ROV))

-- The merit value is the 5 per rank bonus, and the first rank only unlocks the spell.
local meritBySpell =
{
    [xi.magic.spell.KATON_SAN ] = xi.merit.KATON_SAN,
    [xi.magic.spell.HYOTON_SAN] = xi.merit.HYOTON_SAN,
    [xi.magic.spell.HUTON_SAN ] = xi.merit.HUTON_SAN,
    [xi.magic.spell.DOTON_SAN ] = xi.merit.DOTON_SAN,
    [xi.magic.spell.RAITON_SAN] = xi.merit.RAITON_SAN,
    [xi.magic.spell.SUITON_SAN] = xi.merit.SUITON_SAN,
}

m:addOverride('xi.spells.damage.calculateMagicBonusDiff', function(caster, target, spellId, skillType, spellElement, bonusMATT)
    local merit = meritBySpell[spellId]

    if merit then
        bonusMATT = bonusMATT + math.max(caster:getMerit(merit) - 5, 0)
    end

    return super(caster, target, spellId, skillType, spellElement, bonusMATT)
end)

-- Apply magic accuracy merit mod for spell calculations and remove it afterward.
m:addOverride('xi.spells.damage.useDamageSpell', function(caster, target, spell)
    local merit = meritBySpell[spell:getID()]

    if not merit then
        return super(caster, target, spell)
    end

    local maccBonus = math.max(caster:getMerit(merit) - 5, 0)

    caster:addMod(xi.mod.MACC, maccBonus)

    local castOk, damage = pcall(super, caster, target, spell)

    caster:delMod(xi.mod.MACC, maccBonus)

    if not castOk then
        error(damage, 0)
    end

    return damage
end)

return m
