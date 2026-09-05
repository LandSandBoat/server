-----------------------------------
-- Spell: Dimensional Death
-- Damage varies with TP
-- Spell cost: 48 MP
-- Monster Type: Undead
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 5
-- Stat Bonus: DEX+1, CHR+1, HP+5
-- Level: 60
-- Casting Time: 0.5 seconds
-- Recast Time: 23.75 seconds
-- Skillchain Properties: Transfixion/Impaction
-- Combos: Accuracy Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params           = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem        = xi.ecosystem.UNDEAD
    params.tpModifier      = xi.spells.blue.tpMod.ATTACK
    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.HAND_TO_HAND
    params.skillchainType  = xi.skillchainType.TRANSFIXION
    params.skillchainType2 = xi.skillchainType.IMPACTION

    params.numHits       = 1
    params.ftp0          = 2.25
    params.ftp1500       = 2.25
    params.ftp3000       = 2.25
    params.ftpAzure      = 2.25
    params.baseDamageCap = 999 -- uncapped
    params.attackMult    = 1.2

    if params.hasAzureLore then
        params.attackMult = 2.3
    elseif params.hasChainAffinity then
        params.attackMult = xi.spells.blue.calculatefTP(caster:getTP(), 1.2, 2.2, 2.25)
    end

    params.str_wsc = 0.5

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
