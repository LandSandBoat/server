-----------------------------------
-- Moghouse Exposition
-----------------------------------
require('scripts/globals/moghouse')
require('scripts/globals/zone')
require('scripts/globals/interaction/hidden_quest')
-----------------------------------

local quest = HiddenQuest:new("moghouseExpo")

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
        end,
    },
}

for i, zoneId in ipairs(xi.moghouse.moghouseZones) do
    quest.sections[1][zoneId] = moogleZoneInEvent
end

return quest
