-----------------------------------
-- Spell: Quadratic Continuum
-- Delivers a fourfold attack. Damage varies with TP
-- Spell cost: 91 MP
-- Monster Type: Empty
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 4
-- Stat Bonus: DEX+3 CHR-2
-- Level: 85
-- Casting Time: 1 seconds
-- Recast Time: 31.75 seconds
-- Skillchain Element(s): Distortion/Scission
-- Combos: Dual Wield
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params           = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem       = xi.ecosystem.EMPTY
    params.tpModifier      = xi.spells.blue.tpMod.DAMAGE
    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.PIERCING
    params.skillchainType  = xi.skillchainType.DISTORTION
    params.skillchainType2 = xi.skillchainType.SCISSION

    params.numHits       = 4
    params.ftp0          = 1.25
    params.ftp1500       = 1.5
    params.ftp3000       = 1.75
    params.ftpAzure      = 2.0
    params.baseDamageCap = 75

    params.str_wsc = 0.32
    params.vit_wsc = 0.32

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
