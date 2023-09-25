-----------------------------------
-- Spell: Kurayami: San
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Base Stats
    -- local dINT = (caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    --Duration Calculation
    local duration = 420
    local params = {}
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.NINJUTSU
    params.bonus = 0
    duration = duration * xi.magic.applyResistance(caster, target, spell, params)
    --Kurayami base power is 30 and is not affected by resistaces.
    local power = 30

    --Calculates resist chanve from Reist Blind
    if math.random(0, 100) >= target:getMod(xi.mod.BLINDRES) then
        if duration >= 210 then
            if target:addStatusEffect(xi.effect.BLINDNESS, power, 0, duration) then
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

    return xi.effect.BLINDNESS
end

return spellObject
