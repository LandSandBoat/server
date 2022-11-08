-----------------------------------
-- Affairs of State
-- Wings of the Goddess Mission 12
-----------------------------------
-- !addmission 5 11
-- Velda-Galda : !pos 138.631 -2.112 61.658 94
-- Radford     : !pos -205.303 -8.000 26.874 87
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.AFFAIRS_OF_STATE)

mission.reward =
{
    keyItem     = xi.ki.COUNT_BORELS_LETTER,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.BORNE_BY_THE_WIND },
}

mission.sections =
{
    -- Talk to these NPCs in either order:
    -- Velda-Galda (K-9) in Windurst Waters (S)
    -- Radford (H-6) in Bastok Markets (S)

    -- When you finish both cutscenes, you will be given Count Borel's letter and begin the next mission.

    -- 0. Speak to one of the nations first
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Velda-Galda'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: What are these args from caps?
                    return mission:progressEvent(178, 3, 2)
                end,
            },

            onEventFinish =
            {
                [178] = function(player, csid, option, npc)
                    mission:setVar(player, 'WindurstFirst', 1)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Radford'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: What are these args from caps?
                    -- Observed : 175, 1, 7, 0, 324953651, 58062326, 21829264, 4095, 196677
                    return mission:progressEvent(175, 2, 27, 0, 0, 0, 0, 1, 4095)
                end,
            },

            onEventFinish =
            {
                [175] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    -- 1. Speak to the other one of the nations, ends the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Velda-Galda'] =
            {
                onTrigger = function(player, npc)
                    local windurstFirst = mission:getVar(player, 'WindurstFirst') == 1
                    if windurstFirst then
                        -- Reminder
                        return mission:progressEvent(180, 94, 7)
                    else
                        -- Progress
                        -- NOTE: Args trigger the "handing over the letter" end part of the CS
                        -- Observed : 1, 0, 1, 324953715, 58062326, 21829264, 4095, 196678
                        return mission:progressEvent(179, player:getCampaignAllegiance(), 0, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [179] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Radford'] =
            {
                onTrigger = function(player, npc)
                    local bastokFirst = mission:getVar(player, 'WindurstFirst') == 0
                    if bastokFirst then
                        -- Reminder
                        return mission:progressEvent(177, 87, 55, 0, 0, 0, 0, 1, 4095)
                    else
                        -- Progress
                        -- NOTE: Args trigger the "handing over the letter" end part of the CS
                        return mission:progressEvent(176, 3, 75, 1, 0, 0, 0, 4095, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [176] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
