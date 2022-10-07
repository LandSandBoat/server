-----------------------------------
-- Spell: Absorb-MND
-- Steals an enemy's mind.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if
        target:hasStatusEffect(xi.effect.MND_DOWN) or
        caster:getStatusEffect(xi.effect.MND_BOOST)
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
            spell:setMsg(xi.msg.basic.MAGIC_ABSORB_MND)
            caster:addStatusEffect(xi.effect.MND_BOOST, power, tick, duration) -- Caster gains MND
            target:addStatusEffect(xi.effect.MND_DOWN, power, tick, duration)  -- Target loses MND
        end
    end

    return xi.effect.MND_DOWN
end

return spellObject
