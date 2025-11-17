-----------------------------------
-- Spell: Embalming Earth
-- Deals earth damage to a single target
-- Spell cost: 212 MP
-- Monster Type: Undead
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 8
-- Stat Bonus: STR+5, VIT+5
-- Level: 99
-- Casting Time: 6 seconds
-- Recast Time: 60 seconds
-----------------------------------
-- Combos: Attack Bonus
-----------------------------------
-- Notes: PROXY FORMULA: Based on Acrid Stream (WSC 30% MND, fTP 2.296875, dINT 2.0)
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Acrid Stream formula
    local params = {}
    params.ecosystem   = xi.ecosystem.UNDEAD
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.EARTH
    params.attribute   = xi.mod.INT
    params.multiplier  = 2.296875
    params.tMultiplier = 2.0
    params.duppercap   = 99
    params.str_wsc     = 0.0
    params.dex_wsc     = 0.0
    params.vit_wsc     = 0.0
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.0
    params.mnd_wsc     = 0.3
    params.chr_wsc     = 0.0

    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    return damage
end

return spellObject
