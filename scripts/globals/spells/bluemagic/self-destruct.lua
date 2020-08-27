-----------------------------------------
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
-----------------------------------------

require("scripts/globals/settings")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/bluemagic")

function onMagicCastingCheck(caster, target, spell)
    caster:setLocalVar("self-destruct_hp", caster:getHP())
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 300
    local playerHP = caster:getLocalVar("self-destruct_hp")
    local damage = playerHP - 1

    if damage > 0 then
        target:takeSpellDamage(caster, spell, playerHP, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
        caster:setHP(1)
        caster:delStatusEffect(tpz.effect.WEAKNESS)
        caster:addStatusEffect(tpz.effect.WEAKNESS, 1, 0, duration)
    end

    return damage
end
