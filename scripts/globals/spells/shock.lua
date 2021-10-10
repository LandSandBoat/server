-----------------------------------
-- Spell: Shock
-- Deals lightning damage that lowers an enemy's mind and gradually reduces its HP.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)

    if (target:getStatusEffect(xi.effect.RASP) ~= nil) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    else
        -- local dINT = caster:getStat(xi.mod.INT)-target:getStat(xi.mod.INT)
        local params = {}
        params.diff = nil
        params.attribute = xi.mod.INT
        params.skillType = xi.skill.ELEMENTAL_MAGIC
        params.bonus = 0
        params.effect = nil
        local resist = applyResistance(caster, target, spell, params)
        if (resist <= 0.125) then
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        else
            if (target:getStatusEffect(xi.effect.DROWN) ~= nil) then
                target:delStatusEffect(xi.effect.DROWN)
            end
            local sINT = caster:getStat(xi.mod.INT)
            local DOT = getElementalDebuffDOT(sINT)
            local effect = target:getStatusEffect(xi.effect.SHOCK)
            local noeffect = false
            if (effect ~= nil) then
                if (effect:getPower() >= DOT) then
                    noeffect = true
                end
            end
            if (noeffect) then
                spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
            else
                if (effect ~= nil) then
                    target:delStatusEffect(xi.effect.SHOCK)
                end
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
                local duration = math.floor(xi.settings.ELEMENTAL_DEBUFF_DURATION * resist)
                duration = duration + caster:getMerit(xi.merit.ELEMENTAL_DEBUFF_DURATION)

                local mbonus = caster:getMerit(xi.merit.ELEMENTAL_DEBUFF_EFFECT)
                DOT = DOT + mbonus/2 -- Damage

                target:addStatusEffect(xi.effect.SHOCK, DOT, 3, duration)
            end
        end
    end

    return xi.effect.SHOCK

end

return spell_object
