-----------------------------------
-- Spell: Screwdriver
-- Deals critical damage. Chance of critical hit varies with TP
-- Spell cost: 21 MP
-- Monster Type: Aquans
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+1, CHR+1, HP+10
-- Level: 26
-- Casting Time: 0.5 seconds
-- Recast Time: 14 seconds
-- Skillchain Element(s): Transfixion/Scission
-- Combos: Evasion Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params        = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem    = xi.ecosystem.AQUAN
    params.tpModifier   = xi.spells.blue.tpMod.CRITICAL

    if params.hasAzureLore then
        params.critChance = 35
    elseif params.hasChainAffinity then
        params.critChance = xi.spells.blue.calculatefTP(caster:getTP(), 0, 15, 30)
    end

    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.PIERCING
    params.skillchainType  = xi.skillchainType.TRANSFIXION
    params.skillchainType2 = xi.skillchainType.SCISSION

    params.numHits       = 1
    params.ftp0          = 1.375
    params.ftp1500       = 1.375
    params.ftp3000       = 1.375
    params.ftpAzure      = 1.375
    params.baseDamageCap = 27
    params.attackMult    = 1.6

    params.str_wsc = 0.2
    params.mnd_wsc = 0.2

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
