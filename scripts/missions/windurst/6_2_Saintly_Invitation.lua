-----------------------------------
-- Saintly Invitation
-- Windurst M6-2
-----------------------------------
-- !addmission 2 17
-- Rakoh Buuma       : !pos 106 -5 -23 241
-- Mokyokyo          : !pos -55 -8 227 238
-- Janshura-Rashura  : !pos -227 -8 184 240
-- Zokima-Rokima     : !pos 0 -16 124 239
-- Vestal Chamber    : !pos 0.1 -49 37 242
-- Kaa Toru the Just : !pos -100.188 -62.125 145.422 151
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.SAINTLY_INVITATION)

mission.reward =
{
    gil = 40000,
    rank = 7,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 17 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
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

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.HEAVENS_TOWER] =
        {
            ['_6q2'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(310)
                    elseif missionStatus == 3 then
                        return mission:progressEvent(312)
                    end
                end,
            },

            onEventFinish =
            {
                [310] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    player:addTitle(xi.title.HERO_ON_BEHALF_OF_WINDURST)
                    npcUtil.giveKeyItem(player, xi.ki.HOLY_ONES_INVITATION)
                end,

                [312] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.HOLY_ONES_OATH)
                    end
                end,
            },
        },

        [xi.zone.BALGAS_DAIS] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        player:getLocalVar('battlefieldWin') == 99
                    then
                        player:addTitle(xi.title.VICTOR_OF_THE_BALGA_CONTEST)
                        npcUtil.giveKeyItem(player, xi.ki.BALGA_CHAMPION_CERTIFICATE)
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            }
        },

        [xi.zone.CASTLE_OZTROJA] =
        {
            ['Kaa_Toru_the_Just'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return mission:progressEvent(45, 0, 200)
                    end
                end,
            },

            onEventFinish =
            {
                [45] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.ASHURA_NECKLACE) then
                        player:delKeyItem(xi.ki.HOLY_ONES_INVITATION)
                        npcUtil.giveKeyItem(player, xi.ki.HOLY_ONES_OATH)
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,
            },
        },
    },
}

return mission
