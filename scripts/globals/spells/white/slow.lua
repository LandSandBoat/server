-----------------------------------
-- Spell: Slow
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:hasImmunity(xi.immunity.SLOW) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return
    end

    if target:hasStatusEffect(xi.effect.HASTE) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return xi.effect.SLOW
    end

    local dMND = caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)

    --Power
    -- Lowest ~7.3%
    -- Highest ~29.2%
    local power = utils.clamp(math.floor(dMND * 73 / 5) + 1825, 730, 2920)
    power = xi.magic.calculatePotency(power, spell:getSkillType(), caster, target)

    --Duration
    local duration = xi.magic.calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local params = {}
    params.diff = dMND
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 10
    params.effect = xi.effect.SLOW
    params.tier = 1

    if not xi.magic.differentEffect(caster, target, spell, params) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return params.effect
    end

    local resist = xi.magic.applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then --Do it!
        local resduration = duration * resist

        resduration = xi.magic.calculateBuildDuration(target, resduration, params.effect, caster)

        if target:addStatusEffect(params.effect, power, 0, resduration, 0, params.tier) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            -- only increment the resbuild if successful (not on a no effect)
            xi.magic.incrementBuildDuration(target, params.effect, caster)
            xi.magic.handleBurstMsg(caster, target, spell)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end

return spellObject
