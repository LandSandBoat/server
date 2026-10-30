-----------------------------------
-- Enemy Of The Empire II
-- A Shantotto Ascension M6
-----------------------------------
-- !addmission 11 5
-- Outcropping : !pos -134.658 -11.366 -185.2 212
-- BLACK_BOOK  : !addkeyitem 1203
-----------------------------------
require('scripts/missions/asa/helpers')
-----------------------------------
local gustavID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_II)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_SUBTERFUGE },
}

-- The black book starts the fight. The Outcropping refuses while the agents are up.
local function outcroppingTrigger(player)
    if xi.asa.helpers.isAgentFightActive() then
        return mission:messageText(gustavID.text.NOT_THE_TIME_FOR_THAT)
    end

    if player:hasKeyItem(xi.keyItem.BLACK_BOOK) then
        return mission:progressEvent(15)
    end
end

local function startFight(player, csid, option, npc)
    if
        option == 1 and
        player:hasKeyItem(xi.keyItem.BLACK_BOOK) and
        not xi.asa.helpers.isAgentFightActive()
    then
        xi.asa.helpers.startAgentFight(player, npc)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GUSTAV_TUNNEL] =
        {
            ['Outcropping'] =
            {
                onTrigger = function(player, npc)
                    if
                        mission:getVar(player, 'Won') == 1 and
                        not xi.asa.helpers.isAgentFightActive()
                    then
                        return mission:progressEvent(14)
                    end

                    return outcroppingTrigger(player)
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [15] = startFight,
            },
        },
    },

    -- The fight can be repeated for another Cactuar key once the mission is done.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission > mission.missionId
        end,

        [xi.zone.GUSTAV_TUNNEL] =
        {
            ['Outcropping'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.keyItem.BLACK_BOOK) and
                        not xi.asa.helpers.isAgentFightActive()
                    then
                        return mission:messageText(gustavID.text.RESTLESS_FOOTPRINTS):replaceDefault()
                    end

                    return outcroppingTrigger(player)
                end,
            },

            onEventFinish =
            {
                [15] = startFight,
            },
        },
    },
}

return mission
