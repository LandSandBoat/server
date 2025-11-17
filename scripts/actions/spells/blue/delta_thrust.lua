-----------------------------------
-- Spell: Delta Thrust
-- Delivers a threefold attack. Additional effect: Plague
-- Spell cost: 28 MP
-- Monster Type: Demon
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 2
-- Stat Bonus: HP+15, MP-5, INT-1
-- Level: 89
-- Casting Time: 0.5 seconds
-- Recast Time: 18 seconds
-- Combos: Magic Accuracy Bonus
-----------------------------------
-- Research from BG-Wiki:
-- - Number of Hits: 3
-- - WSC: 20% STR, 50% VIT
-- - fTP: 1.09375 (Static)
-- - Additional Effect: Plague (40-60s duration)
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.DEMON
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.numhits = 3
    params.multiplier = 1.09375
    params.tp150 = 1.09375  -- Static fTP
    params.tp300 = 1.09375
    params.azuretp = 1.09375
    params.duppercap = 90  -- Level 89 spell
    params.str_wsc = 0.2
    params.dex_wsc = 0.0
    params.vit_wsc = 0.5
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage > 0 then
        -- Plague effect: 40-60s duration
        local effectTable =
        {
            [1] = { xi.effect.PLAGUE, 5, 3, 50 },  -- 5 HP/tick, 50s duration
        }

        xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)
    end

    return damage
end

return spellObject
