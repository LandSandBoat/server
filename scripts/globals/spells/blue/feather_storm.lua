-----------------------------------
-- Spell: Feather Storm
-- Additional effect: Poison. Chance of effect varies with TP
-- Spell cost: 12 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 3
-- Stat Bonus: CHR+2, HP+5
-- Level: 12
-- Casting Time: 0.5 seconds
-- Recast Time: 10 seconds
-- Skillchain Element(s): Transfixion
-- Combos: Rapid Shot
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
    params.ecosystem = xi.ecosystem.BEASTMEN
    params.tpmod = TPMOD_CRITICAL
    params.attackType = xi.attackType.RANGED
    params.damageType = xi.damageType.PIERCING
    params.scattr = SC_TRANSFIXION
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.numhits = 1
    params.multiplier = 2
    params.tp150 = 2
    params.tp300 = 2
    params.azuretp = 2
    params.duppercap = 17
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.3
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = blueDoPhysicalSpell(caster, target, spell, params)
    damage = blueFinalizeDamage(caster, target, spell, damage, params)

    -- Added effect: Poison (1/tick for 90s/180s)
    if damage > 0 and not target:hasStatusEffect(xi.effect.POISON) then
        local resist = applyResistanceEffect(caster, target, spell, params)
        if resist >= 0.5 then
            target:addStatusEffect(xi.effect.POISON, 1, 0, 180 * resist)
        end
    end

    return damage
end

return spellObject
