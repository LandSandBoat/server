-----------------------------------
-- Spell: Bludgeon
-- Delivers a threefold attack. Accuracy varies with TP
-- Spell cost: 16 MP
-- Monster Type: Arcana
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: STR+1
-- Level: 18
-- Casting Time: 0.5 seconds
-- Recast Time: 11.75 seconds
-- Skillchain Element(s): Liquefaction
-- Combos: Undead Killer
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.ARCANA
    params.tpModifier = xi.spells.blue.tpMod.ACC

    -- This is entirely made up, apparently.
    if params.hasAzureLore then
        params.bonusAcc = 70
    elseif params.hasChainAffinity then
        params.bonusAcc = math.floor(caster:getTP() / 50)
    end

    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HAND_TO_HAND
    params.skillchainType = xi.skillchainType.LIQUEFACTION

    params.numHits       = 3
    params.ftp0          = 1.0
    params.ftp1500       = 1.0
    params.ftp3000       = 1.0
    params.ftpAzure      = 1.0
    params.baseDamageCap = 21
    params.attackMult    = 1.55

    params.chr_wsc = 0.3

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
