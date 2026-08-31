-----------------------------------
-- Spell: Frenetic Rip
-- Delivers a threefold attack. Damage varies with TP
-- Spell cost: 61 MP
-- Monster Type: Demon
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: INT+1
-- Level: 63
-- Casting Time: 0.5 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element: Induration
-- Combos: Accuracy Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.DEMON
    params.tpModifier     = xi.spells.blue.tpMod.DAMAGE
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HAND_TO_HAND
    params.skillchainType = xi.skillchainType.INDURATION

    params.numHits       = 3
    params.ftp0          = 1.36
    params.ftp1500       = 2.08
    params.ftp3000       = 2.36
    params.ftpAzure      = 2.61
    params.baseDamageCap = 75

    params.str_wsc = 0.2
    params.dex_wsc = 0.2

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
