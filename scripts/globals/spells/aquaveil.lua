-----------------------------------
-- Spell: Aquaveil
-- Reduces chance of having a spell interrupted.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    target:delStatusEffect(xi.effect.AQUAVEIL)

    -- duration is said to be based on enhancing skill with max 5 minutes, but I could find no
    -- tests that quantify the relationship so I'm using 5 minutes for now.
    local duration = calculateDuration(300, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local power = xi.settings.AQUAVEIL_COUNTER + caster:getMod(xi.mod.AQUAVEIL_COUNT)
    if caster:getSkillLevel(xi.skill.ENHANCING_MAGIC) >= 200 then -- cutoff point is estimated. https://www.bg-wiki.com/bg/Aquaveil
        power = power + 1
    end

    power = math.max(power, 1) -- this shouldn't happen but it's probably best to prevent someone from accidentally underflowing the counter...

    target:addStatusEffect(xi.effect.AQUAVEIL, power, 0, duration)
    spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)

    return xi.effect.AQUAVEIL
end

return spell_object
