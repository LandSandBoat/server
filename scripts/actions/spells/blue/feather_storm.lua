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
    local params = {}
    params.ecosystem = xi.ecosystem.BEASTMEN
    params.tpmod = xi.spells.blue.tpMod.CRITICAL
    params.critchance = 0
    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        params.critchance = 55
    elseif caster:hasStatusEffect(xi.effect.CHAIN_AFFINITY) then
        params.critchance = math.floor(caster:getTP() / 75)
    end

    params.attackType = xi.attackType.RANGED
    params.damageType = xi.damageType.PIERCING
    params.scattr     = xi.skillchainType.TRANSFIXION
    params.numhits    = 1
    params.multiplier = 2
    params.tp150      = 2
    params.tp300      = 2
    params.azuretp    = 2
    params.duppercap  = 17
    params.str_wsc    = 0.0
    params.dex_wsc    = 0.0
    params.vit_wsc    = 0.0
    params.agi_wsc    = 0.3
    params.int_wsc    = 0.0
    params.mnd_wsc    = 0.0
    params.chr_wsc    = 0.0

    -- Handle damage.
    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage <= 0 then
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
