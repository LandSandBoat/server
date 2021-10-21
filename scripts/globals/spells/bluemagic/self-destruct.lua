-----------------------------------
-- Spell: Self-Destruct
-- Sacrifices HP to damage enemies within range. Affects caster with Weakness
-- Spell cost: 100 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 3
-- Stat Bonus: STR+2
-- Level: 50
-- Casting Time: 3.25 seconds
-- Recast Time: 21 seconds
-- Magic Bursts on: Liquefaction, Fusion, and Light
-- Combos: Auto Refresh
-----------------------------------
local spell_object = {}

require("scripts/settings/main")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/bluemagic")

spell_object.onMagicCastingCheck = function(caster, target, spell)
    caster:setLocalVar("self-destruct_hp", caster:getHP())
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local params = {}
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.FIRE
    params.diff = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.FIRE
    local resist = applyResistance(caster, target, spell, params)
    damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    local duration = 300
    local playerHP = caster:getLocalVar("self-destruct_hp")
    local damage = playerHP - 1 * resist

    if damage > 0 then
        target:takeSpellDamage(caster, spell, playerHP, xi.attackType.MAGICAL, xi.damageType.FIRE)
        caster:setHP(1)
        caster:delStatusEffect(xi.effect.WEAKNESS)
        caster:addStatusEffect(xi.effect.WEAKNESS, 1, 0, duration)
    end

    return damage
end

return spell_object
