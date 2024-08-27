-----------------------------------
-- Say It With Flowers
-----------------------------------
-- Log ID: 2, Quest ID: 50
-- Moari-Kaaori   : !pos -253 -5 -227 238
-- Kenapa-Keppa   : !pos 27 -6 -199 238
-- Ohbiru-Dohbiru : !pos 23 -5 -193 238
-- Tahrongi Cacti : !pos -308 7 264 117
-----------------------------------
local windurstWatersIDs = zones[xi.zone.WINDURST_WATERS]
local tahrongiID = zones[xi.zone.TAHRONGI_CANYON]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)

quest.reward = { }

local flowerList =
{
    [0] = { itemId = xi.item.CARNATION,  cost = 300 },
    [1] = { itemId = xi.item.RED_ROSE,   cost = 200 },
    [2] = { itemId = xi.item.RAIN_LILY,  cost = 250 },
    [3] = { itemId = xi.item.LILAC,      cost = 150 },
    [4] = { itemId = xi.item.AMARYLLIS,  cost = 200 },
    [5] = { itemId = xi.item.MARGUERITE, cost = 100 },
}

local function ohbiruFlowerHelp(player, option)
    if option < 7 then
        local choice = flowerList[option]
        if
            choice and
            player:getGil() >= choice.cost
        then
            if npcUtil.giveItem(player, choice.itemId) then -- Sells player wrong flower
                player:delGil(choice.cost)
            else
                player:messageSpecial(windurstWatersIDs.text.ITEM_CANNOT_BE_OBTAINED, choice.itemId)
            end
        else
            player:messageSpecial(windurstWatersIDs.text.NOT_HAVE_ENOUGH_GIL)
        end
    elseif option == 7 then -- Cactus Message
        quest:setVar(player, 'CactusHint', 1)
    end

    quest:incrementVar(player, 'Prog', 1)
end

local function completeQuest(player, fame, title, gil)
    player:tradeComplete()
    quest.reward =
    {
        fame     = fame,
        fameArea = xi.fameArea.WINDURST,
        title    = title,
    }
    player:addGil(gil) -- gil reward is silent on first runthrough/handled by CS during repeats
    quest:complete(player)
    quest:setMustZone(player)
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return player:getFameLevel(xi.fameArea.WINDURST) >= 2 and
                status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moari-Kaaori'] = quest:progressEvent(514),

            onEventFinish =
            {
                [514] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'CactusAvailable', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moari-Kaaori'] =
            {
                onTrade = function(player, npc, trade) -- player can turn in at any time after starting
                    local flowers = {
                        xi.item.CARNATION, xi.item.RED_ROSE, xi.item.RAIN_LILY,
                        xi.item.LILAC, xi.item.AMARYLLIS, xi.item.MARGUERITE,
                    }
                    if npcUtil.tradeHasExactly(trade, { xi.item.TAHRONGI_CACTUS }) then
                        return quest:progressEvent(520)
                    elseif
                        trade:getItemCount() == 1 and
                        npcUtil.tradeSetInList(trade, flowers)
                    then
                        player:startEvent(522) -- Brought wrong flowers.
                    end
                end,

                onTrigger = quest:event(515),
            },

            onEventFinish =
            {
                [520] = function(player, csid, option, npc) -- Right flower, full reward
                    if npcUtil.giveItem(player, xi.item.IRON_SWORD) then
                        completeQuest(player, 30, xi.title.CUPIDS_FLORIST, xi.settings.main.GIL_RATE * 400)
                    end
                end,

                [522] = function(player, csid, option, npc) -- Wrong flower, smaller reward
                    completeQuest(player, 10, nil, xi.settings.main.GIL_RATE * 100)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                quest:getVar(player, 'Prog') == 0
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] = quest:progressEvent(516, { [4] = xi.item.TAHRONGI_CACTUS }),

            onEventFinish =
            {
                [516] = function(player, csid, option, npc)
                    ohbiruFlowerHelp(player, option) -- only offered once per runthrough
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                quest:getVar(player, 'Prog') ~= 0
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kenapa-Keppa'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'CactusHint') == 1 then
                        return quest:progressEvent(519)
                    end
                end
            },

            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'CactusHint') == 1 then
                        return quest:progressEvent(517, { [4] = xi.item.TAHRONGI_CACTUS })
                    else
                        return quest:progressEvent(518)
                    end
                end
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moari-Kaaori'] = quest:progressEvent(521),
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                quest:getVar(player, 'Prog') == 0 and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moari-Kaaori'] = quest:progressEvent(685, 0, xi.item.TAHRONGI_CACTUS),

            onEventFinish =
            {
                [685] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    quest:setVar(player, 'CactusAvailable', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                quest:getVar(player, 'Prog') ~= 0
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moari-Kaaori'] =
            {
                onTrade = function(player, npc, trade) -- player can turn in at any time after starting
                    local flowers = {
                        xi.item.CARNATION, xi.item.RED_ROSE, xi.item.RAIN_LILY,
                        xi.item.LILAC, xi.item.AMARYLLIS, xi.item.MARGUERITE,
                    }
                    if npcUtil.tradeHasExactly(trade, { xi.item.TAHRONGI_CACTUS }) then
                        return quest:progressEvent(525, xi.settings.main.GIL_RATE * 400)
                    elseif
                        trade:getItemCount() == 1 and
                        npcUtil.tradeSetInList(trade, flowers)
                    then
                        player:startEvent(522, xi.settings.main.GIL_RATE * 100) -- Brought wrong flowers.
                    end
                end,

                onTrigger = quest:event(515),
            },

            onEventFinish =
            {
                [522] = function(player, csid, option, npc) -- Wrong flower, smaller reward
                    completeQuest(player, 10, nil, xi.settings.main.GIL_RATE * 100)
                end,

                [525] = function(player, csid, option, npc) -- Repeatable rewards
                    completeQuest(player, 30, xi.title.CUPIDS_FLORIST, xi.settings.main.GIL_RATE * 400)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                quest:getVar(player, 'Prog') == 1
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] = quest:progressEvent(516, { [4] = xi.item.TAHRONGI_CACTUS }),

            onEventFinish =
            {
                [516] = function(player, csid, option, npc)
                    ohbiruFlowerHelp(player, option) -- only offered once per runthrough
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                quest:getVar(player, 'Prog') > 1
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kenapa-Keppa'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'CactusHint') == 1 then
                        quest:progressEvent(519)
                    end
                end
            },

            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'CactusHint') == 1 then
                        quest:progressEvent(517, { [4] = xi.item.TAHRONGI_CACTUS })
                    else
                        quest:progressEvent(518)
                    end
                end
            },
        },
    },

    {
        check = function(player, status, vars)
            return status >= xi.questStatus.QUEST_ACCEPTED and
                quest:getVar(player, 'CactusAvailable') == 1
        end,

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Tahrongi_Cacti'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasItem(xi.item.TAHRONGI_CACTUS) then
                        npcUtil.giveItem(player, xi.item.TAHRONGI_CACTUS)
                    else
                        player:messageSpecial(tahrongiID.text.CANT_TAKE_ANY_MORE)
                    end
                end,
            },
        },
    },
}

return quest
