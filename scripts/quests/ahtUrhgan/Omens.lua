-----------------------------------
-- Omens
-----------------------------------
-- Log ID: 6, Quest ID: 22
-- Waoud           : !pos 65 -6 -78 50
-- Lathuya         : !pos -95.081 -6 31.638 50
-- Aydeewa (Blank) : !pos 342.129 36.509 -24.856 68
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
-----------------------------------
local whitegateID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS)

quest.reward =
{
    item = xi.items.MAGUS_CHARUQS,
    title = xi.title.IMMORTAL_LION,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS) and
                player:getMainJob() == xi.job.BLU and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL
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
                        return quest:progressEvent(710)
                    end
                end,
            },

            onEventFinish =
            {
                [710] = function(player, csid, option, npc)
                    quest:begin(player)

                    xi.quest.setVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS, 'Timer', VanadielUniqueDay() + 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    local lastDivination = xi.quest.getVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, 'Timer')

                    if questProgress == 1 then
                        return quest:progressEvent(712)
                    elseif lastDivination <= VanadielUniqueDay() then
                        if questProgress == 0 then
                            return quest:progressEvent(711, player:getGil())
                        elseif questProgress == 2 then
                            return quest:progressEvent(713, player:getGil())
                        end
                    end
                end,
            },

            ['Lathuya'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:progressEvent(714)
                    elseif questProgress == 3 then
                        return quest:progressEvent(715)
                    elseif questProgress == 4 then
                        return quest:progressEvent(716)
                    end
                end,
            },

            onEventFinish =
            {
                [711] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        player:getGil() >= 1000
                    then
                        player:delGil(1000)
                        player:messageSpecial(whitegateID.text.PAY_DIVINATION)

                        xi.quest.setVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,

                [712] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SEALED_IMMORTAL_ENVELOPE)
                    quest:setVar(player, 'Prog', 2)
                end,

                [713] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        player:getGil() >= 1000
                    then
                        player:delGil(1000)
                        player:messageSpecial(whitegateID.text.PAY_DIVINATION)

                        xi.quest.setVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,

                [714] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [716] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SEALED_IMMORTAL_ENVELOPE)

                        xi.quest.setVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, 'Timer', VanadielUniqueDay() + 1)
                        xi.quest.setMustZone(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS)
                    end
                end,
            },
        },

        [xi.zone.NAVUKGO_EXECUTION_CHAMBER] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 1122 and
                        quest:getVar(player, 'Prog') == 0
                    then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },

        [xi.zone.AYDEEWA_SUBTERRANE] =
        {
            ['blank_omens'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(9)
                    end
                end,
            },

            onEventFinish =
            {
                [9] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Lathuya'] = quest:event(718):replaceDefault(),
        },
    },
}

return quest
