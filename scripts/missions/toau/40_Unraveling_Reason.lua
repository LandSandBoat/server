-----------------------------------
-- Unraveling Reason
-- Aht Uhrgan Mission 40
-----------------------------------
-- !addmission 4 39
-- Pherimociel : !pos -31.627 1.002 67.956 243
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.UNRAVELING_REASON)

mission.reward =
{
    title       = xi.title.ENDYMION_PARATROOPER,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.LIGHT_OF_JUDGMENT },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Pherimociel'] =
            {
                onTrigger = function(player, npc)
                    local questTimer = mission:getVar(player, 'Timer')

                    if questTimer == 0 then
                        return mission:progressEvent(10099)
                    elseif
                        VanadielUniqueDay() >= questTimer and
                        not mission:getMustZone(player)
                    then
                        return mission:progressEvent(10098)
                    end
                end,
            },

            onEventFinish =
            {
                [10098] = function(player, csid, option, npc)
                    if option == 1 then
                        -- Title can be obtained immediately following this event.  Since these are stringed
                        -- together, set it at the end for clarity in mission rewards.

                        -- NOTE: Setting absolute pos here in the past has caused issues, so we chuck to Wajaom
                        -- and then start moving things around.  This is probably something good to fix in the
                        -- future for all events.
                        player:setPos(0, 0, 0, 0, 51)
                    else
                        mission:setMustZone(player)
                    end
                end,

                [10099] = function(player, csid, option, npc)
                    mission:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                    mission:setMustZone(player)
                end,
            },
        },

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    -- Each of these 3 cutscenes that follow Ru'Lude 10098 are onZone events.  It is possible
                    -- to not require this, but is retail accurate.

                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return 11
                    elseif missionStatus == 1 then
                        return 21
                    else
                        return 22
                    end
                end,
            },

            onEventFinish =
            {
                [11] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    player:setPos(-200.036, -10, 79.948, 254, 51)
                end,

                [21] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    player:setPos(-200.036, -10, 79.948, 254, 51)
                end,

                [22] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
