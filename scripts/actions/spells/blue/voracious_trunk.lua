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
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local stolen = 0
    local params =
    {
        magicalElement = spell:getElement(),
        actorStat      = xi.mod.INT,
        skillType      = xi.skill.BLUE_MAGIC,
        spellGroup     = spell:getSpellGroup(),
    }

    local resist = xi.combat.magicHitRate.calculateResistRate(caster, target, params)

    if resist >= 0.5 then
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
