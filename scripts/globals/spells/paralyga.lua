-----------------------------------------
-- Spell: Paralyze
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and MND.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    if (target:hasStatusEffect(tpz.effect.PARALYSIS)) then --effect already on, do nothing
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    else
        -- Calculate duration.
        local duration = 120

        local dMND = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)

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
        params.attribute = tpz.mod.MND
        params.skillType = 35
        params.bonus = 0
        params.effect = tpz.effect.PARALYSIS
        local resist = applyResistanceEffect(caster, target, spell, params)

        if (resist >= 0.5) then --there are no quarter or less hits, if target resists more than .5 spell is resisted completely
            if (target:addStatusEffect(tpz.effect.PARALYSIS, potency, 0, duration*resist)) then
                spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
            else
                -- no effect
                spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
            end
        else
            -- resist
            spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        end
    end

    return tpz.effect.PARALYSIS
end
