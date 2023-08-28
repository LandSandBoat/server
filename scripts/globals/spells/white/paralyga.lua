-----------------------------------
-- Spell: Paralyze
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and MND.
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:hasStatusEffect(xi.effect.PARALYSIS) then --effect already on, do nothing
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    else
        -- Calculate duration.
        local duration = 120

        local dMND = caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)

        -- Calculate potency.
        local potency = math.floor(dMND / 4) + 15
        if potency > 25 then
            potency = 25
        end

        if potency < 5 then
            potency = 5
        end

        local params = {}
        params.diff = nil
        params.attribute = xi.mod.MND
        params.skillType = xi.skill.ENFEEBLING_MAGIC
        params.bonus = 0
        params.effect = xi.effect.PARALYSIS
        local resist = xi.magic.applyResistanceEffect(caster, target, spell, params)

        if resist >= 0.5 then --there are no quarter or less hits, if target resists more than .5 spell is resisted completely
            local resduration = duration * resist

            resduration = xi.magic.calculateBuildDuration(target, resduration, params.effect, caster)

            if target:addStatusEffect(xi.effect.PARALYSIS, potency, 0, resduration) then
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
                -- only increment the resbuild if successful (not on a no effect)
                xi.magic.incrementBuildDuration(target, params.effect, caster)
                xi.magic.handleBurstMsg(caster, target, spell)
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

return spellObject
