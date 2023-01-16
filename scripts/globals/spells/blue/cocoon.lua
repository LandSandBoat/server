-----------------------------------
-- Spell: Cocoon
-- Enhances defense
-- Spell cost: 10 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 1
-- Stat Bonus: VIT+3
-- Level: 8
-- Casting Time: 1.75 seconds
-- Recast Time: 60 seconds
-- Duration: 90 seconds
-----------------------------------
-- Combos: None
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local typeEffect = xi.effect.DEFENSE_BOOST
    local power = 50 -- 50%
    local duration = xi.spells.blue.calculateDurationWithDiffusion(caster, 90)

    if not target:addStatusEffect(typeEffect, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spellObject
