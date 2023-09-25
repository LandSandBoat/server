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
local ID = require('scripts/zones/Maze_of_Shakhrami/IDs')
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
            return status == QUEST_ACCEPTED and
            vars.Prog == 0
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ropunono'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.AHRIMAN_LENS) then
                        return quest:progressEvent(288, 0, xi.items.AHRIMAN_LENS, xi.items.SHELLING_PIECE)
                    end
                end,
            },

            onEventFinish =
            {
                [288] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
            vars.Prog == 1
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ropunono'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(289, 0, xi.items.AHRIMAN_LENS, xi.items.SHELLING_PIECE)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SHELLING_PIECE) then
                        if quest:getVar(player, 'Coin') == 1 then
                            -- Real Shelling Piece
                            return quest:progressEvent(292, 0, 0, xi.items.SHELLING_PIECE)
                        else
                            -- Fake Shelling Piece
                            return quest:progressEvent(296, 0, 0, xi.items.SHELLING_PIECE)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [292] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:complete(player)
                end,

                [296] = function(player, csid, option, npc)
                    -- Reset vars to allow players to search for another coin
                    quest:setVar(player, 'firstCoin', 0)
                    quest:setVar(player, 'secondCoin', 0)
                    quest:setVar(player, 'thirdCoin', 0)
                    player:confirmTrade()
                end,
            },
        },

        [xi.zone.MAZE_OF_SHAKHRAMI] =
        {
            -- Iron Door
            ['_5i0'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.RUSTY_KEY) then
                        return quest:progressEvent(41)
                    end
                end,

                onTrigger = function(player, npc)
                    if player:getPos().x >= 248 then
                        return quest:progressEvent(42)
                    end
                end,
            },

            -- Chests
            ['_5i4'] =
            {
                onTrigger = function(player, npc)
                    local rand = math.random()

                    -- Only allow if player doesn't have coin
                    if not player:hasItem(xi.items.SHELLING_PIECE) then
                        if rand > 0.2 then
                            player:messageSpecial(incorrect[math.random(1, 4)])
                            return quest:progressEvent(47)

                        -- Do not reveal correct coin if player has seen correct coin from this chest.
                        elseif quest:getVar(player, 'firstCoin') == 0 then
                            player:messageSpecial(correct[math.random(1, 4)])
                            quest:setVar(player, 'firstCoin', 1)
                            return quest:progressEvent(46)
                        end
                    else
                        return quest:messageSpecial(ID.text.CHEST_EMPTY)
                    end
                end,
            },

            ['_5i5'] =
            {
                onTrigger = function(player, npc)
                    local rand = math.random()

                    -- Only allow if player doesn't have coin
                    if not player:hasItem(xi.items.SHELLING_PIECE) then
                        if rand > 0.2 then
                            player:messageSpecial(incorrect[math.random(1, 4)])
                            return quest:progressEvent(49)

                        -- Do not reveal correct coin if player has seen correct coin from this chest.
                        elseif quest:getVar(player, 'secondCoin') == 0 then
                            player:messageSpecial(correct[math.random(1, 4)])
                            quest:setVar(player, 'secondCoin', 1)
                            return quest:progressEvent(48)
                        end
                    else
                        return quest:messageSpecial(ID.text.CHEST_EMPTY)
                    end
                end,
            },

            ['_5i6'] =
            {
                onTrigger = function(player, npc)
                    local rand = math.random()

                    -- Only allow if player doesn't have coin
                    if not player:hasItem(xi.items.SHELLING_PIECE) then
                        if rand > 0.2 then
                            player:messageSpecial(incorrect[math.random(1, 4)])
                            return quest:progressEvent(51)

                        -- Do not reveal correct coin if player has seen correct coin from this chest.
                        elseif quest:getVar(player, 'thirdCoin') == 0 then
                            player:messageSpecial(correct[math.random(1, 4)])
                            quest:setVar(player, 'thirdCoin', 1)
                            return quest:progressEvent(50)
                        end
                    else
                        return quest:messageSpecial(ID.text.CHEST_EMPTY)
                    end
                end,
            },

            onEventFinish =
            {
                -- Opening iron door
                [41] = function(player, csid, option, npc)
                    player:confirmTrade()
                end,

                -- Correct coin (Flag correct coin)
                [46] = function(player, csid, option, npc)
                    if option == 1 and npcUtil.giveItem(player, xi.items.SHELLING_PIECE) then
                        quest:setVar(player, 'Coin', 1)
                    end
                end,

                [48] = function(player, csid, option, npc)
                    if option == 1 and npcUtil.giveItem(player, xi.items.SHELLING_PIECE) then
                        quest:setVar(player, 'Coin', 1)
                    end
                end,

                [50] = function(player, csid, option, npc)
                    if option == 1 and npcUtil.giveItem(player, xi.items.SHELLING_PIECE) then
                        quest:setVar(player, 'Coin', 1)
                    end
                end,

                -- Inorrect coin
                [49] = function(player, csid, option, npc)
                    if option == 2 then
                        npcUtil.giveItem(player, xi.items.SHELLING_PIECE)
                    end
                end,

                [47] = function(player, csid, option, npc)
                    if option == 2 then
                        npcUtil.giveItem(player, xi.items.SHELLING_PIECE)
                    end
                end,

                [51] = function(player, csid, option, npc)
                    if option == 2 then
                        npcUtil.giveItem(player, xi.items.SHELLING_PIECE)
                    end
                end,
            },
        },
    },
}

return quest
