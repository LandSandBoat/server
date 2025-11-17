-----------------------------------
-- Spell: Thermal Pulse
-- Deals fire damage to a single target
-- Spell cost: 128 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 4
-- Stat Bonus: STR+2, INT+2
-- Level: 86
-- Casting Time: 4 seconds
-- Recast Time: 30 seconds
-----------------------------------
-- Combos: Attack Bonus
-----------------------------------
-- Notes: PROXY FORMULA: Based on Acrid Stream (WSC 30% MND, fTP 2.296875, dINT 2.0)
-- Adjusted to 30% STR given the STR+2 stat bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Acrid Stream formula, adjusted to STR-based
    local params = {}
    params.ecosystem   = xi.ecosystem.ARCANA
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.FIRE
    params.attribute   = xi.mod.INT
    params.multiplier  = 2.296875
    params.tMultiplier = 2.0
    params.duppercap   = 87
    params.str_wsc     = 0.3
    params.dex_wsc     = 0.0
    params.vit_wsc     = 0.0
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.0
    params.mnd_wsc     = 0.0
    params.chr_wsc     = 0.0

    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    return damage
end

return spellObject
