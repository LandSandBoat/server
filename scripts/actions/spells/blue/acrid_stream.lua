-----------------------------------
-- Spell: Acrid Stream
-- Deals water damage to enemies within a fan-shaped area. Additional effect: Magic Defense Down
-- Spell cost: 89 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Water)
-- Blue Magic Points: 3
-- Stat Bonus: DEX+2, MND+2
-- Level: 77
-- Casting Time: 4 seconds
-- Recast Time: 30 seconds
-- Magic Bursts on: Reverberation, Distortion, Darkness
-- Combos: Double Attack, Triple Attack
-----------------------------------
-- Research from BG-Wiki:
-- - WSC: 30% MND
-- - fTP: 2.296875
-- - dINT Multiplier: 2.0
-- - Additional Effect: Magic Defense Down (-10), 120 seconds
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem   = xi.ecosystem.AMORPH
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.WATER
    params.attribute   = xi.mod.INT
    params.multiplier  = 2.296875
    params.tMultiplier = 2.0
    params.duppercap   = 80  -- Level 77 spell
    params.str_wsc     = 0.0
    params.dex_wsc     = 0.0
    params.vit_wsc     = 0.0
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.0
    params.mnd_wsc     = 0.3
    params.chr_wsc     = 0.0

    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    if damage <= 0 then
        return damage
    end

    -- Magic Defense Down: -10, 120 seconds
    local effectTable =
    {
        [1] = { xi.effect.MAGIC_DEF_DOWN, 10, 0, 120 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
