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
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.ARCANA
    params.effect = xi.effect.FROST
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    local tick = 3
    local duration = 60
    local resistThreshold = 0.5
    local resist = applyResistance(caster, target, spell, params)

    -- Cannot apply if target has Burn
    if target:getStatusEffect(xi.effect.BURN) ~= nil then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)

    elseif resist >= resistThreshold then
        
        -- Remove Choke on target
        if target:getStatusEffect(xi.effect.CHOKE) ~= nil then
            target:delStatusEffect(xi.effect.CHOKE)
        end

<<<<<<< refs/remotes/upstream/base
        local sINT = caster:getStat(xi.mod.INT)
        local DOT = getElementalDebuffDOT(sINT)
        local effect = target:getStatusEffect(typeEffect)
        local noeffect = false
        if effect ~= nil then
            if effect:getPower() >= DOT then
                noeffect = true
            end
        end

        if noeffect then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
        else
            if effect ~= nil then
                target:delStatusEffect(typeEffect)
            end

            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
            local duration = math.floor(xi.settings.main.ELEMENTAL_DEBUFF_DURATION * resist)
            target:addStatusEffect(typeEffect, DOT, 3, duration)
=======
        local agiDown = utils.clamp(caster:getMainLvl() / 2, 0, 49)
        local dot = utils.clamp(math.floor((agiDown - 3) / 2), 0, 23)
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)

        if target:addStatusEffect(params.effect, dot, tick, duration * resist) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
>>>>>>> Abstraction for physical spells AE and pure enfeebling spells + individual enfeebling spells
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end

return spellObject
