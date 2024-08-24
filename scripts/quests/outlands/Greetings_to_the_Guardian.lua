-----------------------------------
-- Greetings to the Guardians
-----------------------------------
-- Log ID: 5, Quest ID: 2
-- Hari Pakhroib  : !gotoid 17801274
-- Altar of Ashes : !gotoid 17617209
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.GREETINGS_TO_THE_GUARDIAN)

local cauldronID = zones[xi.zone.IFRITS_CAULDRON]

quest.reward =
{
    fame     = 100,
    fameArea = xi.fameArea.WINDURST,
    gil      = 5000,
    title    = xi.title.KAZHAM_CALLER,
}

local function handleAltarTrade(player, trade, itemId)
    if npcUtil.tradeHasExactly(trade, itemId) then
        if quest:getVar(player, 'Prog') == 0 then
            quest:setVar(player, 'Prog', 1)
            player:tradeComplete()
            return player:messageSpecial(cauldronID.text.ALTAR_OFFERING, 0, itemId)
        else
            return player:messageSpecial(cauldronID.text.ALTAR_COMPLETED)
        end
    end
end

local function handleAltarTrigger(player)
    local questProg = quest:getVar(player, 'Prog')
    if questProg == 0 then
        return player:messageSpecial(cauldronID.text.ALTAR_INSPECT)
    elseif questProg == 1 then
        return player:messageSpecial(cauldronID.text.ALTAR_COMPLETED)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 7
        end,

        [xi.zone.KAZHAM] =
        {
            ['Hari_Pakhroib'] = quest:progressEvent(68, 0, xi.item.BUNCH_OF_WILD_PAMAMAS, xi.item.ICE_CLUSTER),

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
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.KAZHAM] =
        {
            ['Hari_Pakhroib'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(69, 0, xi.item.BUNCH_OF_WILD_PAMAMAS)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(71)
                    end
                end
            },

            ['Khaffi_Salponoihz'] = quest:event(70, 0, 0, xi.item.ICE_CLUSTER),

            onEventFinish =
            {
                [71] = function(player, csid, option, npc)
                    quest:complete(player)
                    quest:setVar(player, 'zone', 1)
                end,
            },
        },

        [xi.zone.IFRITS_CAULDRON] =
        {
            ['Altar_of_Ashes'] =
            {
                onTrade = function(player, npc, trade)
                    handleAltarTrade(player, trade, xi.item.BUNCH_OF_WILD_PAMAMAS)
                end,

                onTrigger = function(player, npc)
                    handleAltarTrigger(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.KAZHAM] =
        {
            ['Hari_Pakhroib'] =
            {
                onTrigger = function(player, npc)
                    if not player:needToZone() then
                        local questProg = quest:getVar(player, 'Prog')
                        local questRepeat = quest:getVar(player, 'Repeat')

                        if questRepeat == 0 then -- Choosing repeat item to trade to Altar.
                            local itemOffering = math.random(1, 3)

                            if itemOffering == 1 then
                                quest:setVar(player, 'Repeat', itemOffering) -- setting vars here instead of eventfinish due to CS message needing selected during event 68
                                return quest:event(68, 0, xi.item.BUNCH_OF_WILD_PAMAMAS, xi.item.ICE_CLUSTER)
                            elseif itemOffering == 2 then
                                quest:setVar(player, 'Repeat', itemOffering)
                                return quest:event(68, 0, xi.item.WILD_MELON, xi.item.ICE_CLUSTER)
                            elseif itemOffering == 3 then
                                quest:setVar(player, 'Repeat', itemOffering)
                                return quest:event(68, 0, xi.item.WILD_PINEAPPLE, xi.item.ICE_CLUSTER)
                            end
                        elseif questProg == 0 then -- Reminder Message for repeat quest
                            if questRepeat == 1 then
                                return quest:event(69, 0, xi.item.BUNCH_OF_WILD_PAMAMAS)
                            elseif questRepeat == 2 then
                                return quest:event(69, 0, xi.item.WILD_MELON)
                            elseif questRepeat == 3 then
                                return quest:event(69, 0, xi.item.WILD_PINEAPPLE)
                            end
                        else -- Complete
                            return quest:progressEvent(71)
                        end
                    end
                end,
            },

            ['Khaffi_Salponoihz'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Zone') == 1 then
                        quest:event(73)
                    end
                end
            },

            onEventFinish =
            {
                [71] = function(player, csid, option, npc)
                    npcUtil.giveCurrency(player, 'gil', xi.settings.main.GIL_RATE * 5000)
                    player:addFame(xi.fameArea.WINDURST, 30)
                    quest:setVar(player, 'Prog', 0)
                    quest:setVar(player, 'Repeat', 0)
                    quest:setVar(player, 'Zone', 1)
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    quest:setVar(player, 'Zone', 0)
                end,
            },
        },

        [xi.zone.IFRITS_CAULDRON] =
        {
            ['Altar_of_Ashes'] =
            {
                onTrade = function(player, npc, trade)
                    local questRepeat = quest:getVar(player, 'Repeat')
                    if questRepeat == 1 then
                        handleAltarTrade(player, trade, xi.item.BUNCH_OF_WILD_PAMAMAS)
                    elseif questRepeat == 2 then
                        handleAltarTrade(player, trade, xi.item.WILD_MELON)
                    elseif questRepeat == 3 then
                        handleAltarTrade(player, trade, xi.item.WILD_PINEAPPLE)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Repeat') ~= 0 then
                        handleAltarTrigger(player)
                    end
                end,
            },
        },
    },
}

return quest
