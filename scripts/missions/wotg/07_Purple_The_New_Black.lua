-----------------------------------
-- Purple, The New Black
-- Wings of the Goddess Mission 7
-----------------------------------
-- !addmission 5 6
-- !setmissionstatus {Player} 1 5 0
-- _2d1 (Reinforced Gateway) : !pos -114.386 -3.599 -179.804 85
-----------------------------------
require("scripts/globals/keyitems")
require('scripts/globals/maws')
require('scripts/globals/missions')
require('scripts/globals/quests')
require('scripts/globals/settings')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.PURPLE_THE_NEW_BLACK)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.IN_THE_NAME_OF_THE_FATHER },
}

mission.sections =
{
    -- 0: Pre-BCNM CS
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.LA_VAULE_S] =
        {
            ['_2d1'] = mission:progressEvent(2, 85),

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.WOTG, 1)
                end,
            },
        },
    },

    -- 1: Enter the BCNM vs Galarhigg
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.LA_VAULE_S] =
        {
            onEventFinish =
            {
                -- Completed BCNM
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar("battlefieldWin") == 2721 then
                        return mission:event(6)
                    end
                end,

                [6] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setPos(-260, 0, -156, 192)
                    end
                end,
            },
        },
    },
}

return mission
