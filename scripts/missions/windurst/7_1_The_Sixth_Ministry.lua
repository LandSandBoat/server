-----------------------------------
-- The Sixth Ministry
-- Windurst M7-1
-----------------------------------
-- !addmission 2 18
-- Rakoh Buuma      : !pos 106 -5 -23 241
-- Mokyokyo         : !pos -55 -8 227 238
-- Janshura-Rashura : !pos -227 -8 184 240
-- Zokima-Rokima    : !pos 0 -16 124 239
-- Tosuka-Porika    : !pos -26 -6 103 238
-- _4pc             : !pos 132 12 -19 169
-----------------------------------
local toraimaraiID = zones[xi.zone.TORAIMARAI_CANAL]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_SIXTH_MINISTRY)

mission.reward =
{
    keyItem    = xi.ki.BLANK_BOOK_OF_THE_GODS,
    rankPoints = 700,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 18 then
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

        [xi.zone.WINDURST_WATERS] =
        {
            ['Tosuka-Porika'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(715, 0, xi.ki.OPTISTERY_RING)
                    elseif missionStatus == 1 then
                        return mission:progressEvent(716, 0, xi.ki.OPTISTERY_RING)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(724)
                    end
                end,
            },

            onEventFinish =
            {
                [715] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.OPTISTERY_RING)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [724] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.OPTISTERY_RING)
                    end
                end
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId or
                player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.TORAIMARAI_CANAL] =
        {
            ['_4pc'] =
            {
                onTrigger = function(player, npc)
                    for i = toraimaraiID.mob.HINGE_OILS_OFFSET, toraimaraiID.mob.HINGE_OILS_OFFSET + 3 do
                        if not GetMobByID(i):isDead() then
                            -- At least one Hinge Oil is alive
                            return mission:progressEvent(70, 0, 0, 0, 1)
                        end
                    end

                    -- All four Hinge Oils are dead
                    return mission:progressEvent(70, 0, 0, 0, 2)
                end,
            },

            ['Tome_of_Magic'] =
            {
                onTrigger = function(player, npc)
                    local tomeOffset = npc:getID() - toraimaraiID.npc.TOME_OF_MAGIC_OFFSET

                    if
                        tomeOffset == 4 and
                        player:getMissionStatus(mission.areaId) == 1
                    then
                        return mission:progressEvent(69)
                    end
                end,
            },

            onEventFinish =
            {
                [69] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },
    },
}

return mission
