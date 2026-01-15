-----------------------------------
-- Spell: Amorphic Spikes
-- Delivers a fivefold attack. Danage varies with TP
-- Spell cost: 79 MP
-- Monster Type: AMORPH
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 4
-- Stat Bonus: INT+5 MND+2
-- Level: 98
-- Casting Time: 0.5 seconds
-- Recast Time: 58.25 seconds
-- Skillchain Element(s): Gravitation/Transfixion
-- Combos: Gilfinder / Treasure Hunter
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.AMORPH
    params.tpmod     = xi.spells.blue.tpMod.ATTACK
    params.bonusacc  = 0
    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        params.bonusacc = 70
    elseif caster:hasStatusEffect(xi.effect.CHAIN_AFFINITY) then
        params.bonusacc = math.floor(caster:getTP() / 50)
    end

    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.scattr = xi.skillchainType.GRAVITATION
    params.scattr2 = xi.skillchainType.TRANSFIXION
    params.numhits = 5
    params.multiplier = 1.0
    params.tp150 = 1.375
    params.tp300 = 1.750 -- as per https://wiki.ffo.jp/html/24665.html
    params.azuretp = 2.125 -- guessing as no wiki has this info.
    params.duppercap = 75
    params.str_wsc = 0.0
    params.dex_wsc = 0.20
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.20
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
