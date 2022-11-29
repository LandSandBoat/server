-----------------------------------
-- Spell: Wild Oats
-- Additional effect: Vitality Down. Duration of effect varies on TP
-- Spell cost: 9 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 3
-- Stat Bonus: CHR+1, HP+10
-- Level: 4
-- Casting Time: 0.5 seconds
-- Recast Time: 7.25 seconds
-- Skillchain Element(s): Transfixion
-- Combos: Beast Killer
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.tpmod = TPMOD_DURATION
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.scattr = SC_TRANSFIXION
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.numhits = 1
    params.multiplier = 1.84
    params.tp150 = 1.84
    params.tp300 = 1.84
    params.azuretp = 1.84
    params.duppercap = 11
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.3
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    -- Additional effect: VIT down (-15 for 30s/60s. Effect decreases by 1 every 2s/4s)
    if damage > 0 and not target:hasStatusEffect(xi.effect.VIT_DOWN) then
        local resist = applyResistanceEffect(caster, target, spell, params)
        if resist >= 0.5 then
            target:addStatusEffect(xi.effect.VIT_DOWN, 15, 4 * resist, 60 * resist)
        end
    end

    return damage
end

return spellObject
