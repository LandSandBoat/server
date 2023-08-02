-----------------------------------
-- Spell: Sudden Lunge
-- Damage varies with TP. Additional effect: "Stun."
-- Spell cost: 18 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 4
-- Stat Bonus: HP-5 MP-5 DEX+1 AGI+1
-- Level: 95
-- Casting Time: 0.5 seconds
-- Recast Time: 15 seconds
-- Skillchain Element(s): Detonation
-- Combos: Store TP
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
    params.ecosystem = xi.ecosystem.VERMIN
    params.tpmod = TPMOD_DAMAGE
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.scattr = SC_DETONATION
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.numhits = 1
    params.multiplier = 1.5
    params.tp150 = 2.5
    params.tp300 = 3
    params.azuretp = 3.5
    params.duppercap = 100
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.4
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    params.effect = xi.effect.STUN
    local power = 1
    local tick = 0
    local duration = 5

    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
    xi.spells.blue.usePhysicalSpellAddedEffect(caster, target, spell, params, damage, power, tick, duration)

    return damage
end

return spellObject
