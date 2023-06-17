-----------------------------------
-- Immortal Sentries
-- Aht Uhrgan Mission 2
-----------------------------------
-- !addmission 4 1
-- Daswil        : !pos -208.720 -12.889 -779.713 52
-- Meyaada       : !pos 22.446 -7.920 573.390 54
-- Nahshib       : !pos -274.334 -9.287 -64.255 79
-- Nareema       : !pos 518.387 -24.707 -467.297 79
-- Waudeen       : !pos 673.882 -23.995 367.604 61
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local whitegateID = require('scripts/zones/Aht_Urhgan_Whitegate/IDs')
local arrapagoID  = require('scripts/zones/Arrapago_Reef/IDs')
local bhaflauID   = require('scripts/zones/Bhaflau_Thickets/IDs')
local caedarvaID  = require('scripts/zones/Caedarva_Mire/IDs')
local zhayolmID   = require('scripts/zones/Mount_Zhayolm/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.IMMORTAL_SENTRIES)

local function handlePackage(player)
    player:delKeyItem(xi.ki.SUPPLIES_PACKAGE)
    player:addCurrency('imperial_standing', 150)
end

-- TODO: npcUtil.completeMission should support granting IS
mission.reward =
{
    keyItem     = xi.ki.PSC_WILDCAT_BADGE,
    title       = xi.title.PRIVATE_SECOND_CLASS,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.PRESIDENT_SALAHEEM },
}

mission.sections =
{
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
                        return mission:progressEvent(3002, { text_table = 0 })
                    else
                        return mission:event(3001, { text_table = 0 }) -- Default Dialog.
                    end
                end,
            },

            onEventFinish =
            {
                [3002] = function(player, csid, option, npc)
                    player:messageSpecial(whitegateID.text.MEMBER_OF_SALAHEEMS_SENTINELS)
                    mission:complete(player)
                    player:messageSpecial(whitegateID.text.ACCESS_TO_A_MOG_LOCKER)
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

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    if option == 1 then
                        handlePackage(player)
                        player:messageSpecial(arrapagoID.text.HAND_OVER_TO_IMMORTAL, xi.ki.SUPPLIES_PACKAGE)
                        player:messageSpecial(arrapagoID.text.YOUR_IMPERIAL_STANDING)
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

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    if option == 1 then
                        handlePackage(player)
                        player:messageSpecial(bhaflauID.text.HAND_OVER_TO_IMMORTAL, xi.ki.SUPPLIES_PACKAGE)
                        player:messageSpecial(bhaflauID.text.YOUR_IMPERIAL_STANDING)
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

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    if option == 1 then
                        handlePackage(player)
                        player:messageSpecial(caedarvaID.text.HAND_OVER_TO_IMMORTAL, xi.ki.SUPPLIES_PACKAGE)
                        player:messageSpecial(caedarvaID.text.YOUR_IMPERIAL_STANDING)
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

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    if option == 1 then
                        handlePackage(player)
                        player:messageSpecial(zhayolmID.text.HAND_OVER_TO_IMMORTAL, xi.ki.SUPPLIES_PACKAGE)
                        player:messageSpecial(zhayolmID.text.YOUR_IMPERIAL_STANDING)
                    end
                end,
            },
        },
    },
}

return mission
