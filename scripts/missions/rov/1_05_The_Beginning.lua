-----------------------------------
-- The Beginning
-- Rhapsodies of Vana'diel Mission 1-5
-----------------------------------
-- !addmission 13 6
-- Tonasav    : !pos -18.1 -8 28.4 249
-- Pacomart   : !pos -14.4 -1 -30.6 248
-- Comitiolus : !pos 100 -7 -13 252
-- Heillal    : !pos 30.8 -5.8 2.3 252
-- Oaken Door : !pos 97 -7 -12 252
-----------------------------------
local norgID = zones[xi.zone.NORG]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_BEGINNING)

mission.reward =
{
    keyItem     = xi.ki.REISENJIMA_SANCTORIUM_ORB,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.FLAMES_OF_PRAYER },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SELBINA] =
        {
            ['Pacomart'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(179)
                    end
                end,
            },

            onEventFinish =
            {
                [179] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setPos(0, 0, 0, 0, 252)
                    end
                end,
            },
        },

        [xi.zone.MHAURA] =
        {
            ['Tonasav'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return mission:progressEvent(371)
                    end
                end,
            },

            onEventFinish =
            {
                [371] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setPos(0, 0, 0, 0, 252)
                    end
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['_700']       = mission:event(276):setPriority(1005), -- RoV objectives are highest priority, set higher than progressEvent (1000)
            ['Comitiolus'] = mission:messageSpecial(norgID.text.DIDYA_GET_BUMPED):setPriority(1005),
            ['Heillal']    = mission:progressEvent(281),

            onEventFinish =
            {
                [276] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
