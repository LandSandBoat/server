-----------------------------------
-- Spell: Bind
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:hasImmunity(xi.immunity.BIND) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return
    end

    -- Pull base stats.
    local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    -- Duration not impacted by any non-random effects
    -- Duration from normal distribution with mean of 30 and std dev of 12 based on retail testing
    -- Use the Box-Muller transform to sample from the distribution
    local z0 = math.sqrt(-2 * math.log(math.random())) * math.cos(2 * math.pi * math.random())
    local randomDuration = utils.clamp(math.floor(30 + z0 * 12), 1, 60)

    -- Resist
    local params = {}
    params.diff = dINT
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = xi.effect.BIND
    local resist = xi.magic.applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then --Do it!
        local randomResDuration = randomDuration * resist

        -- still apply build res
        randomResDuration = xi.magic.calculateBuildDuration(target, randomResDuration, params.effect, caster)

        if target:addStatusEffect(params.effect, target:getSpeed(), 0 , randomResDuration) then
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
