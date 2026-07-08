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
    local params = {}
    params.ecosystem = xi.ecosystem.BEASTMEN
    params.tpmod     = xi.spells.blue.tpMod.ACC
    params.bonusacc  = 0
    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        params.bonusacc = 70
    elseif caster:hasStatusEffect(xi.effect.CHAIN_AFFINITY) then
        params.bonusacc = math.floor(caster:getTP() / 50)
    end

    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.BLUNT
    params.scattr = xi.skillchainType.FUSION
    params.scattr2 = xi.skillchainType.IMPACTION
    params.numhits = 3
    params.multiplier = 1.25
    params.tp150 = 1.25
    params.tp300 = 1.25
    params.azuretp = 1.25
    params.duppercap = 75
    params.str_wsc = 0.30
    params.dex_wsc = 0.30
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
