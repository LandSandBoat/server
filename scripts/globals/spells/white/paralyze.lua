-----------------------------------
-- Spell: Paralyze
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and MND.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:hasImmunity(xi.immunity.PARALYZE) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return
    end

    local dMND = caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)

    -- Calculate potency.
    local potency = utils.clamp(math.floor(dMND / 4) + 15, 5, 25)
    potency = xi.magic.calculatePotency(potency, spell:getSkillType(), caster, target)

    -- Calculate duration.
    local duration = xi.magic.calculateDuration(120, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local params   = {}

    params.diff = dMND
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 10
    params.effect = xi.effect.PARALYSIS
    params.tier = 1

    if not xi.magic.differentEffect(caster, target, spell, params) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return params.effect
    end

    local resist = xi.magic.applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then -- There are no quarter or less hits, if target resists more than .5 spell is resisted completely
        local resduration = duration * resist

        resduration = xi.magic.calculateBuildDuration(target, resduration, params.effect, caster)

        if target:addStatusEffect(params.effect, potency, 0, duration * resist, 0, params.tier) then
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

    return params.effect
end

return spellObject
