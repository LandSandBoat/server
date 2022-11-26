-----------------------------------
-- Spell: Voracious Trunk
-- Steals an enemy's buff
-- Spell cost: 72 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: AGI +2
-- Level: 72
-- Casting Time: 10 seconds
-- Recast Time: 56 seconds
-- Combos: Auto Refresh
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.element = xi.magic.ele.WIND
    params.skillType = xi.skill.BLUE_MAGIC
    params.maccBonus = 0

    local resist = xi.magic.applyAbilityResistance(caster, target, params)
    local stealChance = math.random(1, 100)
    local stolen = 0

    if resist > 0.0625 and stealChance < 90 then
        stolen = caster:stealStatusEffect(target)
        if stolen ~= 0 then
            spell:setMsg(xi.msg.basic.MAGIC_STEAL)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return stolen
end

return spellObject
