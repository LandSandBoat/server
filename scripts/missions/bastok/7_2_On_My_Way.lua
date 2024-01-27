-----------------------------------
-- On My Way
-- Bastok M7-2
-----------------------------------
-- !addmission 1 19
-- Argus   : !pos 132.157 7.496 -2.187 236
-- Cleades : !pos -358 -10 -168 235
-- Malduc  : !pos 66.200 -14.999 4.426 237
-- Rashid  : !pos -8.444 -2 -123.575 234
-- Karst   : !pos 106 -21 0 237
-- Hilda   : !pos -163 -8 13 236
-- Gumbah  : !pos 52 0 -36 234
-----------------------------------
local bastokMarketsID = zones[xi.zone.BASTOK_MARKETS]
local bastokMinesID   = zones[xi.zone.BASTOK_MINES]
local metalworksID    = zones[xi.zone.METALWORKS]
local portBastokID    = zones[xi.zone.PORT_BASTOK]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.ON_MY_WAY)

mission.reward =
{
    gil = 60000,
    rank = 8,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 19 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.METALWORKS] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Cleades'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 3 and
                        mission:getVar(player, 'Option') == 1
                    then
                        return mission:progressEvent(1011)
                    else
                        mission:messageSpecial(bastokMarketsID.text.EXTENDED_MISSION_OFFSET + 7)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Gumbah'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 3 and
                        mission:getVar(player, 'Option') == 1
                    then
                        return mission:progressEvent(177)
                    end
                end,
            },

            ['Rashid'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 3 and
                        mission:getVar(player, 'Option') == 1
                    then
                        return mission:progressEvent(1011)
                    else
                        mission:messageSpecial(bastokMinesID.text.EXTENDED_MISSION_OFFSET + 7)
                    end
                end,
            },

            onEventFinish =
            {
                [177] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 0)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Franziska'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) > 0 then
                        return mission:progressEvent(770)
                    end
                end,
            },

            ['Karst'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(765)
                    elseif missionStatus == 3 then
                        local needsToDeliver = mission:getVar(player, 'Option')

                        return mission:progressEvent(766, needsToDeliver)
                    end
                end,
            },

            ['Malduc'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 3 and
                        mission:getVar(player, 'Option') == 1
                    then
                        return mission:progressEvent(1011)
                    else
                        mission:messageSpecial(metalworksID.text.EXTENDED_MISSION_OFFSET + 7)
                    end
                end,
            },

            onEventFinish =
            {
                [765] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [766] = function(player, csid, option, npc)
                    local blockingOption = mission:getVar(player, 'Option')

                    if mission:complete(player) then
                        -- Cornelia has two options for which CS is displayed, depending on quest
                        -- completion.  This variable is cleared after viewing.
                        mission:setVar(player, 'Stage', 1)

                        -- Gumbah dialogue is blocking before being able to progress.  If this wasn't
                        -- completed, make sure this var persists.
                        if blockingOption == 1 then
                            mission:setVar(player, 'Option', 1)
                        end
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 3 and
                        mission:getVar(player, 'Option') == 1
                    then
                        return mission:progressEvent(1011)
                    else
                        mission:messageSpecial(portBastokID.text.EXTENDED_MISSION_OFFSET + 7)
                    end
                end,
            },

            ['Hilda'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(255)
                    end
                end,
            },

            onEventFinish =
            {
                [255] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },

        [xi.zone.WAUGHROON_SHRINE] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        player:getLocalVar('battlefieldWin') == 67
                    then
                        npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_WEREI)
                        player:setMissionStatus(mission.areaId, 3)
                        mission:setVar(player, 'Option', 1)
                    end
                end,
            },
        },
    },

    -- Player has completed mission, but has not delivered letter to Gumbah
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) and
                mission:getVar(player, 'Option') == 1
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Cleades'] = mission:progressEvent(1011),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Gumbah'] = mission:progressEvent(177),
            ['Rashid'] = mission:progressEvent(1011),

            onEventFinish =
            {
                [177] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 0)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Malduc'] = mission:progressEvent(1011),
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:progressEvent(1011),
        },
    },

    -- Player has completed mission, optional Cornelia CS handling
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) and
                mission:getVar(player, 'Stage') == 1
        end,

        [xi.zone.METALWORKS] =
        {
            ['_6lg'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA) and
                        player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FALLEN_COMRADES) and
                        player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.RIVALS)
                    then
                        return mission:progressEvent(622)
                    else
                        return mission:progressEvent(621)
                    end
                end,
            },

            onEventFinish =
            {
                [621] = function(player, csid, option, npc)
                    mission:setVar(player, 'Stage', 0)
                end,

                [622] = function(player, csid, option, npc)
                    mission:setVar(player, 'Stage', 0)
                end,
            },
        },
    },
}

return mission
