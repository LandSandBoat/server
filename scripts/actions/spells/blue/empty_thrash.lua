-----------------------------------
-- Spell: Empty Thrash
-- Delivers an area attack. Accuracy varies with TP
-- Spell cost: 33 MP
-- Monster Type: Empty
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 3
-- Stat Bonus: STR+3 CHR-2
-- Level: 87
-- Casting Time: 0.5 seconds
-- Recast Time: 40.75 seconds
-- Skillchain Element(s): Compression, Scission
-- Combos: Doule Attack, Triple Attack
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params           = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem       = xi.ecosystem.EMPTY
    params.tpModifier      = xi.spells.blue.tpMod.ACC
    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.SLASHING
    params.skillchainType  = xi.skillchainType.COMPRESSION
    params.skillchainType2 = xi.skillchainType.SCISSION

    params.numHits       = 1
    params.ftp0          = 2.0
    params.ftp1500       = 2.0
    params.ftp3000       = 2.0
    params.ftpAzure      = 2.0
    params.baseDamageCap = 33

    params.str_wsc = 0.5

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
