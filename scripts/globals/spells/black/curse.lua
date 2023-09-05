-----------------------------------
-- Spell: Curse
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Pull base stats.
    -- local dINT = (caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))

    local power = 50

    -- Duration, including resistance.  Unconfirmed.
    local duration = 300
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = xi.effect.CURSE_I
    duration = duration * xi.magic.applyResistanceEffect(caster, target, spell, params)

    if duration >= 150 then --Do it!
        duration = xi.magic.calculateBuildDuration(target, duration, params.effect, caster)

        if duration == 0 then
            spell:setMsg(xi.msg.basic.NONE)
        elseif target:addStatusEffect(xi.effect.CURSE_I, power, 0, duration) then
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

    return xi.effect.CURSE_I
end

return spellObject
