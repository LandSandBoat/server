-----------------------------------
-- Lost for Words
-- Windurst M2-1
-----------------------------------
-- !addmission 2 3
-- Rakoh Buuma       : !pos 106 -5 -23 241
-- Mokyokyo          : !pos -55 -8 227 238
-- Janshura-Rashura  : !pos -227 -8 184 240
-- Zokima-Rokima     : !pos 0 -16 124 239
-- Tosuka-Porika     : !pos -26 -6 103 238
-- Nanaa Mihgo       : !pos 62 -4 240 241
-- Fossil Rocks      : !pos 17 18 184 198
-- Mahogany Door     : !pos -11 0 20 192
-- House of the Hero : !pos -26 -13 260 239
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local mazeID = require("scripts/zones/Maze_of_Shakhrami/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.LOST_FOR_WORDS)

mission.reward =
{
    rankPoints = 300,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 3 then
        mission:begin(player)
        player:setMissionStatus(mission.areaId, 1)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

local examineRock = function(player, npc)
    local rockOffset = npc:getID() - mazeID.npc.FOSSIL_ROCK_OFFSET
    local correctRock = mission:getVar(player, "Rock")
    local missionStatus = player:getMissionStatus(mission.areaId)

    if rockOffset == correctRock then
        if missionStatus == 3 then
            player:setMissionStatus(mission.areaId, 4)
            return mission:keyItem(xi.ki.LAPIS_CORAL)
        elseif missionStatus == 4 then
            return mission:messageSpecial(mazeID.text.NO_NEED_INVESTIGATE)
        end
    else
        -- TODO: This multiline message should be converted to messageName, however the equivalent in
        -- interaction is used for a different purpose.  Find a new method to implement in the interaction
        -- container to handle.
        return mission:messageSpecial(mazeID.text.JUST_A_ROCK)
    end
end

mission.sections =
{
    -- Player is offered mission from a gate guard. Note that retail will have the
    -- player be presented with the mission selection menu, choose, accept, and then
    -- start the events below, where you accept it again.
    -- Choosing to keep the existing flow we had already.
    {
        check = function(player, currentMission)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId and
                not player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            onEventFinish =
            {
                [93] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            onEventFinish =
            {
                [111] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            onEventFinish =
            {
                [114] = handleAcceptMission,
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
            ['Janshura-Rashura'] = mission:event(120),
            ['Nine_of_Clubs']    = mission:event(121),
            ['Puo_Rhen']         = mission:event(123),
            ['Ten_of_Clubs']     = mission:event(122),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Chawo_Shipeynyo'] = mission:event(125),
            ['Keo-Koruo']       = mission:event(123),
            ['Pakke-Pokke']     = mission:event(124),
            ['Zokima-Rokima']   = mission:event(122),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Aora-Uora']       = mission:event(167),
            ['Dagoza-Beruza']   = mission:event(157),
            ['Furakku-Norakku'] = mission:event(165),
            ['Kotan-Moritan']   = mission:event(166),
            ['Mokyokyo']        = mission:event(156),
            ['Panna-Donna']     = mission:event(158),
            ['Ten_of_Hearts']   = mission:event(159),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Miiri-Wohri'] = mission:event(161),
            ['Rakoh_Buuma'] = mission:event(160),
            ['Sola_Jaab']   = mission:event(162),
            ['Tih_Pikeh']   = mission:event(163),
        },
    },

    -- Head for the Optistery on the northern map of Windurst Waters (near Home Point #1).
    -- Speak to Tosuka-Porika at (G-8).
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Tosuka-Porika'] = mission:progressEvent(160),

            onEventFinish =
            {
                [160] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },
    },

    -- Speak to Nanaa Mihgo in Windurst Woods (neat Home Point #1).
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] = mission:progressEvent(165, 0, xi.ki.LAPIS_CORAL, xi.ki.LAPIS_MONOCLE),

            onEventFinish =
            {
                [165] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LAPIS_MONOCLE)
                    mission:setVar(player, "Rock", math.random(1, 6))
                    player:setMissionStatus(mission.areaId, 3)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Tosuka-Porika'] = mission:progressEvent(161),
        },
    },

    -- Head to Maze of Shakhrami.
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 3
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Bopa_Greso']  = mission:progressEvent(167),
            ['Cha_Lebagta'] = mission:progressEvent(168),
            ['Nanaa_Mihgo'] = mission:progressEvent(166),
        },
    },

    -- Examine Fossil Rocks until you get LAPIS_CORAL.
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and (missionStatus == 3 or missionStatus == 4)
        end,

        [xi.zone.MAZE_OF_SHAKHRAMI] =
        {
            ['Fossil_Rock'] =
            {
                onTrigger = function(player, npc)
                    return examineRock(player, npc)
                end,
            },
        },
    },

    -- Return to Nanaa Mihgo.
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 4
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] = mission:progressEvent(169),

            onEventFinish =
            {
                [169] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.LAPIS_CORAL)
                    player:delKeyItem(xi.ki.LAPIS_MONOCLE)
                    mission:setVar(player, "Rock", 0)
                    npcUtil.giveKeyItem(player, xi.ki.HIDEOUT_KEY)
                    player:setMissionStatus(mission.areaId, 5)
                end,
            },
        },
    },

    -- Head to Inner Horutoto Ruins entering from the tower at (J-7) in East Sarutabaruta.
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 5
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Bopa_Greso']  = mission:progressEvent(171),
            ['Cha_Lebagta'] = mission:progressEvent(172),
            ['Nanaa_Mihgo'] = mission:progressEvent(170),
        },

        [xi.zone.INNER_HORUTOTO_RUINS] =
        {
            ['_5ca'] = mission:progressEvent(46),

            onEventFinish =
            {
                [46] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.HIDEOUT_KEY)
                    player:setMissionStatus(mission.areaId, 6)
                end,
            },
        },
    },

    -- Go to the House of the Hero in Windurst Walls (G-3) (Home Point #1).
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 6
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Bopa_Greso']  = mission:progressEvent(174),
            ['Cha_Lebagta'] = mission:progressEvent(175),
            ['Nanaa_Mihgo'] = mission:progressEvent(173),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['_6n2'] = mission:progressEvent(337),

            onEventFinish =
            {
                [337] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 7)
                end,
            },
        },
    },

    -- Head back to Tosuka-Porika to complete the mission.
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 7
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Tosuka-Porika'] = mission:progressEvent(168),

            onEventFinish =
            {
                [168] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    -- All of the optional post-mission dialogue
    {
        check = function(player)
            return player:getNation() == mission.areaId and
                player:hasCompletedMission(mission.areaId, mission.missionId) and
                not player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.A_TESTING_TIME)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Nine_of_Clubs'] = mission:event(74),
            ['Puo_Rhen']      = mission:event(81),
            ['Ten_of_Clubs']  = mission:event(80),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Chawo_Shipeynyo'] = mission:event(329),
            ['Keo-Koruo']       = mission:event(88),
            ['Pakke-Pokke']     = mission:event(94),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Aora-Uora']       = mission:event(175),
            ['Dagoza-Beruza']   = mission:event(115),
            ['Furakku-Norakku'] = mission:event(173),
            ['Kotan-Moritan']   = mission:event(174),
            ['Panna-Donna']     = mission:event(116),
            ['Ten_of_Hearts']   = mission:event(114),
            ['Tosuka-Porika']   = mission:event(169),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Miiri-Wohri'] = mission:event(118),
            ['Sola_Jaab']   = mission:event(117),
            ['Tih_Pikeh']   = mission:event(119),
        },
    },
}

return mission
