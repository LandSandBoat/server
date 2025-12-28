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

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(3148, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Pherimociel'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        if
                            not mission:getMustZone(player) and
                            VanadielUniqueDay() >= mission:getVar(player, 'Timer')
                        then
                            return mission:progressEvent(10098) -- Ship is ready.

                        -- Optional cutscene. Plays one time per zone until time is up. FORCES zoning, which blocks progress until you do.
                        elseif player:getLocalVar('Mission[4][39]seenCS') == 0 then
                            return mission:event(10099) -- Ship isn't ready.
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [10098] = function(player, csid, option, npc)
                    if option == 1 then -- Confirmed that if you decline the offer, you don't need to zone to get the CS again.
                        player:setMissionStatus(mission.areaId, 1)
                        player:setPos(-200.036, -10, 79.948, 254, xi.zone.WAJAOM_WOODLANDS)
                    end
                end,

                [10099] = function(player, csid, option, npc)
                    player:setLocalVar('Mission[4][39]seenCS', 1)
                    mission:setMustZone(player)
                end,
            },
        },

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            onZoneIn = function(player, prevZone)
                -- Each of these 3 cutscenes that follow Ru'Lude 10098 are onZone events.
                -- It is possible to not require this, but is retail accurate.

                local missionStatus = player:getMissionStatus(mission.areaId)

                if missionStatus == 1 then
                    return 11
                elseif missionStatus == 2 then
                    return 21
                elseif missionStatus == 3 then
                    return 22
                end
            end,

            onEventUpdate =
            {
                [11] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(0, 4, 0, 0, 0, 0, 0, 3, 0)
                    end
                end,

                [21] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(0, 4, 0, 0, 0, 0, 0, 3, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [11] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    player:setPos(-200.036, -10, 79.948, 254, xi.zone.WAJAOM_WOODLANDS)
                end,

                [21] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                    player:setPos(-200.036, -10, 79.948, 254, xi.zone.WAJAOM_WOODLANDS)
                end,

                [22] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
