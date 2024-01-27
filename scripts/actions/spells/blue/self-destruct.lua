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
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    caster:setLocalVar('selfdestructHp', caster:getHP())
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.FIRE
    local playerHP = caster:getLocalVar('selfdestructHp')
    local damage = playerHP - 1

    if damage > 0 then
        damage = xi.spells.blue.applySpellDamage(caster, target, spell, damage, params)
        caster:setHP(1)
        caster:delStatusEffectSilent(xi.effect.WEAKNESS)
        caster:addStatusEffect(xi.effect.WEAKNESS, 1, 0, 300)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return damage
end

return spellObject
