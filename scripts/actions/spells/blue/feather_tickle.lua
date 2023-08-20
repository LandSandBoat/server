-----------------------------------
-- Spell: Feather Tickle
-- Reduces an enemy's TP
-- Spell cost: 48 MP
-- Monster Type: Birds
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 3
-- Stat Bonus: AGI+1
-- Level: 64
-- Casting Time: 4 seconds
-- Recast Time: 26 seconds
-- Magic Bursts on: Detonation, Fragmentation, and Light
-- Combos: Clear Mind
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.BIRD
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    local power = 1500
    local resistThreshold = 0.5

    local resist = applyResistance(caster, target, spell, params)
    if resist >= resistThreshold then
        if target:getTP() == 0 then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        else
            target:delTP(power * resist)
            spell:setMsg(xi.msg.basic.MAGIC_TP_REDUCE)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return 0
end

return spellObject
