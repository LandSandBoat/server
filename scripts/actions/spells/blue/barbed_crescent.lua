-----------------------------------
-- Spell: Barbed Crescent
-- Delivers a single hit attack. Additional effect: Accuracy Down
-- Spell cost: 52 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: STR-3, DEX+4
-- Level: 99
-- Casting Time: 0.5 seconds
-- Recast Time: 18 seconds
-- Combos: Dual Wield
-----------------------------------
-- Research from BG-Wiki:
-- - Number of Hits: 1
-- - WSC: 50% DEX
-- - fTP: 2.0 (Base)
-- - Additional Effect: Accuracy Down -30, 120s duration
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.VERMIN
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.numhits = 1
    params.multiplier = 2.0
    params.tp150 = 2.0  -- Static fTP
    params.tp300 = 2.0
    params.azuretp = 2.0
    params.duppercap = 99  -- Level 99 spell
    params.str_wsc = 0.0
    params.dex_wsc = 0.5
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage > 0 then
        -- Accuracy Down -30, 120s duration
        local effectTable =
        {
            [1] = { xi.effect.ACCURACY_DOWN, 30, 0, 120 },
        }

        xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)
    end

    return damage
end

return spellObject
