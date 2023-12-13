-----------------------------------
-- Greetings to the Guardians
-----------------------------------
-- Log ID: 5, Quest ID: 2
-- Hari Pakhroib: !gotoid 17801274
-- Altar of Ashes: !gotoid 17617208
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.GREETINGS_TO_THE_GUARDIAN)

local ID = require("scripts/zones/Ifrits_Cauldron/IDs")

quest.reward =
{
    fameArea = xi.quest.fame_area.WINDURST,
    fame     = 100,
    gil      = 5000,
    title    = xi.title.KAZHAM_CALLER,
}
quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.WINDURST) >= 7
        end,

        [xi.zone.KAZHAM] =
        {
            ['Hari_Pakhroib'] = quest:progressEvent(68, xi.items.BUNCH_OF_WILD_PAMAMAS, xi.items.BUNCH_OF_WILD_PAMAMAS, xi.items.ICE_CLUSTER),

            onEventFinish =
            {
                [68] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE and
            not player:needToZone()
        end,

        [xi.zone.KAZHAM] =
        {
            ['Hari_Pakhroib'] =
            {
                onTrigger = function(player, npc)
                if not player:hasCompletedQuest(quest.areaId, quest.questId) then -- First time doing quest
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(69, 0, xi.items.BUNCH_OF_WILD_PAMAMAS)
                    elseif quest:getVar(player, 'Prog') >= 1 then
                        return quest:progressEvent(71)
                    end
                elseif quest:getVar(player, 'Repeat') == 0 then -- Choosing repeat item to trade to Altar.
                    local itemOffering = math.random(1, 3)
                        if itemOffering == 1 then
                            quest:setVar(player, 'Repeat', 1) -- setting vars here instead of eventfinish due to CS message needing selected during event 68
                            return quest:event(68, xi.items.BUNCH_OF_WILD_PAMAMAS, xi.items.BUNCH_OF_WILD_PAMAMAS, xi.items.ICE_CLUSTER)
                        elseif itemOffering == 2 then
                            quest:setVar(player, 'Repeat', 2)
                            return quest:event(68, xi.items.WILD_MELON, xi.items.WILD_MELON, xi.items.ICE_CLUSTER)
                        elseif itemOffering == 3 then
                            quest:setVar(player, 'Repeat', 3)
                            return quest:event(68, xi.items.WILD_PINEAPPLE, xi.items.WILD_PINEAPPLE, xi.items.ICE_CLUSTER)
                        end
                    elseif quest:getVar(player, 'Prog') == 0 then -- Reminder Message for repeat quest
                        if quest:getVar(player, 'Repeat') == 1 then
                            return quest:event(69, 0, xi.items.BUNCH_OF_WILD_PAMAMAS)
                        elseif quest:getVar(player, 'Repeat') == 2 then
                            return quest:event(69, 0, xi.items.WILD_MELON)
                        elseif quest:getVar(player, 'Repeat') == 3 then
                            return quest:event(69, 0, xi.items.WILD_PINEAPPLE)
                        end
                    elseif quest:getVar(player, 'Prog') == 1 then -- Turn in of repeat quest
                        if quest:getVar(player, 'Repeat') >= 1 then
                            return quest:progressEvent(71)
                        end
                    end
                end,
            },

            ['Khaffi_Salponoihz'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 0 then
                        return quest:event(70, 0, 0, xi.items.ICE_CLUSTER)
                    end
                end,
            },

            onEventFinish =
            {
                [71] = function(player, csid, option, npc)
                    if not player:hasCompletedQuest(quest.areaId, quest.questId) then
                        quest:complete(player)
                        player:needToZone(true)
                    else
                        player:addFame(xi.quest.fame_area.WINDURST, 30)
                        npcUtil.giveCurrency(player, "gil", xi.settings.main.GIL_RATE * 5000)
                        quest:setVar(player, 'Prog', 0)
                        quest:setVar(player, 'Repeat', 0)
                        player:needToZone(true)
                    end
                end,
            },
        },

        [xi.zone.IFRITS_CAULDRON] =
        {
            ['Altar_of_Ashes'] =
            {
                onTrade = function(player, npc, trade)
                    if not player:hasCompletedQuest(quest.areaId, quest.questId) then -- first time through quest
                        if npcUtil.tradeHasExactly(trade, xi.items.BUNCH_OF_WILD_PAMAMAS) then
                            if quest:getVar(player, 'Prog') == 0 then
                                player:tradeComplete()
                                quest:setVar(player, 'Prog', 1)
                                return quest:messageSpecial(ID.text.ALTAR_OFFERING, 0, xi.items.BUNCH_OF_WILD_PAMAMAS)
                            elseif quest:getVar(player, 'Prog') == 1 then
                                return quest:messageSpecial(ID.text.ALTAR_COMPLETED)
                            end
                        end
                    elseif quest:getVar(player, 'Prog') == 0 then -- repeat quest attempts.
                        if quest:getVar(player, 'Repeat') == 1 then
                            if npcUtil.tradeHasExactly(trade, xi.items.BUNCH_OF_WILD_PAMAMAS) then
                                quest:setVar(player, 'Prog', 1)
                                player:tradeComplete()
                                return quest:messageSpecial(ID.text.ALTAR_OFFERING, 0, xi.items.BUNCH_OF_WILD_PAMAMAS)
                            end
                        elseif quest:getVar(player, 'Repeat') == 2 then
                            if npcUtil.tradeHasExactly(trade, xi.items.WILD_MELON) then
                                quest:setVar(player, 'Prog', 1)
                                player:tradeComplete()
                                return quest:messageSpecial(ID.text.ALTAR_OFFERING, 0, xi.items.WILD_MELON)
                            end
                        elseif quest:getVar(player, 'Repeat') == 3 then
                            if npcUtil.tradeHasExactly(trade, xi.items.WILD_PINEAPPLE) then
                                quest:setVar(player, 'Prog', 1)
                                player:tradeComplete()
                                return quest:messageSpecial(ID.text.ALTAR_OFFERING, 0, xi.items.WILD_PINEAPPLE)
                            end
                        end
                    elseif quest:getVar(player, 'Prog') == 1 then -- turned in required item already
                        return quest:messageSpecial(ID.text.ALTAR_COMPLETED)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then -- default messaging while on quest or on repeats
                        return quest:messageSpecial(ID.text.ALTAR_INSPECT):replaceDefault()
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:messageSpecial(ID.text.ALTAR_COMPLETED):replaceDefault()
                    end
                end,
            },
        },
    },
}

return quest
