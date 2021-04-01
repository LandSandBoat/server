-----------------------------------
-- Spell: Paralyze
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and MND.
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

    if (target:hasStatusEffect(xi.effect.PARALYSIS)) then --effect already on, do nothing
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    else
        -- Calculate duration.
        local duration = 120

        local dMND = caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)

        -- Calculate potency.
        local potency = math.floor(dMND / 4) + 15
        if (potency > 25) then
            potency = 25
        end

        if (potency < 5) then
            potency = 5
        end
        --printf("Duration : %u", duration)
        --printf("Potency : %u", potency)
        local params = {}
        params.diff = nil
        params.attribute = xi.mod.MND
        params.skillType = 35
        params.bonus = 0
        params.effect = xi.effect.PARALYSIS
        local resist = applyResistanceEffect(caster, target, spell, params)

        if (resist >= 0.5) then --there are no quarter or less hits, if target resists more than .5 spell is resisted completely
            if (target:addStatusEffect(xi.effect.PARALYSIS, potency, 0, duration*resist)) then
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            else
                -- no effect
                spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
            end
        else
            -- resist
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        end
    end

    return xi.effect.PARALYSIS
end

return spell_object
