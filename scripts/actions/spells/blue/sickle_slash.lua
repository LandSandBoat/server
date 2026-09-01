-----------------------------------
-- Spell: Sickle Slash
-- Deals critical damage. Chance of critical hit varies with TP
-- Spell cost: 41 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: HP-5, MP+15
-- Level: 48
-- Casting Time: 0.5 seconds
-- Recast Time: 20.5 seconds
-- Skillchain Element: Compression
-- Combos: Store TP
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

    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        params.critChance = 55
    elseif caster:hasStatusEffect(xi.effect.CHAIN_AFFINITY) then
        params.critChance = math.floor(caster:getTP() / 75)
    end

    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HAND_TO_HAND
    params.skillchainType = xi.skillchainType.COMPRESSION

    params.numHits       = 1
    params.ftp0          = 1.5
    params.ftp1500       = 1.5
    params.ftp3000       = 1.5
    params.ftpAzure      = 1.5
    params.baseDamageCap = 49

    params.dex_wsc = 0.5

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
