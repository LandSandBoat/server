-----------------------------------
-- The Price of Peace
-- Windurst M1-3
-----------------------------------
-- !addmission 2 2
-- Rakoh Buuma      : !pos 106 -5 -23 241
-- Mokyokyo         : !pos -55 -8 227 238
-- Janshura-Rashura : !pos -227 -8 184 240
-- Zokima-Rokima    : !pos 0 -16 124 239
-- Leepe-Hoppe      : !pos 13 -9 -197 238
-- Ohbiru-Dohbiru   : !pos 23 -5 -193 238
-- Laa Mozi         : !pos -22 0 148 145
-- Ghoo Pakya       : !pos -139 0 147 145
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local giddeusID = require("scripts/zones/Giddeus/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_PRICE_OF_PEACE)

mission.reward =
{
    gil = 1000,
    rank = 2,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 2 then
        mission:begin(player)
        player:setMissionStatus(mission.areaId, 1)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

local offeringsTurnedIn = function(player, csid, option, npc)
    local offeringsVar = mission:getVar(player, "OfferingsTurnedIn")

    if csid == 45 and player:hasKeyItem(xi.ki.FOOD_OFFERING) then
        player:delKeyItem(xi.ki.FOOD_OFFERING)
        player:messageSpecial(giddeusID.text.OFFERED_UP_KEY_ITEM, xi.ki.FOOD_OFFERING)
        offeringsVar = offeringsVar + 1
    elseif csid == 49 and player:hasKeyItem(xi.ki.DRINK_OFFERING) then
        player:delKeyItem(xi.ki.DRINK_OFFERING)
        player:messageSpecial(giddeusID.text.OFFERED_UP_KEY_ITEM, xi.ki.DRINK_OFFERING)
        offeringsVar = offeringsVar + 1
    end

    if offeringsVar == 2 then
        player:setMissionStatus(mission.areaId, 3)
        mission:setVar(player, "OfferingsTurnedIn", 0)
    else
        mission:setVar(player, "OfferingsTurnedIn", offeringsVar)
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
            ['Janshura-Rashura'] = mission:event(110),
            ['Nine_of_Clubs']    = mission:event(112),
            ['Puo_Rhen']         = mission:event(111),
            ['Ten_of_Clubs']     = mission:event(113),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Chawo_Shipeynyo'] = mission:event(115),
            ['Keo-Koruo']       = mission:event(114),
            ['Pakke-Pokke']     = mission:event(113),
            ['Zokima-Rokima']   = mission:event(112),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Dagoza-Beruza'] = mission:event(138),
            ['Mokyokyo']      = mission:event(136),
            ['Panna-Donna']   = mission:event(137),
            ['Ten_of_Hearts'] = mission:event(139),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Miiri-Wohri'] = mission:event(151),
            ['Rakoh_Buuma'] = mission:event(150),
            ['Sola_Jaab']   = mission:event(153),
            ['Tih_Pikeh']   = mission:event(152),
        },
    },

    -- Speak to Leepe-Hoppe on the roof of the Rhinostery near Waters HP #3
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kenapa-Keppa']   = mission:event(145),
            ['Leepe-Hoppe']    = mission:progressEvent(140),
            ['Ohbiru-Dohbiru'] = mission:event(143),

            onEventFinish =
            {
                [140] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, {
                        xi.ki.FOOD_OFFERING,
                        xi.ki.DRINK_OFFERING
                    })
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },
    },

    -- Take the Offerings to Giddeus and give them to the Yagudo NPCs
    -- On retail, the Yagudo NPCs repeat the same dialogue until after both
    -- offerings are turned in, even on repeat interactions
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Leepe-Hoppe'] = mission:progressEvent(142),
        },

        [xi.zone.GIDDEUS] =
        {
            ['Ghoo_Pakya'] = mission:progressEvent(49),
            ['Laa_Mozi']   = mission:progressEvent(45),

            onEventFinish =
            {
                [45] = offeringsTurnedIn,
                [49] = offeringsTurnedIn,
            },
        },
    },

    -- Offerings were delivered
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 3
        end,

        [xi.zone.GIDDEUS] =
        {
            ['Ghoo_Pakya'] = mission:event(52):replaceDefault(),
            ['Laa_Mozi']   = mission:event(48):replaceDefault(),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] = mission:event(144),

            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    return mission:progressEvent(146)
                end,
            },

            onEventFinish =
            {
                [146] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,
            },
        },
    },

    -- Finish mission with a gate guard
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 4
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Janshura-Rashura'] = mission:progressEvent(114),

            onEventFinish =
            {
                [114] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Zokima-Rokima'] = mission:progressEvent(116),

            onEventFinish =
            {
                [116] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Leepe-Hoppe'] = mission:event(147):importantOnce(),
            ['Mokyokyo']    = mission:progressEvent(148),

            onEventFinish =
            {
                [148] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Rakoh_Buuma'] = mission:progressEvent(154),

            onEventFinish =
            {
                [154] = function(player, csid, option, npc)
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
                not player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.LOST_FOR_WODS)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Nine_of_Clubs'] = mission:event(117),
            ['Puo_Rhen']      = mission:event(116),
            ['Ten_of_Clubs']  = mission:event(118),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Chawo_Shipeynyo'] = mission:event(120),
            ['Keo-Koruo']       = mission:event(118),
            ['Pakke-Pokke']     = mission:event(119),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Dagoza-Beruza'] = mission:event(150),
            ['Panna-Donna']   = mission:event(152),
            ['Ten_of_Hearts'] = mission:event(154),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Miiri-Wohri'] = mission:event(157),
            ['Sola_Jaab']   = mission:event(158),
            ['Tih_Pikeh']   = mission:event(131),
        },
    },
}

return mission
