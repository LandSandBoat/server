-----------------------------------
-- Spell: Hysteric Barrage
-- Delivers a fivefold attack. Damage varies with TP
-- Spell cost: 61 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Hand-to-Hand)
-- Blue Magic Points: 5
-- Stat Bonus: DEX+2, AGI+1
-- Level: 69
-- Casting Time: 0.5 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element: Detonation
-- Combos: Evasion Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.BEASTMEN
    params.tpModifier     = xi.spells.blue.tpMod.DAMAGE
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HAND_TO_HAND
    params.skillchainType = xi.skillchainType.DETONATION

    params.numHits       = 5
    params.ftp0          = 1.25
    params.ftp1500       = 1.625
    params.ftp3000       = 1.75
    params.ftpAzure      = 1.875
    params.baseDamageCap = 80

    params.dex_wsc = 0.3

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
