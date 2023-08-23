-----------------------------------
-- The Geomagnetron
-- Seekers of Adoulin M1-2
-----------------------------------
-- !addmission 12 1
-- Darcia : !pos -36 -1 -15 245
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_GEOMAGNETRON)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.ONWARD_TO_ADOULIN },
}

mission.sections =
{
    -- 0: Use Geomagnetron on a Geomagnetic Fount
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and player:getCharVar('SOA') == 0
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Darcia'] =
            {
                onTrigger = function(player, npc)
                    -- local turnOffNevermind      = 1
                    -- local turnOffApply          = 2
                    -- local turnOffSystemInfo     = 4
                    -- local turnOffDungeonInfo    = 8
                    -- local turnOffOptionToPay    = 16
                    local turnOffAskingForWork  = 32

                    return mission:progressEvent(10117, 1, turnOffAskingForWork)
                end,
            },

            onEventUpdate =
            {
                [10117] = function(player, csid, option, npc)
                    local hasEnoughGil = player:getGil() >= 1000000 and 1 or 0
                    print(hasEnoughGil)
                    player:updateEvent(hasEnoughGil)
                end,
            },

            onEventFinish =
            {
                [10117] = function(player, csid, option, npc)
                    if option == 2 then
                        -- Paid to skip ahead, handle this manually
                        mission:complete(player)
                        player:delGil(1000000)
                        npcUtil.giveKeyItem(player, xi.ki.ADOULINIAN_CHARTER_PERMIT)
                    end
                end,
            }
        },
    },

    -- 1: Used Geomagnetron
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and player:getCharVar('SOA') == 1
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Darcia'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(10118)
                end,
            },

            onEventFinish =
            {
                [10118] = function(player, csid, option, npc)
                    mission:complete(player)
                    player:delKeyItem(xi.ki.GEOMAGNETRON)
                    npcUtil.giveKeyItem(player, xi.ki.GEOMAGNETRON)
                    npcUtil.giveKeyItem(player, xi.ki.ADOULINIAN_CHARTER_PERMIT)
                    player:setCharVar('SOA', 0)
                end,
            },
        },
    },
}

return mission
