-----------------------------------
-- Spell: Helldive
-- Damage varies with TP
-- Spell cost: 16 MP
-- Monster Type: Birds
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: CHR+1, HP+5
-- Level: 16
-- Casting Time: 0.5 seconds
-- Recast Time: 11.25 seconds
-- Skillchain Property: Transfixion
-- Combos: None
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.BIRD
    params.tpModifier     = xi.spells.blue.tpMod.DAMAGE
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.skillchainType = xi.skillchainType.TRANSFIXION

    params.numHits       = 1
    params.ftp0          = 1.25
    params.ftp1500       = 1.625
    params.ftp3000       = 2.00
    params.ftpAzure      = 2.125
    params.baseDamageCap = 19

    params.agi_wsc = 0.3

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
