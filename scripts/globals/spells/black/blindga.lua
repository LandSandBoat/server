-----------------------------------
-- Spell: Blind
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:hasImmunity(xi.immunity.BLIND) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return
    end

    -- Pull base stats.
    local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.MND) --blind uses caster INT vs target MND

    -- Base power.  May need more research.
    local power = math.floor(dINT * 9 / 40) + 23

    if power < 5 then
        power = 5
    end

    if power > 50 then
        power = 50
    end

    -- Duration, including resistance.  Unconfirmed.
    local duration = 180
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = xi.effect.BLINDNESS
    local resist = xi.magic.applyResistanceEffect(caster, target, spell, params)

    if duration >= 60 then --Do it!
        local resduration = duration * resist

        resduration = xi.magic.calculateBuildDuration(target, resduration, params.effect, caster)

        if resduration == 0 then
            spell:setMsg(xi.msg.basic.NONE)
        elseif target:addStatusEffect(params.effect, power, 0, resduration) then
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

    return xi.effect.BLINDNESS
end

return spellObject
