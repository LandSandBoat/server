-----------------------------------
-- Spell: Queasyshroom
-- Additional effect: Poison. Duration of effect varies with TP
-- Spell cost: 20 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5, MP+5
-- Level: 8
-- Casting Time: 2 seconds
-- Recast Time: 15 seconds
-- Skillchain Element(s): Compression
-- Combos: None
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.PLANTOID
    params.tpmod = TPMOD_CRITICAL
    params.attackType = xi.attackType.RANGED
    params.damageType = xi.damageType.PIERCING
    params.scattr = SC_COMPRESSION
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.numhits = 1
    params.multiplier = 1.75
    params.tp150 = 1.75
    params.tp300 = 1.75
    params.azuretp = 1.75
    params.duppercap = 15
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = blueDoPhysicalSpell(caster, target, spell, params)
    damage = blueFinalizeDamage(caster, target, spell, damage, params)

    -- Added effect: Poison (3/tick for 90s/180s)
    if damage > 0 and not target:hasStatusEffect(xi.effect.POISON) then
        local resist = applyResistanceEffect(caster, target, spell, params)
        if resist >= 0.5 then
            target:addStatusEffect(xi.effect.POISON, 3, 0, 180 * resist)
        end
    end

    return damage
end

return spellObject
