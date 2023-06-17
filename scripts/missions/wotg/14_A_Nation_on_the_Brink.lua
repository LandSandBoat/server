-----------------------------------
-- A Nation on the Brink
-- Wings of the Goddess Mission 14
-----------------------------------
-- !addmission 5 13
-- Underpass_Hatch : !pos 314.083 -1.160 -181.455 84
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local pastSauromugueID = require('scripts/zones/Sauromugue_Champaign_[S]/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.A_NATION_ON_THE_BRINK)

mission.reward =
{
    title       = xi.ki.BATTLE_OF_JEUNO_VETERAN,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.CROSSROADS_OF_TIME },
}

mission.sections =
{
    -- 0. Go to Batallia Downs (S) and check the Underpass Hatch in the top right corner of (J-9), in one of the towers, for a cutscene.
    -- The staircase is to the south of your arrival point if you teleported via Campaign Arbiter.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
        {
            ['Bulwark_Gate'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.UNDERPASS_HATCH_KEY) then
                        return mission:progressEvent(6, 98, 23, 1756)
                    else
                        return mission:messageSpecial(pastSauromugueID.text.SURRENDER_CEREMONY_HASTE):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.UNDERPASS_HATCH_KEY)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Underpass_Hatch'] =
            {
                onTrigger = function(player, npc)
                    -- Alternate Args Observed: 24, 23, 1756, -1397785, -821297285, 3, 4095
                    return mission:progressEvent(3, 24, 5, 0, 120, 0, 0, 0, 0)
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 2 then
                        return 4
                    elseif missionStatus == 3 then
                        return 20
                    elseif missionStatus == 4 then
                        return 21
                    elseif missionStatus == 5 then
                        return 22
                    end
                end,
            },

            onEventUpdate =
            {
                [4] = function(player, csid, option, npc)
                    if option == 1 then
                        -- Alternate Args Observed: 2, 0, 2963

                        player:updateEvent(player:getCampaignAllegiance(), 0, 1756, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [4] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                    player:setPos(399.999, 8.3, -269.999, 159, xi.zone.BATALLIA_DOWNS_S)
                end,

                [20] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                    player:setPos(399.999, 8.3, -269.999, 159, xi.zone.BATALLIA_DOWNS_S)
                end,

                [21] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5)
                    player:setPos(399.999, 8.3, -269.999, 159, xi.zone.BATALLIA_DOWNS_S)
                end,

                [22] = function(player, csid, option, npc)
                    mission:complete(player)

                    if not npcUtil.giveItem(player, xi.items.JEUNOAN_FLAG) then
                        mission:setVar(player, 'Unclaimed', 1)
                    end
                end,
            },
        },

        [xi.zone.EVERBLOOM_HOLLOW] =
        {
            onEventFinish =
            {
                [10000] = function(player, csid, option, npc)
                    -- TODO: The assumption for this mission script is to catch Event 10000 which is
                    -- sent once the battlefield has been cleared.  This needs to be verified upon
                    -- implementation of the instance.

                    player:setMissionStatus(mission.areaId, 2)
                    player:setPos(302.747, -1, -174.367, 31, xi.zone.BATALLIA_DOWNS_S)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['_qm5'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Unclaimed') == 1 then
                        return mission:progressEvent(5, 84)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        npcUtil.giveItem(player, xi.items.JEUNOAN_FLAG)
                    then
                        mission:setVar(player, 'Unclaimed', 0)
                    end
                end,
            },
        },
    },
}

return mission
