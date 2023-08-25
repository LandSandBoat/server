-----------------------------------
-- Spell: Flash
-- Temporarily blinds an enemy, greatly lowering its accuracy.
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Pull base stats.
    -- local dINT = (caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND))
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.DIVINE_MAGIC
    params.bonus =  200
    params.effect = nil
    local resist = xi.magic.applyResistance(caster, target, spell, params)
    local duration = 12 * resist
    if resist > 0.0625 then
        if target:addStatusEffect(xi.effect.FLASH, 300, 4, duration) then -- Flash should be 300 and quickly wear off, tick value results in 1 ACC penalty at max duration.
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            xi.magic.handleBurstMsg(caster, target, spell)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return xi.effect.FLASH
end

return spellObject
