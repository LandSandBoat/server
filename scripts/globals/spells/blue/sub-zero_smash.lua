-----------------------------------
-- Spell: Sub-zero Smash
-- Additional Effect: Paralysis. Damage varies with TP
-- Spell cost: 44 MP
-- Monster Type: Aquans
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: HP+10 VIT+3
-- Level: 72
-- Casting Time: 1 second
-- Recast Time: 30 seconds
-- Skillchain Element(s): Fragmentation
-- Combos: Fast Cast
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
    params.ecosystem = xi.ecosystem.AQUAN
    params.tpmod = TPMOD_CRITICAL
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.BLUNT
    params.scattr = SC_FRAGMENTATION
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.numhits = 1
    params.multiplier = 2.0
    params.tp150 = 2.0
    params.tp300 = 2.0
    params.azuretp = 2.0
    params.duppercap = 72
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.6
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = bluDoPhysicalSpell(caster, target, spell, params)
    damage = bluFinalizeDamage(caster, target, spell, damage, params)

    -- Added effect: Paralyze (20% for 90s/180s)
    if damage > 0 and not target:hasStatusEffect(xi.effect.PARALYSIS) then
        local resist = applyResistanceEffect(caster, target, spell, params)
        if resist >= 0.5 then
            target:addStatusEffect(xi.effect.PARALYSIS, 10, 0, 180 * resist)
        end
    end

    return damage
end

return spellObject
