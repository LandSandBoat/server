-----------------------------------
-- Spell: Jet Stream
-- Delivers a threefold attack. Accuracy varies with TP
-- Spell cost: 47 MP
-- Monster Type: Birds
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: DEX+2
-- Level: 38
-- Casting Time: 0.5 seconds
-- Recast Time: 23 seconds
-- Skillchain Element(s): Impaction
-- Combos: Rapid Shot
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.BIRD
    params.tpModifier = xi.spells.blue.tpMod.ACC

    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        params.bonusAcc = 70
    elseif caster:hasStatusEffect(xi.effect.CHAIN_AFFINITY) then
        params.bonusAcc = math.floor(caster:getTP() / 50)
    end

    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.skillchainType = xi.skillchainType.IMPACTION

    params.numHits       = 3
    params.ftp0          = 1.125
    params.ftp1500       = 1.125
    params.ftp3000       = 1.125
    params.ftpAzure      = 1.125
    params.baseDamageCap = 39

    params.agi_wsc = 0.3

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
