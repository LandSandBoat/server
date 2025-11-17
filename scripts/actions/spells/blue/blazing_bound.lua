-----------------------------------
-- Spell: Blazing Bound
-- Deals fire damage to a single target
-- Spell cost: 113 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+2, AGI+1
-- Level: 80
-- Casting Time: 5 seconds
-- Recast Time: 30 seconds
-- Magic Bursts on: Liquefaction, Fusion, Light
-- Combos: Dual Wield
-----------------------------------
-- Research from BG-Wiki:
-- - WSC: 30% STR
-- - fTP: 3.0
-- - dINT Multiplier: 2.0
-- - CRITICAL: Uses Magic Defense Bonus (MDB) instead of Magic Attack Bonus (MAB)
-- - Player version does NOT inflict Burn
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem   = xi.ecosystem.ARCANA
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.FIRE
    params.attribute   = xi.mod.INT
    params.multiplier  = 3.0
    params.tMultiplier = 2.0
    params.duppercap   = 81  -- Level 80 spell
    params.str_wsc     = 0.3
    params.dex_wsc     = 0.0
    params.vit_wsc     = 0.0
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.0
    params.mnd_wsc     = 0.0
    params.chr_wsc     = 0.0

    -- Note: This spell should use MDB instead of MAB, but current engine
    -- may not support this unique mechanic. Using standard magical spell formula.
    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    return damage
end

return spellObject
