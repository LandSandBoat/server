-----------------------------------
-- Spell: Cold Wave
-- Deals ice damage that lowers Agility and gradually reduces HP of enemies within range
-- Spell cost: 37 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Ice)
-- Blue Magic Points: 1
-- Stat Bonus: INT-1
-- Level: 52
-- Casting Time: 4 seconds
-- Recast Time: 60 seconds
-- Magic Bursts on: Induration, Distortion, and Darkness
-- Combos: Auto Refresh
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local typeEffect = xi.effect.FROST
    -- local dINT = caster:getStat(xi.mod.INT)-target:getStat(xi.mod.INT)
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = nil
    local resist = applyResistance(caster, target, spell, params)

    if (target:getStatusEffect(xi.effect.BURN) ~= nil) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    elseif (resist > 0.5) then
        if (target:getStatusEffect(xi.effect.CHOKE) ~= nil) then
            target:delStatusEffect(xi.effect.CHOKE)
        end
        local sINT = caster:getStat(xi.mod.INT)
        local DOT = getElementalDebuffDOT(sINT)
        local effect = target:getStatusEffect(typeEffect)
        local noeffect = false
        if (effect ~= nil) then
            if (effect:getPower() >= DOT) then
                noeffect = true
            end
        end
        if (noeffect) then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
        else
            if (effect ~= nil) then
                target:delStatusEffect(typeEffect)
            end
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
            local duration = math.floor(xi.settings.ELEMENTAL_DEBUFF_DURATION * resist)
            target:addStatusEffect(typeEffect, DOT, 3, duration)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return typeEffect
end

return spell_object
