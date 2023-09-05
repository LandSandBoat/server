-----------------------------------
-- Promotion: Lance Corporal
-- Log ID: 6, Quest ID: 92
-- Naja Salaheem !pos 26 -8 -45.5 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/quest')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_LANCE_CORPORAL)

local testTubes =
{
    [16986736] = { xi.ki.EMPTY_TEST_TUBE_1, xi.ki.TEST_TUBE_1 },
    [16986737] = { xi.ki.EMPTY_TEST_TUBE_2, xi.ki.TEST_TUBE_2 },
    [16986738] = { xi.ki.EMPTY_TEST_TUBE_3, xi.ki.TEST_TUBE_3 },
    [16986739] = { xi.ki.EMPTY_TEST_TUBE_4, xi.ki.TEST_TUBE_4 },
}

quest.reward =
{
    keyItem = xi.ki.LC_WILDCAT_BADGE,
    title   = xi.title.LANCE_CORPORAL,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_SUPERIOR_PRIVATE) == QUEST_COMPLETED and
                player:getCharVar("AssaultPromotion") >= 25
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] = quest:progressEvent(5030, { text_table = 0 }),

            onEventFinish =
            {
                [5030] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
                vars.Prog < 2
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(5032)
                    else
                        return quest:event(5033)
                    end
                end,
            },

            ['Nafiwaa'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(5035, { text_table = 0 })
                    else
                        return quest:event(5036)
                    end
                end,
            },

            onEventFinish =
            {
                [5035] = function(player, csid, option, npc)
                    if option == 0 then
                        for testTube = xi.ki.EMPTY_TEST_TUBE_1, xi.ki.EMPTY_TEST_TUBE_5 do
                            npcUtil.giveKeyItem(player, testTube)
                        end

                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            ['Mythralline_Wellspring'] =
            {
                onTrigger = function(player, npc)
                    local id = npc:getID()

                    if
                        not player:hasKeyItem(testTubes[id][2]) and
                        player:hasKeyItem(testTubes[id][1])
                    then
                        return quest:progressEvent(5)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    local id = npc:getID()
                    local progress = true

                    if option == 0 then
                        npcUtil.giveKeyItem(player, testTubes[id][2])
                        player:delKeyItem(testTubes[id][1])

                        -- Progress to section 2 if all test tubes found
                        for tube = xi.ki.TEST_TUBE_1, xi.ki.TEST_TUBE_5 do
                            if not player:hasKeyItem(tube) then
                                progress = false
                            end
                        end

                        if progress then
                            quest:setVar(player, 'Prog', 2)
                        end
                    end
                end,
            },
        },

        [xi.zone.BHAFLAU_THICKETS] =
        {
            ['Mythralline_Wellspring'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.EMPTY_TEST_TUBE_5) and
                        not player:hasKeyItem(xi.ki.TEST_TUBE_5)
                    then
                        return quest:progressEvent(5)
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    if option == 0 then
                        local progress = true

                        player:delKeyItem(xi.ki.EMPTY_TEST_TUBE_5)
                        npcUtil.giveKeyItem(player, xi.ki.TEST_TUBE_5)

                        -- Progress to section 2 if all test tubes found
                        for tube = xi.ki.TEST_TUBE_1, xi.ki.TEST_TUBE_5 do
                            if not player:hasKeyItem(tube) then
                                progress = false
                            end
                        end

                        if progress then
                            quest:setVar(player, 'Prog', 2)
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
                vars.Prog >= 2
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Nafiwaa'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(5038, { text_table = 0, })
                    end
                end,
            },

            ['Abquhbah'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:event(5034, { text_table = 0 })
                    else
                        return quest:event(5033, { text_table = 0 })
                    end
                end,
            },

            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Stage') <= VanadielUniqueDay() and
                        quest:getVar(player, 'Prog') == 3 and
                        quest:getMustZone(player)
                    then
                        return quest:progressEvent(5031, { text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [5031] = function(player, csid, option, npc)
                    local score = quest:getVar(player, 'Score')

                    if score == 1 then
                        quest.reward.item = xi.items.IMPERIAL_GOLD_PIECE
                    elseif score == 2 then
                        quest.reward.item = { xi.items.IMPERIAL_GOLD_PIECE, 2 }
                    end

                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SP_WILDCAT_BADGE)
                        player:setCharVar("AssaultPromotion", 0)
                        player:messageSpecial(ID.text.LC_PROMOTION)
                    end
                end,

                [5038] = function(player, csid, option, npc)
                    -- Throwaway: Option == 1073741839
                    if option ~= 1073741839 then
                        quest:setVar(player, 'Stage', VanadielUniqueDay())
                        quest:setVar(player, 'Prog', 3)
                        quest:setMustZone(player)

                        if option == 2147483990 then -- Platinum
                            quest:setVar(player, 'Score', 1)
                        elseif option == 2147483816 then -- Luminium
                            quest:setVar(player, 'Score', 2)
                        end
                    end
                end,
            },
        },
    },
}

return quest
