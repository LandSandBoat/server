-----------------------------------
-- Spell: Sleepga
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if
        target:hasImmunity(xi.immunity.SLEEP) or
        target:hasImmunity(xi.immunity.DARK_SLEEP)
    then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return
    end

    local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    local duration = xi.magic.calculateDuration(60, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local params = {}
    params.diff = dINT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = xi.effect.SLEEP_I
    local resist = xi.magic.applyResistanceEffect(caster, target, spell, params)

    if caster:isMob() then
        if caster:getPool() == 5310 then -- Amnaf (Flayer)
            caster:resetEnmity(target)
        end

        -- Todo: get rid of this whole block by handling it in the mob script
        -- this requires a multi target enmity without specifying a target (have to get hate list from mob)
        -- OR by altering onSpellPrecast to have a target param..
        -- OnMobMagicPrepare is not a realistic option.
        -- You'd have to script the use of every individual spell in Amnaf's list..
    end

    if resist >= 0.5 then
        local resduration = duration * resist

        resduration = xi.magic.calculateBuildDuration(target, resduration, params.effect, caster)

        if target:addStatusEffect(params.effect, 1, 0, resduration) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            -- only increment the resbuild if successful (not on a no effect)
            xi.magic.incrementBuildDuration(target, params.effect, caster)
            xi.magic.handleBurstMsg(caster, target, spell)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end

return spellObject
