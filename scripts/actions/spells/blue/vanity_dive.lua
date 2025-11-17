-----------------------------------
-- Spell: Vanity Dive
-- Delivers a slashing attack. Additional effect: Dispel
-- Spell cost: 35 MP
-- Monster Type: Bird
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 4
-- Stat Bonus: DEX+3
-- Level: 82
-- Casting Time: 0.5 seconds
-- Recast Time: 18 seconds
-----------------------------------
-- Combos: Accuracy Bonus
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
    params.ecosystem = xi.ecosystem.BIRD
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.numhits = 1
    params.multiplier = 2.0
    params.tp150 = 2.0
    params.tp300 = 2.0
    params.azuretp = 2.0
    params.duppercap = 83
    params.str_wsc = 0.0
    params.dex_wsc = 0.5
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage > 0 then
        -- Dispel one buff
        target:dispelStatusEffect()
    end

    return damage
end

return spellObject
