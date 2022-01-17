-----------------------------------
-- Spell: Shell III
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
    local power = 2188 -- Shell III (56/256)
    local tier = 3
    local spelllevel = 57
    local bonus = 0
    local duration = calculateDuration(1800, spell:getSkillType(), spell:getSpellGroup(), caster, target, false)
    duration = calculateDurationForLvl(duration, spelllevel, target:getMainLvl())
    if target:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
        bonus = 39 -- (1/256 bonus buff per tier of spell)
    end
    power = power + (bonus * tier)

    local typeEffect = xi.effect.SHELL
    if target:addStatusEffect(typeEffect, power, 0, duration, 0, 0, tier) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    end

    return typeEffect
end

return spell_object
