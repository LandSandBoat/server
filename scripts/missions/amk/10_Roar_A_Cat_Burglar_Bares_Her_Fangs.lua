-----------------------------------
-- Roar! A Cat Burglar Bares Her Fangs
-- A Moogle Kupo d'Etat M10
-- !addmission 10 9
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.ROAR_A_CAT_BURGLAR_BARES_HER_FANGS)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.RELIEF_A_TRIUMPHANT_RETURN },
}

mission.sections =
{
    -- 0: Shady Sconce
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.SEA_SERPENT_GROTTO] =
        {
            ['Shady_Sconce'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(19, 176)
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setMissionStatus(xi.mission.log_id.AMK, 1)
                    end
                end,
            },
        },
    },

    -- 1: Waterfall Basin
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.SEA_SERPENT_GROTTO] =
        {
            ['Shady_Sconce'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(22)
                end,
            },

            ['Waterfall_Basin'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(20)
                end,
            },

            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.AMK, 2)
                end,
            },
        },
    },

    -- 2: Inconspicuous Door
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(10184)
                end,
            },

            onEventFinish =
            {
                [10184] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
