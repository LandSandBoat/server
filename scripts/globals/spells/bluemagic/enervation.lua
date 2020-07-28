-----------------------------------------
-- Spell: Enervation
-- Lowers the defense and magical defense of enemies within range
-- Spell cost: 48 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 5
-- Stat Bonus: HP-5, MP+5
-- Level: 67
-- Casting Time: 6 seconds
-- Recast Time: 60 seconds
-- Magic Bursts on: Compression, Gravitation, and Darkness
-- Combos: Counter
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local typeEffectOne = tpz.effect.DEFENSE_DOWN
    local typeEffectTwo = tpz.effect.MAGIC_DEF_DOWN
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 1.0
    local resist = applyResistance(caster, target, spell, params)
    local duration = 30 * resist
    local returnEffect = typeEffectOne

    if (resist >= 0.5) then
        if (target:hasStatusEffect(typeEffectOne) and target:hasStatusEffect(typeEffectTwo)) then -- the def/mag def down does not overwrite the same debuff from any other source
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
        elseif (target:hasStatusEffect(typeEffectOne)) then
            target:addStatusEffect(typeEffectTwo, 8, 0, duration)
            returnEffect = typeEffectTwo
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        elseif (target:hasStatusEffect(typeEffectTwo)) then
            target:addStatusEffect(typeEffectOne, 10, 0, duration)
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            target:addStatusEffect(typeEffectOne, 10, 0, duration)
            target:addStatusEffect(typeEffectTwo, 8, 0, duration)
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        end
    end

    return returnEffect
end
