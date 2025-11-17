-----------------------------------
-- Spell: Final Sting
-- Delivers a single attack. Reduces caster's HP to 1 after use
-- Spell cost: 88 MP
-- Monster Type: Vermin (Bee)
-- Spell Type: Physical
-- Blue Magic Points: 5
-- Stat Bonus: None
-- Level: 81
-- Casting Time: 5 seconds
-- Recast Time: 11 seconds
-----------------------------------
-- Combos: Zanshin
-----------------------------------
-- Notes: Damage is proportional to caster's current HP
-- Formula: Damage scales with caster's current HP (not max HP)
-- Damage varies with TP (fTP 1.0)
-- Ignores Utsusemi (shadow images)
-- Does not inflict weakness status
-- If spell misses, caster takes no HP loss
-- Fusion skillchain property
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.VERMIN
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.numhits = 1
    params.multiplier = 1.0
    params.tp150 = 1.0
    params.tp300 = 1.0
    params.azuretp = 1.0
    params.duppercap = 65 -- Damage cap: 65% of target's HP for weaker enemies
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    -- Special: Damage is based on caster's current HP
    local casterHP = caster:getHP()

    -- Final Sting uses current HP as the damage base
    -- Approximation: damage ~= current HP with multipliers
    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    -- Scale damage based on current HP (rough formula)
    local hpModifier = casterHP / caster:getMaxHP()
    damage = math.floor(damage * (1 + hpModifier * 2))

    -- Reduce caster's HP to 1 (only if spell lands)
    if damage > 0 then
        caster:setHP(1)
    end

    return damage
end

return spellObject
