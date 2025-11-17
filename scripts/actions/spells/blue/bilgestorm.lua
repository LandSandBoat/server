-----------------------------------
-- Spell: Bilgestorm
-- Deals physical damage to enemies within area of effect. Additional effects: Attack Down, Accuracy Down, Defense Down
-- Spell cost: 122 MP
-- Monster Type: Amorph
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: None
-- Level: 99
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-----------------------------------
-- Combos: None
-----------------------------------
-- Notes: Requires Unbridled Learning.
-- PROXY FORMULA: Based on Empty Thrash (WSC 50% STR, fTP 2.0)
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    -- Requires Unbridled Learning
    if not caster:hasStatusEffect(xi.effect.UNBRIDLED_LEARNING) then
        return xi.msg.basic.STATUS_PREVENTS
    end

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Empty Thrash formula
    local params = {}
    params.ecosystem = xi.ecosystem.AMORPH
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.HTH
    params.numhits = 1
    params.multiplier = 2.0
    params.tp150 = 2.0
    params.tp300 = 2.0
    params.azuretp = 2.0
    params.duppercap = 99
    params.str_wsc = 0.5
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage > 0 then
        -- Attack Down, Accuracy Down, Defense Down (30-60s, using 45s)
        local effectTable =
        {
            [1] = { xi.effect.ATTACK_DOWN, 15, 0, 45 },
            [2] = { xi.effect.ACCURACY_DOWN, 15, 0, 45 },
            [3] = { xi.effect.DEFENSE_DOWN, 15, 0, 45 },
        }

        xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)
    end

    return damage
end

return spellObject
