-----------------------------------
-- Spell: Benthic Typhoon
-- Deals physical damage to enemies within a fan-shaped area. Additional effect: Defense Down and Magic Defense Down
-- Spell cost: 56 MP
-- Monster Type: Aquan
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 4
-- Stat Bonus: STR+2, VIT+2, DEX-1, AGI-1
-- Level: 83
-- Casting Time: 3 seconds
-- Recast Time: 30 seconds
-- Combos: Skillchain Bonus
-----------------------------------
-- Research from BG-Wiki:
-- - Number of Hits: 1
-- - WSC: 60% AGI
-- - fTP: 4.0 (Base), 4.5 (1500 TP), 5.0 (3000 TP)
-- - Additional Effects: Defense Down (-10%), Magic Defense Down (-10%), 60s duration
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.AQUAN
    params.tpmod = xi.spells.blue.tpMod.DAMAGE
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.numhits = 1
    params.multiplier = 4.0
    params.tp150 = 4.5
    params.tp300 = 5.0
    params.azuretp = 5.25
    params.duppercap = 84  -- Level 83 spell
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.6
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage > 0 then
        -- Defense Down (-10%) and Magic Defense Down (-10%), 60s duration
        local effectTable =
        {
            [1] = { xi.effect.DEFENSE_DOWN, 10, 0, 60 },
            [2] = { xi.effect.MAGIC_DEF_DOWN, 10, 0, 60 },
        }

        xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)
    end

    return damage
end

return spellObject
