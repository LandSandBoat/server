-----------------------------------
-- Spell: Aquaveil
-- Reduces chance of having a spell interrupted.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    target:delStatusEffect(tpz.effect.AQUAVEIL)

    -- duration is said to be based on enhancing skill with max 5 minutes, but I could find no
    -- tests that quantify the relationship so I'm using 5 minutes for now.
    local duration = calculateDuration(300, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local power = AQUAVEIL_COUNTER + caster:getMod(tpz.mod.AQUAVEIL_COUNT)
    if caster:getSkillLevel(tpz.skill.ENHANCING_MAGIC) >= 200 then -- cutoff point is estimated. https://www.bg-wiki.com/bg/Aquaveil
        power = power + 1
    end

    power = math.max(power, 1) -- this shouldn't happen but it's probably best to prevent someone from accidentally underflowing the counter...

    target:addStatusEffect(tpz.effect.AQUAVEIL, power, 0, duration)
    spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)

    return tpz.effect.AQUAVEIL
end

return spell_object
