-----------------------------------
-- The Path Untraveled
-- Rhapsodies of Vana'diel Mission 1-7
-----------------------------------
-- !addmission 13 12
-- Shattered Telepoint (Konschtat) : !pos 135 19 220 108
-- Shattered Telepoint (La Theine) : !pos 334 19 -60 102
-- Shattered Telepoint (Tahrongi)  : !pos 179 35 255 117
-- Gilgamesh                       : !pos 122.452 -9.009 -12.052 252
-----------------------------------
local norgID = zones[xi.zone.NORG]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_PATH_UNTRAVELED)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.AT_THE_HEAVENS_DOOR },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: This parameter may change after the completion of Apocolypse Nigh where Lion is freed
                    -- from the crystal.  This could impact this parameter, along with several successive missions.
                    -- All successive missions use the isLionGhost variable, and can be used to replace should this
                    -- be verified.
                    local isLionGhost = player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS) and 1 or 0

                    return mission:event(3, { [7] = isLionGhost }):setPriority(1005)
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = function(player, npc)
                    local isLionGhost = player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS) and 1 or 0

                    return mission:event(14, { [7] = isLionGhost }):setPriority(1005)
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = function(player, npc)
                    local isLionGhost = player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS) and 1 or 0

                    return mission:event(41, { [7] = isLionGhost }):setPriority(1005)
                end,
            },

            onEventFinish =
            {
                [41] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    -- Generic Messages
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['_700']      = mission:messageSpecial(norgID.text.DOOR_IS_LOCKED),
            ['Gilgamesh'] = mission:event(263), -- NOTE: This might not be accessible
        },
    },
}

return mission
