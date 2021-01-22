-----------------------------------
-- Spell: Addle
-- Increases the casting time of the target
-- Exact formula is unknown.
-----------------------------------
-- Raw Value is said to be 30%
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local dMND = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)

    -- Spell casting increase
    local power = calculatePotency(30, spell:getSkillType(), caster, target)

    -- Magic Accuracy reduction (not affected by enfeebling skill)
    local subPower = 20 + utils.clamp(math.floor(dMND / 5), 0, 20)

    --Duration, including resistance.
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.ADDLE
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then -- Do it!
        if target:addStatusEffect(params.effect, power, 0, duration * resist, 0, subPower) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end

return spell_object
