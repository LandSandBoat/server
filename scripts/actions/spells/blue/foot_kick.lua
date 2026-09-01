-----------------------------------
-- Spell: Foot Kick
-- Deals critical damage. Chance of critical hit varies with TP
-- Spell cost: 5 MP
-- Monster Type: Beasts
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: AGI+1
-- Level: 1
-- Casting Time: 0.5 seconds
-- Recast Time: 6.5 seconds
-- Skillchain Property: Detonation
-- Combos: Lizard Killer
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.BEAST
    params.tpModifier = xi.spells.blue.tpMod.CRITICAL

    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        params.critChance = 55
    elseif caster:hasStatusEffect(xi.effect.CHAIN_AFFINITY) then
        params.critChance = math.floor(caster:getTP() / 75)
    end

    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.skillchainType = xi.skillchainType.DETONATION

    params.numHits       = 1
    params.ftp0          = 1.0
    params.ftp1500       = 1.0
    params.ftp3000       = 1.0
    params.ftpAzure      = 1.0
    params.baseDamageCap = 9

    params.str_wsc = 0.1
    params.dex_wsc = 0.1

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
