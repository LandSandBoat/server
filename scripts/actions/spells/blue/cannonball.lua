-----------------------------------
-- Spell: Cannonball
-- Damage varies with TP
-- Spell cost: 66 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: STR+1, DEX+1
-- Level: 70
-- Casting Time: 0.5 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element(s): Fusion
-- Combos: None
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params         = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem     = xi.ecosystem.VERMIN
    params.tpModifier    = xi.spells.blue.tpMod.DAMAGE
    params.attackType    = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.skillchainType = xi.skillchainType.FUSION

    params.numHits       = 1
    params.ftp0          = 1.75
    params.ftp1500       = 2.125
    params.ftp3000       = 2.75
    params.ftpAzure      = 3
    params.baseDamageCap = 999 -- uncapped

    params.str_wsc = 0.5
    params.vit_wsc = 0.5

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
