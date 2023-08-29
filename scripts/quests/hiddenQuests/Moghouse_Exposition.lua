-----------------------------------
-- Moghouse Exposition
-----------------------------------

local quest = HiddenQuest:new('mogExpo')

quest.reward = {}

quest.sections    = {}
quest.sections[1] = {}

quest.sections[1].check = function(player, currentMission, missionStatus, vars)
    return xi.moghouse.isInMogHouseInHomeNation(player) and
        quest:getVar(player, 'notSeen') == 1
end

local moogleZoneInEvent =
{
    onZoneIn =
    {
        function(player, prevZone)
            return 30000
        end,
    },

    onEventFinish =
    {
        [30000] = function(player, csid, option, npc)
            quest:complete(player)
            quest:setVar(player, 'oNation', 1)
        end,
    },
}

quest.sections[2] = {}

quest.sections[2].check = function(player, currentMission, missionStatus, vars)
    return not xi.moghouse.isInMogHouseInHomeNation(player) and
        player:isInMogHouse() and
        quest:getVar(player, 'oNation') == 1
end

local otherNationTriggerEvent =
{
    ['Moogle'] = quest:progressEvent(30001),

    onEventFinish =
    {
        [30001] = function(player, csid, option, npc)
            quest:complete(player)
        end,
    },
}

for _, zoneId in ipairs(xi.moghouse.moghouseZones) do
    quest.sections[1][zoneId] = moogleZoneInEvent
    quest.sections[2][zoneId] = otherNationTriggerEvent
end

return quest
