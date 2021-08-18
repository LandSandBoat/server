-----------------------------------
-- Budding Prospects
-- Seekers of Adoulin M2-1
-----------------------------------
-- !addmission 12 11
-- Masad : !pos -28.182 -0.650 -91.991 256
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.BUDDING_PROSPECTS)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_LIGHT_SHINING_IN_YOUR_EYES },
}

mission.sections =
{
    -- 0:
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.soa.FLAVORS_OF_OUR_LIVES) == QUEST_COMPLETED
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            -- TODO: One day wait
            ['Masad'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(8)
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
