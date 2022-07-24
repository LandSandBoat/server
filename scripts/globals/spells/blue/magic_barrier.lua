-----------------------------------
-- Spell: Magic Barrier
-- Grants a Magic Shield effect
-- Spell cost: 29 MP
-- Monster Type: Demons
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 3
-- Stat Bonus: MP +7 INT +2
-- Level: 82
-- Casting Time:5 seconds
-- Recast Time: 60 seconds
-- Duration: 5 minutes
-----------------------------------
-- Combos: Max MP Boost
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local typeEffect = xi.effect.MAGIC_SHIELD
    local blueskill = caster:getSkillLevel(xi.skill.BLUE_MAGIC)
    local power = blueskill
    local duration = 300

    if (caster:hasStatusEffect(xi.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    -- Power 4 = magic stoneskin effect on magic shield
    if not target:hasStatusEffect(xi.effect.STONESKIN) and not target:addStatusEffect(typeEffect, 4, power, duration, 0, 0, 2) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spell_object
