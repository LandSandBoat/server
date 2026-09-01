-----------------------------------
-- Spell: Uppercut
-- Damage varies with TP
-- Spell cost: 31 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: STR+2, DEX+1
-- Level: 38
-- Casting Time: 0.5 seconds
-- Recast Time: 17.75 seconds
-- Skillchain Element(s): Liquefaction/Impaction
-- Combos: Attack Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params           = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem       = xi.ecosystem.PLANTOID
    params.tpModifier      = xi.spells.blue.tpMod.ATTACK
    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.HAND_TO_HAND
    params.skillchainType  = xi.skillchainType.LIQUEFACTION
    params.skillchainType2 = xi.skillchainType.IMPACTION

    params.numHits       = 1
    params.ftp0          = 1.5
    params.ftp1500       = 1.5
    params.ftp3000       = 1.5
    params.ftpAzure      = 1.5
    params.baseDamageCap = 39
    params.attackMult    = 1.6

    if params.hasAzureLore then
        params.attackMult = 2.4
    elseif params.hasChainAffinity then
        params.attackMult = xi.spells.blue.calculatefTP(caster:getTP(), 1.6, 2, 2.3)
    end

    params.str_wsc = 0.35

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
