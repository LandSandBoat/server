-----------------------------------
-- Spell: Battery Charge
-- Gradually restores MP
-- Spell cost: 50 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Light)
-- Blue Magic Points: 3
-- Stat Bonus: MP+10, MND+1
-- Level: 79
-- Casting Time: 5 seconds
-- Recast Time: 75 seconds
-- Spell Duration: 100 ticks, 300 Seconds (5 Minutes)
-----------------------------------
-- Combos: None
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
    local typeEffect = xi.effect.REFRESH
    local power = 3
    local duration = 300

    if caster:hasStatusEffect(xi.effect.DIFFUSION) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if diffMerit > 0 then
            duration = duration + (duration / 100) * diffMerit
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    if target:hasStatusEffect(xi.effect.REFRESH) then
        target:delStatusEffect(xi.effect.REFRESH)
    end

    if not target:addStatusEffect(typeEffect, power, 3, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spellObject
