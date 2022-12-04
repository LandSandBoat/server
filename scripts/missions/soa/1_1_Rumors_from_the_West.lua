-----------------------------------
-- Rumors from the West
-- Seekers of Adoulin M1-1
-----------------------------------
-- NOTE: xi.mission.id.soa.RUMORS_FROM_THE_WEST is set on character creation
-- !addmission 12 0
-- Darcia : !pos -36 -1 -15 245
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.RUMORS_FROM_THE_WEST)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_GEOMAGNETRON },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            -- Hack: don't display until first character intro CS is shown.
            -- This is needed because this mission sorts before hidden quests and gets checked first

            if
                xi.settings.main.NEW_CHARACTER_CUTSCENE == 1 and
                player:getCharVar("HQuest[newCharacterCS]notSeen") == 1
            then
                return false
            end

            return currentMission == mission.missionId and xi.settings.main.ENABLE_SOA == 1
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Darcia'] =
            {
                onTrigger = function(player, npc)
                    -- local turnOffNevermind     = 1
                    -- local turnOffApply         = 2
                    -- local turnOffSystemInfo    = 4
                    local turnOffDungeonInfo   = 8
                    -- local turnOffOptionToPay   = 16
                    local turnOffAskingForWork = 32

                    return mission:progressEvent(10117, 0, turnOffDungeonInfo + turnOffAskingForWork)
                end,
            },

            onEventUpdate =
            {
                [10117] = function(player, csid, option, npc)
                    local hasEnoughGil = player:getGil() >= 1000000 and 1 or 0
                    player:updateEvent(hasEnoughGil)
                end,
            },

            onEventFinish =
            {
                [10117] = function(player, csid, option, npc)
                    if option == 1 then
                        if mission:complete(player) then
                            npcUtil.giveKeyItem(player, xi.ki.GEOMAGNETRON)
                        end
                    elseif option == 2 then
                        -- Paid to skip ahead, handle this manually
                        mission:complete(player)
                        player:delGil(1000000)
                        npcUtil.giveKeyItem(player, xi.ki.ADOULINIAN_CHARTER_PERMIT)
                        player:completeMission(xi.mission.log_id.SOA, xi.mission.id.soa.THE_GEOMAGNETRON)
                        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ONWARD_TO_ADOULIN)
                    end
                end,
            },
        },

        -- Optional CS's
        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = player:getMissionStatus(mission.areaId)
                    local seenCS = utils.mask.getBit(missionStatus, 0)
                    if not seenCS and not player:isInMogHouse() then
                        return 878
                    end
                end,
            },

            onEventFinish =
            {
                [878] = function(player, csid, option, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)
                    missionStatus = utils.mask.setBit(missionStatus, 0, true)
                    player:setMissionStatus(mission.areaId, missionStatus)
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = player:getMissionStatus(mission.areaId)
                    local seenCS = utils.mask.getBit(missionStatus, 1)
                    if not seenCS and not player:isInMogHouse() then
                        return 22
                    end
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)
                    missionStatus = utils.mask.setBit(missionStatus, 1, true)
                    player:setMissionStatus(mission.areaId, missionStatus)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = player:getMissionStatus(mission.areaId)
                    local seenCS = utils.mask.getBit(missionStatus, 2)
                    if not seenCS and not player:isInMogHouse() then
                        return 839
                    end
                end,
            },

            onEventFinish =
            {
                [839] = function(player, csid, option, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)
                    missionStatus = utils.mask.setBit(missionStatus, 2, true)
                    player:setMissionStatus(mission.areaId, missionStatus)
                end,
            },
        },
    },
}

return mission
