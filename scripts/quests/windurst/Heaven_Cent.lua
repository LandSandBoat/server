-----------------------------------
-- Heaven Cent
-----------------------------------
-- !addquest 2 49
-- Mashuu-Ajuu 130 -5 167
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------
ID = require('scripts/zones/Maze_of_Shakhrami/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.HEAVEN_CENT)

local incorrect =
{
    ID.text.SHIVA_WEST,
    ID.text.LEAVIATHAN_SOUTH,
    ID.text.TITAN_NORTH,
    ID.text.ODIN_EAST,
}

local correct =
{
    ID.text.ALEXANDER_NE,
    ID.text.SHIVA_EAST,
    ID.text.ODIN_NORTH,
    ID.text.IFRIT_NW,
}

quest.reward =
{
    gil = 4800,
    title = xi.title.NIGHT_SKY_NAVIGATOR,
    fame = 100,
    fameArea = xi.quest.fame_area.WINDURST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.WINDURST) >= 5
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ropunono'] = quest:progressEvent(284),

            onEventFinish =
            {
                [284] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ropunono'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(289, 0, 557, 545, 0, 0, 4095, 4)
                    else
                        return quest:progressEvent(296)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if trade:hasItemQty(557, 1) and trade:getItemCount() == 1 and quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(288, 0, 557, 545, 0, 0, 0, 0, 4)

                    -- Fake Shelling Piece
                    elseif
                        trade:hasItemQty(545, 1) and
                        trade:getItemCount() == 1 and
                        quest:getVar(player, 'Prog') == 1 and
                        quest:getVar(player, 'Coin') == 0
                    then
                        return quest:progressEvent(296, 0, 0, 545, 0, 0, 0, 4095, 4)

                    -- Real Shelling Piece
                    elseif
                        trade:hasItemQty(545, 1) and
                        trade:getItemCount() == 1 and
                        quest:getVar(player, 'Prog') == 1 and
                        quest:getVar(player, 'Coin') == 1
                    then
                        return quest:progressEvent(292, 0, 0, 545, 0, 0, 0, 4095, 4)
                    end
                end,
            },

            onEventFinish =
            {
                [288] = function(player, csid, option, npc)
                    quest:setvar(player, 'Prog', 1)
                end,
                [292] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:complete(player)
                end,
                [296] = function(player, csid, option, npc)
                    -- Reset vars to allow players to search for another coin
                    quest:setVar(player, 'firstCoin', 0)
                    quest:setVar(player, 'secondCoin', 0)
                    quest:setVar(player, 'thirdCoin', 0)
                    player:tradeComplete()
                end,
            },
        },

        [xi.zone.MAZE_OF_SHAKHRAMI] =
        {
            ['_5i0'] =
            {
                onTrade = function(player, npc, trade)
                    if trade:hasItemQty(543, 1) and trade:getItemCount() == 1 and quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(41)
                    end
                end,
            },
            ['_5i4'] =
            {
                onTrigger = function(player, npc)
                    local rand = math.random()

                    -- Only allow if player doesn't have coin
                    if not player:hasItem(545) then
                        if rand > 0.2 then
                            player:messageSpecial(incorrect[math.random(1,4)])
                            return quest:progressEvent(47)

                        -- Do not reveal correct coin if player has seen correct coin from this chest.
                        elseif quest:getVar(player, 'firstCoin') == 0
                        then
                            player:messageSpecial(correct[math.random(1,4)])
                            quest:setVar(player, 'firstCoin', 1)
                            return quest:progressEvent(46)
                        end
                    else
                        player:messageSpecial(ID.text.CHEST_EMPTY)
                    end
                end,
            },
            ['_5i5'] =
            {
                onTrigger = function(player, npc)
                    local rand = math.random()

                    -- Only allow if player doesn't have coin
                    if not player:hasItem(545) then
                        if rand > 0.2 then
                            player:messageSpecial(incorrect[math.random(1,4)])
                            return quest:progressEvent(49)

                        -- Do not reveal correct coin if player has seen correct coin from this chest.
                        elseif quest:getVar(player, 'secondCoin') == 0 then
                            player:messageSpecial(correct[math.random(1,4)])
                            quest:setVar(player, 'secondCoin', 1)
                            return quest:progressEvent(48)
                        end
                    else
                        player:messageSpecial(ID.text.CHEST_EMPTY)
                    end
                end,
            },
            ['_5i6'] =
            {
                onTrigger = function(player, npc)
                    local rand = math.random()

                    -- Only allow if player doesn't have coin
                    if not player:hasItem(545) then
                        if rand > 0.2 then
                            player:messageSpecial(incorrect[math.random(1,4)])
                            return quest:progressEvent(51)

                        -- Do not reveal correct coin if player has seen correct coin from this chest.
                        elseif quest:getVar(player, 'thirdCoin') == 0 then
                            player:messageSpecial(correct[math.random(1,4)])
                            quest:setVar(player, 'thirdCoin', 1)
                            return quest:progressEvent(50)
                        end
                    else
                        player:messageSpecial(ID.text.CHEST_EMPTY)
                    end
                end,
            },

            onEventFinish =
            {
                -- Correct coin
                [46] = function(player, csid, option, npc)
                    if option == 2 then
                        if player:getFreeSlotsCount() == 0 then
                            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.CARBUNCLES_POLE)
                        else
                            quest:setVar(player, 'Coin', 1)
                            player:addItem(545)
                        end
                    end
                end,
                -- Incorrect coin
                [47] = function(player, csid, option, npc)
                    if option == 2 then
                        if player:getFreeSlotsCount() == 0 then
                            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.CARBUNCLES_POLE)
                        else
                            quest:setVar(player, 'Coin', 0)
                            player:addItem(545)
                        end
                    end
                end,
                -- Correct coin
                [48] = function(player, csid, option, npc)
                    if option == 2 then
                        if player:getFreeSlotsCount() == 0 then
                            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.CARBUNCLES_POLE)
                        else
                            quest:setVar(player, 'Coin', 1)
                            player:addItem(545)
                        end
                    end
                end,
                -- Inorrect coin
                [49] = function(player, csid, option, npc)
                    if option == 2 then
                        if player:getFreeSlotsCount() == 0 then
                            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.CARBUNCLES_POLE)
                        else
                            quest:setVar(player, 'Coin', 0)
                            player:addItem(545)
                        end
                    end
                end,
                -- Correct coin
                [50] = function(player, csid, option, npc)
                    if option == 2 then
                        if player:getFreeSlotsCount() == 0 then
                            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.CARBUNCLES_POLE)
                        else
                            quest:setVar(player, 'Coin', 1)
                            player:addItem(545)
                        end
                    end
                end,
                -- Incorrect coin
                [51] = function(player, csid, option, npc)
                    if option == 2 then
                        if player:getFreeSlotsCount() == 0 then
                            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.CARBUNCLES_POLE)
                        else
                            quest:setVar(player, 'Coin', 0)
                            player:addItem(545)
                        end
                    end
                end,
            },
        },
    },
}

return quest
