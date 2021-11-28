-----------------------------------
-- Immortal Sentries
-- Aht Uhrgan Mission 2
-----------------------------------
-- !addmission 4 1
-- Daswil  : !pos -208.720 -12.889 -779.713 52
-- Meyaada : !pos 22.446 -7.920 573.390 54
-- Nahshib : !pos -274.334 -9.287 -64.255 79
-- Nareema : !pos 518.387 -24.707 -467.297 79
-- Waudeen : !pos 673.882 -23.995 367.604 61
-----------------------------------
require('scripts/settings/main')
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/keyitems')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local caedarvaID = require("scripts/zones/Caedarva_Mire/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.IMMORTAL_SENTRIES)

mission.reward =
{
    keyItem     = xi.ki.PSC_WILDCAT_BADGE,
    title       = xi.title.PRIVATE_SECOND_CLASS,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.PRESIDENT_SALAHEEM },
}

mission.sections =
{
    -- NOTE: Runic Portal onEventFinish is currently handled by the respective NPC scripts.  The onTrigger
    -- logic for this mission could potentially be returned to them.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE) then
                        -- Naja Salaheem interactions require the 9th argument in events set to 0.
                        -- This is because Aht Uhrgan Whitegate uses 2 different dats.
                        return mission:progressEvent(3002, 0, 0, 0, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [3002] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        -- TODO: npcUtil.completeMission should support granting IS
                        player:addCurrency('imperial_standing', 150)
                    end
                end,
            },
        },

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['Meyaada'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE) then
                        return mission:progressEvent(5)
                    else
                        return mission:progressEvent(6)
                    end
                end,
            },

            ['Runic_Portal'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE) then
                        return mission:progressEvent(111)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.SUPPLIES_PACKAGE)
                    end
                end,
            },
        },

        [xi.zone.BHAFLAU_THICKETS] =
        {
            ['Daswil'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE) then
                        return mission:progressEvent(5)
                    else
                        return mission:progressEvent(6)
                    end
                end,
            },

            ['Runic_Portal'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE) then
                        return mission:progressEvent(111)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.SUPPLIES_PACKAGE)
                    end
                end,
            },
        },

        [xi.zone.CAEDARVA_MIRE] =
        {
            ['Nahshib'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE) then
                        return mission:progressEvent(5)
                    else
                        return mission:progressEvent(6)
                    end
                end,
            },

            ['Nareema'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE) then
                        return mission:progressEvent(5, 1)
                    else
                        return mission:progressEvent(6, 1)
                    end
                end,
            },

            ['Runic_Portal'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE) then
                        local eventId = npc:getID() == caedarvaID.npc.RUNIC_PORTAL_AZOUPH and 124 or 125

                        return mission:progressEvent(eventId)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.SUPPLIES_PACKAGE)
                    end
                end,
            },
        },

        [xi.zone.MOUNT_ZHAYOLM] =
        {
            ['Waudeen'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE) then
                        return mission:progressEvent(4)
                    else
                        return mission:progressEvent(5)
                    end
                end,
            },

            ['Runic_Portal'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE) then
                        return mission:progressEvent(111)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.SUPPLIES_PACKAGE)
                    end
                end,
            },
        },
    },
}

return mission
