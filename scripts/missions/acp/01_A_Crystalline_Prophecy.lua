-----------------------------------
-- A Crystalline Prophecy
-- A Crystalline Prophecy M1
-----------------------------------
-- !addmission 9 0
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY)

mission.reward =
{
    nextMission = { xi.mission.log_id.ACP, xi.mission.id.acp.THE_ECHO_AWAKENS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                xi.settings.main.ENABLE_ACP == 1 and
                player:getMainLvl() >= 10
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 10094
                end,
            },

            onEventUpdate =
            {
                [10094] = function(player, csid, option, npc)
                    if option == 1 then
                        -- Parameters 1 and 2 determine if certain NPCs will appear in the CS.
                        -- Default values of 0 = They appear.
                        local noVerena = 0
                        local noSibyl  = 0

                        -- TODO: Fact check this.
                        if player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.WELCOME_TNORG) then
                            noVerena = 1
                        end

                        if player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING) then
                            noSibyl = 1
                        end

                        player:updateEvent(noVerena, noSibyl, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [10094] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
