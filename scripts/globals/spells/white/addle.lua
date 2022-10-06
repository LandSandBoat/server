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
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local dMND = caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)

    -- Spell casting increase
    local power = calculatePotency(30, spell:getSkillType(), caster, target)

    -- Magic Accuracy reduction (not affected by enfeebling skill)
    local subPower = 20 + utils.clamp(math.floor(dMND / 5), 0, 20)

    --Duration, including resistance.
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local params = {}
    params.diff = dMND
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = xi.effect.ADDLE
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then -- Do it!
        if target:addStatusEffect(params.effect, power, 0, duration * resist, 0, subPower) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end

return spellObject
