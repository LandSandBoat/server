-----------------------------------
-- Spell: Cimicine Discharge
-- Reduces the attack speed of enemies within range
-- Spell cost: 32 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 3
-- Stat Bonus: DEX+1, AGI+2
-- Level: 78
-- Casting Time: 3 seconds
-- Recast Time: 20 seconds
-----------------------------------
-- Combos: Magic Burst Bonus
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local pINT = caster:getStat(xi.mod.INT)
    local mINT = target:getStat(xi.mod.INT)
    local dINT = pINT - mINT
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = nil
    local resist = applyResistance(caster, target, spell, params)

    if resist < 0.5 then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST) --resist message
    else
        if target:addStatusEffect(xi.effect.SLOW, 2000, 0, getBlueEffectDuration(caster, resist, xi.effect.SLOW)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    end

    return xi.effect.SLOW
end

return spell_object
