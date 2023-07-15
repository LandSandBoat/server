-----------------------------------
-- Spell: Dokumori: Ni
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local effect = xi.effect.POISON
    -- Base Stats
    -- local dINT = (caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    --Duration Calculation
    local duration = 120
    local params = {}
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.NINJUTSU
    params.bonus = 0
    duration = duration * xi.magic.applyResistance(caster, target, spell, params)
    local power = 10

    --Calculates resist chanve from Reist Blind
    if target:hasStatusEffect(effect) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
        return effect
    end

    if math.random(0, 100) >= target:getMod(xi.mod.POISONRES) then
        if duration >= 60 then
            if target:addStatusEffect(effect, power, 3, duration) then
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
                xi.magic.handleBurstMsg(caster, target, spell)
            else
                spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
            end
        else
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST_2)
    end

    return effect
end

return spellObject
