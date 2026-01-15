-----------------------------------
-- Spell: Delta Thrust
-- Delivers a threefold attack. Additional effect: Plague
-- Spell cost: 28 MP
-- Monster Type: Lizard
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: HP+15 MP-5 INT-1
-- Level: 89
-- Casting Time: 0.5 seconds
-- Recast Time: 15.0 seconds
-- Skillchain Element(s): Liquefaction/Detonation
-- Combos: Dual Wield
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.LIZARD
    params.bonusacc  = 0
    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        params.bonusacc = 70
    elseif caster:hasStatusEffect(xi.effect.CHAIN_AFFINITY) then
        params.bonusacc = math.floor(caster:getTP() / 50)
    end

    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.scattr = xi.skillchainType.LIQUEFACTION
    params.scattr2 = xi.skillchainType.DETONATION
    params.numhits = 3
    params.multiplier = 1.0
    params.tp150 = 1.0
    params.tp300 = 1.0
    params.azuretp = 1.0
    params.duppercap = 75
    params.str_wsc = 0.20
    params.dex_wsc = 0.0
    params.vit_wsc = 0.50
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    -- Handle damage.
    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.PLAGUE, 10, 3, 30 + math.random(0, 30) }, -- https://wiki.ffo.jp/html/22338.html
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
