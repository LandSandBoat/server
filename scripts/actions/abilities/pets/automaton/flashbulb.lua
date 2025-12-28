-----------------------------------
-- Flashbulb
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 45)
    local highest        = automaton:getSkillLevel(xi.skill.AUTOMATON_MELEE)
    local highestSkillId = xi.skill.AUTOMATON_MELEE

    if automaton:getSkillLevel(xi.skill.AUTOMATON_RANGED) > highest then
        highest        = automaton:getSkillLevel(xi.skill.AUTOMATON_RANGED)
        highestSkillId = xi.skill.AUTOMATON_RANGED
    end

    if automaton:getSkillLevel(xi.skill.AUTOMATON_MAGIC) > highest then
        highestSkillId = xi.skill.AUTOMATON_MAGIC
    end

    local resist   = xi.combat.magicHitRate.calculateResistRate(automaton, target, 0, highestSkillId, 0, xi.element.LIGHT, 0, 0, 150)
    local duration = 12 * resist

    if resist > 0.0625 then
        if target:addStatusEffect(xi.effect.FLASH, 0, 0, duration) then -- power handled in hit rate calculations
            skill:setMsg(xi.msg.basic.SKILL_ENFEEB)
        else
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        end
    else
        skill:setMsg(xi.msg.basic.JA_MISS_2)
    end

    return xi.effect.FLASH
end

return abilityObject
