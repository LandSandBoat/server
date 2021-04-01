-----------------------------------
--    Spell: Virus
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local effect = xi.effect.PLAGUE

    local duration = 60

    local pINT = caster:getStat(xi.mod.INT)
    local mINT = target:getStat(xi.mod.INT)

    local dINT = (pINT - mINT)

    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = effect
    local resist = applyResistanceEffect(caster, target, spell, params)
    if (resist >= 0.5) then -- effect taken
        duration = duration * resist

        if (target:addStatusEffect(effect, 5, 3, duration)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end

    else -- resist entirely.
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return effect
end

return spell_object
