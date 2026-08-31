-----------------------------------
-- Spell: Death Scissors
-- Damage varies with TP
-- Spell cost: 51 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 5
-- Stat Bonus: MND+2, CHR+2, HP+5
-- Level: 60
-- Casting Time: 0.5 seconds
-- Recast Time: 24.5 seconds
-- Skillchain Properties: Compression/Reverberation
-- Combos: Attack Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params           = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem       = xi.ecosystem.VERMIN
    params.tpModifier      = xi.spells.blue.tpMod.DAMAGE
    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.SLASHING
    params.skillchainType  = xi.skillchainType.COMPRESSION
    params.skillchainType2 = xi.skillchainType.REVERBERATION

    params.numHits       = 1
    params.ftp0          = 1.5
    params.ftp1500       = 2.75
    params.ftp3000       = 3.25
    params.ftpAzure      = 3.3
    params.baseDamageCap = 74

    params.str_wsc = 0.6

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
