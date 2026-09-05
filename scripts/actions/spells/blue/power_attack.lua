-----------------------------------
-- Spell: Power Attack
-- Deals critical damage. Chance of critical hit varies with TP
-- Spell cost: 5 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 1
-- Stat Bonus: MND+1
-- Level: 4
-- Casting Time: 0.5 seconds
-- Recast Time: 7.25 seconds
-- Skillchain property: Reverberation
-- Combos: Plantoid Killer
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.VERMIN
    params.tpModifier = xi.spells.blue.tpMod.CRITICAL

    if params.hasAzureLore then
        params.critChance = 35
    elseif params.hasChainAffinity then
        params.critChance = xi.spells.blue.calculatefTP(caster:getTP(), 0, 15, 30)
    end

    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.skillchainType = xi.skillchainType.REVERBERATION

    params.numHits       = 1
    params.ftp0          = 1.125
    params.ftp1500       = 1.125
    params.ftp3000       = 1.125
    params.ftpAzure      = 1.125
    params.baseDamageCap = 11
    params.attackMult    = 1.8

    params.str_wsc = 0.1
    params.vit_wsc = 0.1

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
