-----------------------------------
-- Spell: Gravity II
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:hasImmunity(xi.immunity.GRAVITY) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return
    end

    -- Pull base stats.
    local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    local power = xi.magic.calculatePotency(32, spell:getSkillType(), caster, target)

    -- Duration, including resistance.  Unconfirmed.
    local duration = xi.magic.calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local params = {}
    params.diff = dINT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = xi.effect.WEIGHT
    params.tier = 2

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
        spell:setMsg(xi.msg.basic.MAGIC_RESIST_2)
    end

    return params.effect
end

return spellObject
