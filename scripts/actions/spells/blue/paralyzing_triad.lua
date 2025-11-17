-----------------------------------
-- Spell: Paralyzing Triad
-- Delivers a threefold attack. Additional effect: Paralysis
-- Spell cost: 72 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 8
-- Stat Bonus: DEX+5, AGI+5
-- Level: 99
-- Casting Time: 0.5 seconds
-- Recast Time: 25 seconds
-----------------------------------
-- Combos: Skillchain Bonus
-----------------------------------
-- Notes: PROXY FORMULA: Based on Amorphic Spikes/Delta Thrust (3-hit, WSC 20% DEX/20% INT, fTP 1.0)
-- Adjusted to DEX given the DEX+5 stat bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Amorphic Spikes/Delta Thrust formula (3 hits)
    local params = {}
    params.ecosystem = xi.ecosystem.VERMIN
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.numhits = 3
    params.multiplier = 1.0
    params.tp150 = 1.0
    params.tp300 = 1.0
    params.azuretp = 1.0
    params.duppercap = 99
    params.str_wsc = 0.0
    params.dex_wsc = 0.2
    params.vit_wsc = 0.0
    params.agi_wsc = 0.2
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage > 0 then
        -- Paralysis effect
        local effectTable =
        {
            [1] = { xi.effect.PARALYSIS, 20, 0, 60 },
        }

        xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)
    end

    return damage
end

return spellObject
