-----------------------------------
-- Reactive Shield
-- Grants Blaze Spikes to the automaton for 60 seconds.
-- https://wiki.ffo.jp/html/10431.html
-- Power formula derived from brief testing. TODO: Gather more data and refine formula.
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 60)

    local skillLevel   = math.max(automaton:getSkillLevel(xi.skill.AUTOMATON_MELEE), automaton:getSkillLevel(xi.skill.AUTOMATON_RANGED), automaton:getSkillLevel(xi.skill.AUTOMATON_MAGIC))
    local intelligence = automaton:getStat(xi.mod.INT)

    local power = math.floor(skillLevel / 16) + math.floor(intelligence / 8)

    if target:addStatusEffect(xi.effect.BLAZE_SPIKES, { power = power, duration = 60, origin = automaton }) then
        skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return xi.effect.BLAZE_SPIKES
end

return abilityObject
