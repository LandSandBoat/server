-----------------------------------
-- Spell: Dark Orb
-- Deals dark damage to a single target
-- Spell cost: 124 MP
-- Monster Type: Luminian
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 3
-- Stat Bonus: AGI+2, MND+2
-- Level: 93
-- Casting Time: 9 seconds
-- Recast Time: 45 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: Counter
-----------------------------------
-- Research from BG-Wiki:
-- - WSC: 40% INT
-- - fTP: 4.5
-- - dINT Multiplier: 2.0
-- - Very long cast time, long range (21')
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem   = xi.ecosystem.LUMINIAN
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.DARK
    params.attribute   = xi.mod.INT
    params.multiplier  = 4.5
    params.tMultiplier = 2.0
    params.duppercap   = 95  -- Level 93 spell
    params.str_wsc     = 0.0
    params.dex_wsc     = 0.0
    params.vit_wsc     = 0.0
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.4
    params.mnd_wsc     = 0.0
    params.chr_wsc     = 0.0

    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    return damage
end

return spellObject
