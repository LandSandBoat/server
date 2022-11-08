-----------------------------------
-- Spell: Frightful Roar
-- Weakens defense of enemies within range
-- Spell cost: 32 MP
-- Monster Type: Demon
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 3
-- Stat Bonus: AGI+2
-- Level: 50
-- Casting Time: 2 seconds
-- Recast Time: 20 seconds
-- Magic Bursts on: Detonation, Fragmentation, and Light
-- Combos: Auto Refresh
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.effect = xi.effect.DEFENSE_DOWN
    local resist = xi.magic.applyResistance(caster, target, spell, params)
    local duration = 60 * resist
    local power = 10

    if resist > 0.5 then -- Do it!
        if target:addStatusEffect(params.effect, power, 0, duration) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end

return spellObject
