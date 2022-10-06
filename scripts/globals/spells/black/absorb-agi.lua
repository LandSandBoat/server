-----------------------------------
-- Spell: Absorb-AGI
-- Steals an enemy's agility.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    if
        target:hasStatusEffect(xi.effect.AGI_DOWN) or
        caster:hasStatusEffect(xi.effect.AGI_BOOST)
    then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    else
        -- local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
        local params = {}
            params.diff      = nil
            params.attribute = xi.mod.INT
            params.skillType = xi.skill.DARK_MAGIC
            params.bonus     = 0
            params.effect    = nil
        local base     = utils.clamp(caster:getMainLvl() / 4.5, 9, 22)
        local resist   = applyResistance(caster, target, spell, params)
        local power    = base * resist * ((100 + caster:getMod(xi.mod.AUGMENTS_ABSORB)) / 100)
        local tick     = xi.settings.main.ABSORB_SPELL_TICK
        local duration = calculateDuration(90, spell:getSkillType(), spell:getSpellGroup(), caster, target)

        if resist <= 0.125 then
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        else
            spell:setMsg(xi.msg.basic.MAGIC_ABSORB_AGI)
            caster:addStatusEffect(xi.effect.AGI_BOOST, power, tick, duration) -- Caster gains AGI
            target:addStatusEffect(xi.effect.AGI_DOWN, power, tick, duration)  -- Target loses AGI
        end
    end

    return xi.effect.AGI_DOWN
end

return spell_object
