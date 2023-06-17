-----------------------------------
-- The Temple of Uggalepih
-- Zilart M4
-----------------------------------
-- !addmission 3 8
-- Gilgamesh            : !pos 122.452 -9.009 -12.052 252
-- Jakoh Wahcondalo     : !pos 101 -16 -115 250
-- Mahogany Door (BCNM) : !pos 299 0.1 349 163
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH)

mission.reward =
{
    keyItem     = xi.ki.DARK_FRAGMENT,
    title       = xi.title.BEARER_OF_THE_WISEWOMANS_HOPE,
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Gilgamesh']  = mission:event(8),
        },

        [xi.zone.KAZHAM] =
        {
            -- NOTE: This CS is blocked by Evisceration quest if it is active, and will not
            -- be displayed.
            ['Jakoh_Wahcondalo'] = mission:event(115),
        },

        [xi.zone.SACRIFICIAL_CHAMBER] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 1 then
                        return 7
                    elseif missionStatus == 2 then
                        return 8
                    end
                end,
            },

            onEventUpdate =
            {
                [7] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(0, 23, 1756, 0, 163, 0, 0, 0)
                    end
                end,

                [8] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(0, 23, 1756, 0, 163, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == 128 then
                        player:setMissionStatus(mission.areaId, 1)
                        player:setPos(-329.762, -0.015, -300.172, 127, xi.zone.SACRIFICIAL_CHAMBER)
                    end
                end,

                [7] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    player:setPos(-329.762, -0.015, -300.172, 127, xi.zone.SACRIFICIAL_CHAMBER)
                end,

                [8] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.SACRIFICIAL_CHAMBER_KEY)

                        -- NOTE: RoV mission transition occurs if the player is on Cursed Temple following the completion
                        -- of this event.
                        if player:getCurrentMission(xi.mission.log_id.ROV) == xi.mission.id.rov.THE_CURSED_TEMPLE then
                            player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.THE_CURSED_TEMPLE)
                            player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.WISDOM_OF_OUR_FOREFATHERS)
                        end
                    end
                end,
            },
        },
    },

    -- Players not on mission should still receive BCNM title
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission ~= mission.missionId and
                player:getLocalVar('battlefieldWin') == 128
        end,

        [xi.zone.SACRIFICIAL_CHAMBER] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    player:addTitle(xi.title.BEARER_OF_THE_WISEWOMANS_HOPE)
                end,
            },
        },
    },
}

return mission
