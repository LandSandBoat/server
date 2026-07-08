-----------------------------------
-- Shock Absorber
-- Grants "Stoneskin" effect to the automaton.
-- Duration of effect is 3 minutes.
-- Stoneskin value is 200 + a bonus based on number of earth maneuvers, skill level, and attachments equipped.
-- https://wiki.ffo.jp/html/12927.html
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

local stoneskinTable =
{
    [1] =
    {
        [xi.item.SHOCK_ABSORBER_ATTACHMENT]     = 0.20,
        [xi.item.SHOCK_ABSORBER_II_ATTACHMENT]  = 0.40,
        [xi.item.SHOCK_ABSORBER_III_ATTACHMENT] = 0.75,
    },

    [2] =
    {
        [xi.item.SHOCK_ABSORBER_ATTACHMENT]     = 0.40,
        [xi.item.SHOCK_ABSORBER_II_ATTACHMENT]  = 0.75,
        [xi.item.SHOCK_ABSORBER_III_ATTACHMENT] = 1.00,
    },

    [3] =
    {
        [xi.item.SHOCK_ABSORBER_ATTACHMENT]     = 0.60,
        [xi.item.SHOCK_ABSORBER_II_ATTACHMENT]  = 1.00,
        [xi.item.SHOCK_ABSORBER_III_ATTACHMENT] = 1.40,
    },
}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 180)

    local earthManeuvers  = master:countEffect(xi.effect.EARTH_MANEUVER)
    local skillLevel      = math.max(automaton:getSkillLevel(xi.skill.AUTOMATON_MELEE), automaton:getSkillLevel(xi.skill.AUTOMATON_RANGED), automaton:getSkillLevel(xi.skill.AUTOMATON_MAGIC))
    local duration        = 180
    local amount          = 200

    -- Bonus Stoneskin value is added for each Shock Absorber equipped, however, the base amount of 200 does not change.
    for attachment, multiplier in pairs(stoneskinTable[earthManeuvers]) do
        if automaton:hasAttachmentSet(attachment) then
            amount = amount + math.floor(skillLevel * multiplier)
        end
    end

    if target:addStatusEffect(xi.effect.STONESKIN, { power = amount, duration = duration, origin = automaton, tier = 4 }) then
        skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return xi.effect.STONESKIN
end

return abilityObject
