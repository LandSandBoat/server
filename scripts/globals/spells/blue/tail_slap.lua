-----------------------------------
-- Spell: Tail Slap
-- Delivers an area attack. Additional effect: "Stun." Damage varies with TP
-- Spell cost: 77 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: MND+2
-- Level: 69
-- Casting Time: 1 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element: Reverberation
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
    params.ecosystem = xi.ecosystem.BEASTMEN
    params.tpmod = TPMOD_ATTACK
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.HTH
    params.scattr = SC_REVERBERATION
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.numhits = 1
    params.multiplier = 1.625
    params.tp150 = 1.625
    params.tp300 = 1.625
    params.azuretp = 1.625
    params.duppercap = 75
    params.str_wsc = 0.2
    params.dex_wsc = 0.0
    params.vit_wsc = 0.5
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = bluDoPhysicalSpell(caster, target, spell, params)
    damage = bluFinalizeDamage(caster, target, spell, damage, params)

    -- Additional effect: Stun (2.5/5s)
    if damage > 0 then
        local resist = applyResistanceEffect(caster, target, spell, params)
        if resist >= 0.5 then
            target:delStatusEffectSilent(xi.effect.STUN)
            target:addStatusEffect(xi.effect.STUN, 1, 0, 5 * resist)
        end
    end

    return damage
end

return spellObject
