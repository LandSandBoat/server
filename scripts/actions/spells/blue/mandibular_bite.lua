-----------------------------------
-- Spell: Mandibular Bite
-- Damage varies with TP
-- Spell cost: 38 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: INT+1
-- Level: 44
-- Casting Time: 0.5 seconds
-- Recast Time: 19.25 seconds
-- Skillchain property(ies): Induration
-- Combos: Plantoid Killer
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.VERMIN
    params.tpModifier     = xi.spells.blue.tpMod.ATTACK
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.skillchainType = xi.skillchainType.INDURATION

    params.numHits       = 1
    params.ftp0          = 2.0
    params.ftp1500       = 2.0
    params.ftp3000       = 2.0
    params.ftpAzure      = 2.0
    params.baseDamageCap = 45
    params.attackMult    = 1.75

    if params.hasAzureLore then
        params.attackMult = 2.65
    elseif params.hasChainAffinity then
        params.attackMult = xi.spells.blue.calculatefTP(caster:getTP(), 1.75, 2.1, 2.5)
    end

    params.str_wsc = 0.2
    params.int_wsc = 0.2

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
