-----------------------------------
-- The Horutoto Ruins Experiment
-- Windurst M1-1
-----------------------------------
-- !addmission 2 0
--     Gate Guards
-- Mokyokyo - !pos -55 -8 227 238
-- Janshura-Rashura - !pos -227 -8 184 240
-- Rakoh Buuma - !pos 106 -5 -23 241
-- Zokima-Rokima - !pos 0 -16 124 239
--
-- Hakkuru-Rinkuru - !pos -111 -4 101 240
--
-- Sama Gohjima - !pos 377 -13 98 116
--
-- _5c5 (Gate: Magical Gizmo) - !pos 419 0 -27 192
--
--     Gizmos
-- _5cp (Magical Gizmo) #1 - !pos 464 -3 100 192
-- _5cq (Magical Gizmo) #2 - !pos 406 -3 59 192
-- _5cr (Magical Gizmo) #3 - !pos 464 -3 20 192
-- _5cs (Magical Gizmo) #4 - !pos 295 -3 19 192
-- _5ct (Magical Gizmo) #5 - !pos 353 -3 60 192
-- _5cu (Magical Gizmo) #6 - !pos 295 -3 100 192
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/settings')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local innerHorutotoRuinsID = require("scripts/zones/Inner_Horutoto_Ruins/IDs")
local eastSarutabarutaID = require("scripts/zones/East_Sarutabaruta/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT)

-- A unique title is awarded from accepting the mission at each gate guard
-- This is handled by zone ID and used in handleAcceptMission below
local whichTitle =
{
    [238] = {titleGiven = xi.title.FRESH_NORTH_WINDS_RECRUIT}, -- Windurst Waters
    [239] = {titleGiven = xi.title.HEAVENS_TOWER_GATEHOUSE_RECRUIT}, -- Windurst Walls
    [240] = {titleGiven = xi.title.NEW_BEST_OF_THE_WEST_RECRUIT}, -- Port Windurst
    [241] = {titleGiven = xi.title.NEW_BUUMAS_BOOMERS_RECRUIT} -- Windurst Woods
}

mission.reward =
{
    rankPoints = 250,
}

local handleAcceptMission = function(player, csid, option, npc)
    local zone = player:getZoneID()
    local which = whichTitle[zone]
    if option == 1 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
        player:addTitle(which.titleGiven)
        player:setMissionStatus(mission.areaId, 1)
    end
end

local examineGizmo = function(mission, player, gizmoIndex, successCS, failCS)
    if mission:getVar(player, 'RandomGizmo') == gizmoIndex then
        return mission:progressEvent(successCS)
    else
        if not mission:isVarBitsSet(player, 'GizmoExamined', gizmoIndex) then
            mission:setVarBit(player, 'GizmoExamined', gizmoIndex)
            return mission:progressEvent(failCS)
        else
            return mission:messageSpecial(innerHorutotoRuinsID.text.EXAMINED_RECEPTACLE)
        end
    end
end

local gizmoSuccess = function(player, csid, option, npc)
    player:addKeyItem(xi.ki.CRACKED_MANA_ORBS)
    player:messageSpecial(innerHorutotoRuinsID.text.KEYITEM_OBTAINED, xi.ki.CRACKED_MANA_ORBS)
    player:setMissionStatus(mission.areaId, 4)
    mission:setVar(player, 'GizmoExamined', 0)
    mission:setVar(player, 'RandomGizmo', 0)
end

local gizmoFailure = function(player, csid, option, npc)
    player:messageSpecial(innerHorutotoRuinsID.text.NOT_BROKEN_ORB)
end

mission.sections =
{
    -- Player is offered mission from a gate guard
    {
        check = function(player, currentMission)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId and
                not player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Janshura-Rashura'] =  mission:progressEvent(83),

            onEventFinish = {
                [83] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Zokima-Rokima'] = mission:progressEvent(96),

            onEventFinish = {
                [96] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mokyokyo'] = mission:progressEvent(118),

            onEventFinish = {
                [118] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Rakoh_Buuma'] = mission:progressEvent(121),

            onEventFinish = {
                [121] =  handleAcceptMission,
            },
        },
    },

    -- Mission has been accepted, these NPCs dialogue does not change during mission
    {
        check = function(player, currentMission)
            return currentMission == mission.missionId
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Janshura-Rashura'] =  mission:event(89),
            ['Nine_of_Clubs'] = mission:event(86),
            ['Puo_Rhen'] = mission:event(88),
            ['Ten_of_Clubs'] = mission:event(87),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Keo-Koruo'] = mission:event(100),
            ['Pakke-Pokke'] = mission:event(101),
            ['Zokima-Rokima'] = mission:event(99),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Dagoza-Beruza'] = mission:event(121),
            ['Mokyokyo'] = mission:event(123),
            ['Panna-Donna'] = mission:event(122),
            ['Ten_of_Hearts'] = mission:event(124),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Miiri-Wohri'] = mission:event(124),
            ['Rakoh_Buuma'] = mission:event(127),
            ['Sola_Jaab'] = mission:event(125),
            ['Tih_Pikeh'] = mission:event(126),
        },
    },

    -- Go to the Orastery in Port Windurst (Home Point #1) and talk to Hakkuru-Rinkuru (E-7) for a cutscene.
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] = mission:progressEvent(90),

            onEventFinish =
            {
                [90] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },
    },

    -- Head to Inner Horutoto Ruins at (J-7) and examine Gate: Magic Gizmo
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.EAST_SARUTABARUTA] = {
            ['Sama_Gohjima'] = mission:event(53),
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] = mission:event(91),
        },

        [xi.zone.INNER_HORUTOTO_RUINS] =
        {
             -- Gate: Magical Gizmo
            ['_5c5'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(42)
                end,
            },

            onEventFinish =
            {
                [42] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                    mission:setVar(player, 'RandomGizmo', math.random(1, 6))
                end,
            },
        },
    },

    -- Find the broken Gizmo
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 3
        end,

        [xi.zone.INNER_HORUTOTO_RUINS] =
        {
            ['_5cp'] = { -- Magical Gizmo #1
                onTrigger = function(player, npc)
                    return examineGizmo(mission, player, 1, 48, 49)
                end,
            },

            ['_5cq'] = { -- Magical Gizmo #2
                onTrigger = function(player, npc)
                    return examineGizmo(mission, player, 2, 50, 51)
                end,
            },

            ['_5cr'] = { -- Magical Gizmo #3
                onTrigger = function(player, npc)
                    return examineGizmo(mission, player, 3, 52, 53)
                end,
            },

            ['_5cs'] = { -- Magical Gizmo #4
                onTrigger = function(player, npc)
                    return examineGizmo(mission, player, 4, 54, 55)
                end,
            },

            ['_5ct'] = { -- Magical Gizmo #5
                onTrigger = function(player, npc)
                    return examineGizmo(mission, player, 5, 56, 57)
                end,
            },

            ['_5cu'] = { -- Magical Gizmo #6
                onTrigger = function(player, npc)
                    return examineGizmo(mission, player, 6, 58, 59)
                end,
            },

            onEventFinish = {
                -- Magical Gizmo #1
                [48] = gizmoSuccess,
                [49] = gizmoFailure,

                -- Magical Gizmo #2
                [50] = gizmoSuccess,
                [51] = gizmoFailure,

                -- Magical Gizmo #3
                [52] = gizmoSuccess,
                [53] = gizmoFailure,

                -- Magical Gizmo #4
                [54] = gizmoSuccess,
                [55] = gizmoFailure,

                -- Magical Gizmo #5
                [56] = gizmoSuccess,
                [57] = gizmoFailure,

                -- Magical Gizmo #6
                [58] = gizmoSuccess,
                [59] = gizmoFailure,
            },

        },
    },

    -- Take the Cracked Mana Orb back to Hakkuru-Rinkuru in the Orastery to complete the mission.
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 4
        end,

        [xi.zone.EAST_SARUTABARUTA] = {
            ['Sama_Gohjima'] = {
                onTrigger = function(player, npc)
                    return mission:messageText(eastSarutabarutaID.text.SAMA_GOHJIMA_POSTDIALOG):setPriority(1000)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] = {
            ['Hakkuru-Rinkuru'] = {
                onTrigger = function(player, npc)
                    return mission:progressEvent(94, 0, xi.ki.CRACKED_MANA_ORBS)
                end,
            },

            ['Kuroido-Moido'] = mission:event(98),

            onEventFinish = {
                [94] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    -- All of the optional, very temporary post-mission dialogue! WOW, SO MUCH!
    -- TODO: Verify when Hakkuru-Rinkuru and Kuroido-Moido dialogue should change next for
    -- a Windurst citizen after completing this mission. For now, grouping with other
    -- gate guard-adjacent NPCs whose dialogue changes on accepting next mission.
    {
        check = function(player)
            return player:getNation() == mission.areaId and
                player:hasCompletedMission(mission.areaId, mission.missionId) and
                not player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_HEART_OF_THE_MATTER)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] = mission:event(96),
            ['Kuroido-Moido'] = mission:event(100):importantOnce(),
            ['Nine_of_Clubs'] = mission:event(102),
            ['Puo_Rhen'] = mission:event(101),
            ['Ten_of_Clubs'] = mission:event(103),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Keo-Koruo'] = mission:event(105),
            ['Pakke-Pokke'] = mission:event(104),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Dagoza-Beruza'] = mission:event(128),
            ['Panna-Donna'] = mission:event(127),
            ['Ten_of_Hearts'] = mission:event(129),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Miiri-Wohri'] = mission:event(115),
            ['Sola_Jaab'] = mission:event(130),
            ['Tih_Pikeh'] = mission:event(131),
        },
    },
}

return mission
