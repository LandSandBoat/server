-----------------------------------
-- Spell: Refresh
-- Gradually restores target party member's MP
-- Composure increases duration 3x
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local duration = calculateDuration(150, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 41, target:getMainLvl())

    local mp = 3 + caster:getMod(xi.mod.ENHANCES_REFRESH)

    if target:hasStatusEffect(xi.effect.SUBLIMATION_ACTIVATED) or target:hasStatusEffect(xi.effect.SUBLIMATION_COMPLETE) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end

    target:delStatusEffect(xi.effect.REFRESH)
    target:addStatusEffect(xi.effect.REFRESH, mp, 0, duration)

    return xi.effect.REFRESH
end

return spell_object
