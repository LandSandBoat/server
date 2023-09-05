-----------------------------------
--    Spell: Virus
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local effect = xi.effect.PLAGUE
    local duration = 60
    -- local pINT = caster:getStat(xi.mod.INT)
    -- local mINT = target:getStat(xi.mod.INT)
    -- local dINT = (pINT - mINT)

    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = effect
    local resist = xi.magic.applyResistanceEffect(caster, target, spell, params)
    if resist >= 0.5 then -- effect taken
        local resduration = duration * resist

        resduration = xi.magic.calculateBuildDuration(target, resduration, params.effect, caster)

        if target:addStatusEffect(effect, 5, 3, duration) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            -- only increment the resbuild if successful (not on a no effect)
            xi.magic.incrementBuildDuration(target, params.effect, caster)
            xi.magic.handleBurstMsg(caster, target, spell)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else -- resist entirely.
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return effect
end

return spellObject
