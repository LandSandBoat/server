-----------------------------------
-- Flashbulb
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 45)
    local highest = automaton:getSkillLevel(xi.skill.AUTOMATON_MELEE)
    local highestskill = 22
    if automaton:getSkillLevel(xi.skill.AUTOMATON_RANGED) > highest then
        highestskill = 23
        highest = automaton:getSkillLevel(xi.skill.AUTOMATON_RANGED)
    end

    if automaton:getSkillLevel(xi.skill.AUTOMATON_MAGIC) > highest then
        highestskill = 24
    end

    local resist = applyResistanceAbility(automaton, target, 7, highestskill, 150)
    local duration = 12 * resist

    if resist > 0.0625 then
        if target:addStatusEffect(xi.effect.FLASH, 200, 0, duration) then
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
