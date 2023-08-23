-----------------------------------
-- Beginnings
-----------------------------------
-- Log ID: 6, Quest ID: 21
-- Waoud   : !pos 65 -6 -78 50
-- Daswil  : !pos -208.720 -12.889 -779.713 52
-- Meyaada : !pos 22.446 -7.920 573.390 54
-- Nahshib : !pos -274.334 -9.287 -64.255 79
-- Nareema : !pos 518.387 -24.707 -467.297 79
-- Waudeen : !pos 673.882 -23.995 367.604 61
-----------------------------------
local whitegateID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS)

quest.reward =
{
    item = xi.item.IMMORTALS_SCIMITAR,
}

local brandKeyItems =
{
    xi.ki.BRAND_OF_THE_SPRINGSERPENT,
    xi.ki.BRAND_OF_THE_GALESERPENT,
    xi.ki.BRAND_OF_THE_FLAMESERPENT,
    xi.ki.BRAND_OF_THE_SKYSERPENT,
    xi.ki.BRAND_OF_THE_STONESERPENT,
}

local function hasRequiredBrands(player)
    for _, keyItem in ipairs(brandKeyItems) do
        if not player:hasKeyItem(keyItem) then
            return false
        end
    end

    return true
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.IMMORTAL_SENTRIES) and
                player:hasCompletedQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL) and
                player:getMainJob() == xi.job.BLU and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL and
                xi.quest.getVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, 'completeEvent') == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    local lastDivination = xi.quest.getVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, 'Timer')

                    if
                        lastDivination <= VanadielUniqueDay() and
                        not quest:getMustZone(player)
                    then
                        return quest:progressEvent(705)
                    end
                end,
            },

            onEventFinish =
            {
                [705] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)

                        xi.quest.setVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
                player:getMainJob() == xi.job.BLU
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    local lastDivination = xi.quest.getVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, 'Timer')

                    if hasRequiredBrands(player) then
                        return quest:progressEvent(707)
                    elseif lastDivination <= VanadielUniqueDay() then
                        return quest:progressEvent(706, player:getGil())
                    end
                end,
            },

            onEventFinish =
            {
                [706] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        player:getGil() >= 1000
                    then
                        player:delGil(1000)
                        player:messageSpecial(whitegateID.text.PAY_DIVINATION)

                        xi.quest.setVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,

                [707] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        xi.quest.setVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS, 'Timer', VanadielUniqueDay() + 1)
                        xi.quest.setMustZone(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS)
                    end
                end,
            },
        },

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['Meyaada'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BRAND_OF_THE_SPRINGSERPENT) then
                        return quest:progressEvent(10)
                    else
                        return quest:event(11):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.BRAND_OF_THE_SPRINGSERPENT)
                end,
            },
        },

        [xi.zone.BHAFLAU_THICKETS] =
        {
            ['Daswil'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BRAND_OF_THE_SKYSERPENT) then
                        return quest:progressEvent(8)
                    else
                        return quest:event(9):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.BRAND_OF_THE_SKYSERPENT)
                end,
            },
        },

        [xi.zone.CAEDARVA_MIRE] =
        {
            ['Nahshib'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BRAND_OF_THE_GALESERPENT) then
                        return quest:progressEvent(10)
                    else
                        return quest:event(11):importantEvent()
                    end
                end,
            },

            ['Nareema'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BRAND_OF_THE_STONESERPENT) then
                        return quest:progressEvent(12)
                    else
                        return quest:event(13):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.BRAND_OF_THE_GALESERPENT)
                end,

                [12] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.BRAND_OF_THE_STONESERPENT)
                end,
            },
        },

        [xi.zone.MOUNT_ZHAYOLM] =
        {
            ['Waudeen'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BRAND_OF_THE_FLAMESERPENT) then
                        return quest:progressEvent(10)
                    else
                        return quest:event(11):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.BRAND_OF_THE_FLAMESERPENT)
                end,
            },
        },
    },
}

return quest
