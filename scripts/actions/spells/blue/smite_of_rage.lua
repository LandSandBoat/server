-----------------------------------
-- Spell: Smite of Rage
-- Damage varies with TP
-- Spell cost: 28 MP
-- Monster Type: Arcana
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 3
-- Stat Bonus: AGI+3
-- Level: 34
-- Casting Time: 0.5 seconds
-- Recast Time: 13 seconds
-- Skillchain Element(s): Detonation
-- Combos: Undead Killer
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.ARCANA
    params.tpModifier     = xi.spells.blue.tpMod.DAMAGE
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.skillchainType = xi.skillchainType.DETONATION

    params.numHits       = 1
    params.ftp0          = 1.5
    params.ftp1500       = 2.25
    params.ftp3000       = 2.5
    params.ftpAzure      = 2.53125
    params.baseDamageCap = 35
    params.attackMult    = 1.3

    params.str_wsc = 0.2
    params.dex_wsc = 0.2

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
