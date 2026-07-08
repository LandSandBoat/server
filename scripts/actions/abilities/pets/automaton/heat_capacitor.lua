-----------------------------------
-- Heat Capacitor
-- Increases TP based on the number of Fire Maneuvers and the attachments equipped.
-- https://wiki.ffo.jp/html/23696.html
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

local tpTable =
{
    [1] =
    {
        [xi.item.HEAT_CAPACITOR_ATTACHMENT]    = 400,
        [xi.item.HEAT_CAPACITOR_II_ATTACHMENT] = 600,
    },

    [2] =
    {
        [xi.item.HEAT_CAPACITOR_ATTACHMENT]    = 800,
        [xi.item.HEAT_CAPACITOR_II_ATTACHMENT] = 1200,
    },

    [3] =
    {
        [xi.item.HEAT_CAPACITOR_ATTACHMENT]    = 1200,
        [xi.item.HEAT_CAPACITOR_II_ATTACHMENT] = 1800,
    },
}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 90)

    local fireManeuvers = master:countEffect(xi.effect.FIRE_MANEUVER)

    local tpAmounts = tpTable[fireManeuvers]

    if not tpAmounts then
        return 0
    end

    for attachment, tpAmount in pairs(tpAmounts) do
        if automaton:hasAttachmentSet(attachment) then
            target:addTP(tpAmount)
        end
    end

    skill:setMsg(xi.msg.basic.TP_INCREASE)

    return target:getTP()
end

return abilityObject
