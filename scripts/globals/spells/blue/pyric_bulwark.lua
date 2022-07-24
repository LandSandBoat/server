-----------------------------------
-- Spell: Pyric Bulwark
-- Resists physical damage
-- Spell cost: 50 MP
-- Monster Type: Lizards
-- Spell Type: Magical (Ice)
-- Level: 98
-- Casting Time: 1.5 seconds
-- Recast Time: 30 seconds
-- Duration: 600 seconds or Damage prevented
-----------------------------------
-- Combos: None
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local typeEffect = xi.effect.PHYSICAL_SHIELD
    local power = 2
    local duration = 5 -- need to implement a physical shield that acts like a shadow

    if (target:addStatusEffect(typeEffect, power, 3, duration) == false) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spell_object
