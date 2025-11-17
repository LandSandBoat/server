-----------------------------------
-- Spell: Amorphic Spikes
-- Delivers a fivefold attack
-- Spell cost: 79 MP
-- Monster Type: Amorph
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 4
-- Stat Bonus: INT+5, MND+2
-- Level: 98
-- Casting Time: 0.5 seconds
-- Recast Time: 25 seconds
-- Combos: Gilfinder, Treasure Hunter
-----------------------------------
-- Research from BG-Wiki:
-- - Number of Hits: 5
-- - WSC: 20% DEX, 20% INT
-- - fTP: 1.0 (Base), 1.375 (Chain Affinity at 1500+ TP)
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.AMORPH
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.numhits = 5
    params.multiplier = 1.0
    params.tp150 = 1.0  -- Base fTP, CA modifies this
    params.tp300 = 1.0
    params.azuretp = 1.0
    params.duppercap = 99  -- Level 98 spell
    params.str_wsc = 0.0
    params.dex_wsc = 0.2
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
