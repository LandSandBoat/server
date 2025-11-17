-----------------------------------
-- Spell: Glutinous Dart
-- Delivers a piercing attack. Additional effect: Slow
-- Spell cost: 48 MP
-- Monster Type: Amorph
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 4
-- Stat Bonus: DEX+4
-- Level: 99
-- Casting Time: 0.5 seconds
-- Recast Time: 21 seconds
-----------------------------------
-- Combos: Max HP Boost
-----------------------------------
-- Notes: PROXY FORMULA: Based on Barbed Crescent (WSC 50% DEX, fTP 2.0)
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Barbed Crescent formula
    local params = {}
    params.ecosystem = xi.ecosystem.AMORPH
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.numhits = 1
    params.multiplier = 2.0
    params.tp150 = 2.0
    params.tp300 = 2.0
    params.azuretp = 2.0
    params.duppercap = 99
    params.str_wsc = 0.0
    params.dex_wsc = 0.5
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage > 0 then
        -- Slow effect
        local effectTable =
        {
            [1] = { xi.effect.SLOW, 2000, 0, 120 },
        }

        xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)
    end

    return damage
end

return spellObject
