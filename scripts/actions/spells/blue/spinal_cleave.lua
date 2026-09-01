-----------------------------------
-- Spell: Spinal Cleave
-- Accuracy varies with TP
-- Spell cost: 61 MP
-- Monster Type: Undead
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 4
-- Stat Bonus: VIT+2, INT+1, MND+1
-- Level: 63
-- Casting Time: 0.5 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element(s): Scission/Detonation
-- Combos: Attack Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.UNDEAD
    params.tpModifier = xi.spells.blue.tpMod.ACC

    -- TODO: made up
    if params.hasAzureLore then
        params.bonusAcc = 70
    elseif params.hasChainAffinity then
        params.bonusAcc = math.floor(caster:getTP() / 50)
    end

    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.SLASHING
    params.skillchainType  = xi.skillchainType.SCISSION
    params.skillchainType2 = xi.skillchainType.DETONATION

    params.numHits       = 1
    params.ftp0          = 3.0
    params.ftp1500       = 3.0
    params.ftp3000       = 3.0
    params.ftpAzure      = 3.0
    params.baseDamageCap = 999 -- uncapped
    params.attackMult    = 1.05

    params.str_wsc = 0.3

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
