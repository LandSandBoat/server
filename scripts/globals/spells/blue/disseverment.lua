-----------------------------------
-- Spell: Disseverment
-- Delivers a fivefold attack. Additional effect: Poison. Accuracy varies with TP
-- Spell cost: 74 MP
-- Monster Type: Luminians
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 5
-- Stat Bonus: INT+1, MND-1
-- Level: 72
-- Casting Time: 0.5 seconds
-- Recast Time: 32.75 seconds
-- Skillchain Element(s): Distortion
-- Combos: Accuracy Bonus
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
    params.ecosystem = xi.ecosystem.LUMINIAN
    params.tpmod = TPMOD_ACC
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.scattr = SC_DISTORTION
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.numhits = 5
    params.multiplier = 1.5
    params.tp150 = 1.5
    params.tp300 = 1.5
    params.azuretp = 1.5
    params.duppercap = 100
    params.str_wsc = 0.2
    params.dex_wsc = 0.2
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    -- Added effect: Poison ((level/5+3)/tick for 90s/180s)
    if damage > 0 and not target:hasStatusEffect(xi.effect.POISON) then
        local resist = applyResistanceEffect(caster, target, spell, params)
        if resist >= 0.5 then
            local power = (caster:getMainLvl() / 5) + 3 -- from http://wiki.ffxiclopedia.org/wiki/Disseverment
            target:addStatusEffect(xi.effect.POISON, power, 0, 180 * resist)
        end
    end

    return damage
end

return spellObject
