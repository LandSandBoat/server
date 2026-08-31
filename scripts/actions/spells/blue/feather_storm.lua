-----------------------------------
-- Spell: Feather Storm
-- Additional effect: Poison. Chance of effect varies with TP
-- Spell cost: 12 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 3
-- Stat Bonus: CHR+2, HP+5
-- Level: 12
-- Casting Time: 0.5 seconds
-- Recast Time: 10 seconds
-- Skillchain Element(s): Transfixion
-- Combos: Rapid Shot
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.BEASTMEN
    params.tpModifier = xi.spells.blue.tpMod.CRITICAL

    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        params.critChance = 55
    elseif caster:hasStatusEffect(xi.effect.CHAIN_AFFINITY) then
        params.critChance = math.floor(caster:getTP() / 75)
    end

    params.attackType     = xi.attackType.RANGED
    params.damageType     = xi.damageType.PIERCING
    params.skillchainType = xi.skillchainType.TRANSFIXION

    params.numHits       = 1
    params.ftp0          = 2
    params.ftp1500       = 2
    params.ftp3000       = 2
    params.ftpAzure      = 2
    params.baseDamageCap = 17

    params.agi_wsc    = 0.3

    -- Handle damage.
    local damage, hitsLanded = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if hitsLanded <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.POISON, 1, 3, 180 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
