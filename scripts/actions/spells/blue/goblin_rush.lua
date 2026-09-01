-----------------------------------
-- Spell: Goblin Rush
-- Delivers a threefold attack. Accuracy varies with TP
-- Spell cost: 81 MP
-- Monster Type: BEASTMEN
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: HP+10 DEX+3 MND-3
-- Level: 81
-- Casting Time: 0.5 seconds
-- Recast Time: 25.5 seconds
-- Skillchain Element(s): Fusion/Impaction
-- Combos: Skillchain Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.BEASTMEN
    params.tpModifier = xi.spells.blue.tpMod.ACC

    if params.hasAzureLore then
        params.bonusAcc = 70
    elseif params.hasChainAffinity then
        params.bonusAcc = math.floor(caster:getTP() / 50)
    end

    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.BLUNT
    params.skillchainType  = xi.skillchainType.FUSION
    params.skillchainType2 = xi.skillchainType.IMPACTION

    params.numHits       = 3
    params.ftp0          = 1.25
    params.ftp1500       = 1.25
    params.ftp3000       = 1.25
    params.ftpAzure      = 1.25
    params.baseDamageCap = 75

    params.str_wsc = 0.30
    params.dex_wsc = 0.30

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
