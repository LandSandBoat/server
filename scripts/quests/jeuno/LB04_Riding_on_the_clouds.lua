-----------------------------------
-- Riding on the Clouds
-----------------------------------
-- Log ID: 3, Quest ID: 131
-- Maat : !pos 8 3 118 243
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require('scripts/globals/interaction/quest')
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS)
-----------------------------------

local function handleSandoriaTrade(player)
    if npcUtil.tradeHasExactly(trade, {xi.items.KINDREDS_SEAL} then
        quest:setVar(player, 'npcTradeSandoria', 9)
        player:tradeComplete()
        npcUtil.giveKeyItem(player, xi.ki.SCOWLING_STONE_STONE)
    end
end

local function handleBastokTrade(player)
    if npcUtil.tradeHasExactly(trade, {xi.items.KINDREDS_SEAL} then
        quest:setVar(player, 'npcTradeBastok', 9)
        player:tradeComplete()
        npcUtil.giveKeyItem(player, xi.ki.SMILING_STONE)
    end
end

local function handleWindurstTrade(player)
    if npcUtil.tradeHasExactly(trade, {xi.items.KINDREDS_SEAL} then
        quest:setVar(player, 'npcTradeWindurst', 9)
        player:tradeComplete()
        npcUtil.giveKeyItem(player, xi.ki.SPIRITED_STONE)
    end
end

local function handleOtherlandsTrade(player)
    if npcUtil.tradeHasExactly(trade, {xi.items.KINDREDS_SEAL} then
        quest:setVar(player, 'npcTradeOtherlands', 9)
        player:tradeComplete()
        npcUtil.giveKeyItem(player, xi.ki.SOMBER_STONE)
    end
end

quest.reward =
{
    fame  = 60,
    fameArea = JEUNO,
    title = xi.title.CLOUD_BREAKER,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 61 and
                player:getLevelCap() == 65 and
                xi.settings.MAX_LEVEL >= 70
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] =
            {
                onTrigger = function(player, npc)
                    local npcSandoria = math.random(0, 7)
                    local npcBastok   = math.random(0, 7)
                    local npcWindurst = math.random(0, 7)
                    local npcOtherlands = math.random(0, 7)
                    quest:setVar(player, 'npcTradeSandoria', npcSandoria + 1)
                    quest:setVar(player, 'npcTradeBastok', npcBastok + 1)
                    quest:setVar(player, 'npcTradeWindurst', npcWindurst + 1)
                    quest:setVar(player, 'npcTradeOtherlands', npcOtherlands + 1)
                    return quest:progressEvent(88, npcSandoria, npcBastok, npcWindurst, npcOtherlands, 180)
                end,
            },

            onEventFinish =
            {
                [88] = function(player, csid, option, npc)

                    if option ==  1 then -- Accept quest option.
                        quest:begin(player)
                    else
                        quest:setVar(player, 'npcTradeSandoria', 0)
                        quest:setVar(player, 'npcTradeBastok', 0)
                        quest:setVar(player, 'npcTradeWindurst', 0)
                        quest:setVar(player, 'npcTradeOtherlands', 0)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SMILING_STONE) and player:hasKeyItem(xi.ki.SCOWLING_STONE) and player:hasKeyItem(xi.ki.SOMBER_STONE) and player:hasKeyItem(xi.ki.SPIRITED_STONE) then
                        return quest:progressEvent(90) -- Finish Quest "Riding on the Clouds"
                    else
                        local npcSandoria = quest:getVar(player, 'npcTradeSandoria') - 1
                        local npcBastok   = quest:getVar(player, 'npcTradeBastok') - 1
                        local npcWindurst = quest:getVar(player, 'npcTradeWindurst') - 1
                        local npcOtherlands = quest:getVar(player, 'npcTradeOtherlands') - 1
                        return quest:event(89, npcSandoria, npcBastok, npcWindurst, npcOtherlands, 180) -- NPC reminder.
                    end
                end,
            },

            onEventFinish =
            {
                [90] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SCOWLING_STONE)
                        player:delKeyItem(xi.ki.SMILING_STONE)
                        player:delKeyItem(xi.ki.SOMBER_STONE)
                        player:delKeyItem(xi.ki.SPIRITED_STONE)
                        player:setLevelCap(70)
                        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_70)
                    end
                end,
            },
        },

        -- San d'Oria Zones and NPCs
        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Raminel'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeSandoria') == 1 then
                        handleSandoriaTrade(player)
                    end
                end,
            },
            ['Sobane'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeSandoria') == 2 then
                        handleSandoriaTrade(player)
                    end
                end,
            },
        },
        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Taurette'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeSandoria') == 3 then
                        handleSandoriaTrade(player)
                    end
                end,
            },
            ['Maloquedil'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeSandoria') == 4 then
                        handleSandoriaTrade(player)
                    end
                end,
            },
        },
        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Sheridan'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeSandoria') == 5 then
                        handleSandoriaTrade(player)
                    end
                end,
            },
            ['Fontoumant'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeSandoria') == 6 then
                        handleSandoriaTrade(player)
                    end
                end,
            },
            ['Brifalien'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeSandoria') == 7 then
                        handleSandoriaTrade(player)
                    end
                end,
            },
            ['Rugiette'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeSandoria') == 8 then
                        handleSandoriaTrade(player)
                    end
                end,
            },
        },

        -- Bastok Zones and NPCs
        [xi.zone.BASTOK_MINES] =
        {
            ['Babenn'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 1 then
                        handleBastokTrade(player)
                    end
                end,
            },
        },
        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gwill'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 2 then
                        handleBastokTrade(player)
                    end
                end,
            },
            ['Brygid'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 3 then
                        handleBastokTrade(player)
                    end
                end,
            },
        },
        [xi.zone.PORT_BASTOK] =
        {
            ['Kaede'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 4 then
                        handleBastokTrade(player)
                    end
                end,
            },
            ['Hilda'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 5 then
                        handleBastokTrade(player)
                    end
                end,
            },
        },
        [xi.zone.METALWORKS] =
        {
            ['Naji'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 6 then
                        handleBastokTrade(player)
                    end
                end,
            },
            ['Raibaht'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 7 then
                        handleBastokTrade(player)
                    end
                end,
            },
            ['Lucius'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 8 then
                        handleBastokTrade(player)
                    end
                end,
            },
        },

        -- Windurst Zones and NPCs
        [xi.zone.WINDURST_WATERS] =
        {
            ['Koko_Lihzeh'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 1 then
                        handleWindurstTrade(player)
                    end
                end,
            },
            ['Naiko-Paneiko'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 2 then
                        handleWindurstTrade(player)
                    end
                end,
            },
            ['Kerutoto'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 3 then
                        handleWindurstTrade(player)
                    end
                end,
            },
        },
        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 4 then
                        handleWindurstTrade(player)
                    end
                end,
            },
        },
        [xi.zone.PORT_WINDURST] =
        {
            ['Shanruru'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 5 then
                        handleWindurstTrade(player)
                    end
                end,
            },
        },
        [xi.zone.WINDURST_WOODS] =
        {
            ['Boizo-Naizo'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 6 then
                        handleWindurstTrade(player)
                    end
                end,
            },
            ['Sola_Jaab'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 7 then
                        handleWindurstTrade(player)
                    end
                end,
            },
        },
        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeBastok') == 8 then
                        handleWindurstTrade(player)
                    end
                end,
            },
        },

        -- Otherlands (Selbina and Mhaura) Zones and NPCs
        [xi.zone.SELBINA] =
        {
            ['Mathilde'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeOtherlands') == 1 then
                        handleOtherlandsTrade(player)
                    end
                end,
            },
            ['Vobo'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeOtherlands') == 2 then
                        handleOtherlandsTrade(player)
                    end
                end,
            },
            ['Melyon'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeOtherlands') == 3 then
                        handleOtherlandsTrade(player)
                    end
                end,
            },
            ['Gabwaleid'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeOtherlands') == 4 then
                        handleOtherlandsTrade(player)
                    end
                end,
            },
        },
        [xi.zone.MHAURA] =
        {
            ['Celestina'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeOtherlands') == 5 then
                        handleOtherlandsTrade(player)
                    end
                end,
            },
            ['Ekokoko'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeOtherlands') == 6 then
                        handleOtherlandsTrade(player)
                    end
                end,
            },
            ['Bihoro-Guhoro'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeOtherlands') == 7 then
                        handleOtherlandsTrade(player)
                    end
                end,
            },
            ['Jikka-Abukka'] =
            {
                onTrade = function(player, npc)
                    if quest:getVar(player, 'npcTradeOtherlands') == 8 then
                        handleOtherlandsTrade(player)
                    end
                end,
            },
        },
    },
}

return quest
