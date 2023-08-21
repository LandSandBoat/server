-----------------------------------
-- Teahouse Tumult
-- Aht Uhrgan Mission 20
-----------------------------------
-- !addmission 4 19
-- blank_toau20 : !pos -298 36 -38 68
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.TEAHOUSE_TUMULT)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.FINDERS_KEEPERS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AYDEEWA_SUBTERRANE] =
        {
            ['blank_toau20'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(11)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return 10
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [11] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
