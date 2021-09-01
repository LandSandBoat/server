-----------------------------------
-- Riding on the Clouds
-----------------------------------
-- Log ID: 3, Quest ID: 131
-- Maat : !pos 8 3 118 243
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require('scripts/globals/interaction/quest')
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS)
-----------------------------------

local function handleSandoriaTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, {xi.items.KINDREDS_SEAL}) then
        quest:setVar(player, 'npcSandoria', 9)
        player:tradeComplete()
        npcUtil.giveKeyItem(player, xi.ki.SCOWLING_STONE)
    end
end

local function handleBastokTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, {xi.items.KINDREDS_SEAL}) then
        quest:setVar(player, 'npcBastok', 9)
        player:tradeComplete()
        npcUtil.giveKeyItem(player, xi.ki.SMILING_STONE)
    end
end

local function handleWindurstTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, {xi.items.KINDREDS_SEAL}) then
        quest:setVar(player, 'npcWindurst', 9)
        player:tradeComplete()
        npcUtil.giveKeyItem(player, xi.ki.SPIRITED_STONE)
    end
end

local function handleOtherlandsTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, {xi.items.KINDREDS_SEAL}) then
        quest:setVar(player, 'npcOtherlands', 9)
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
                    local npcSandoria   = math.random(0, 7)
                    local npcBastok     = math.random(0, 7)
                    local npcWindurst   = math.random(0, 7)
                    local npcOtherlands = math.random(0, 7)
                    quest:setVar(player, 'npcSandoria', npcSandoria + 1)
                    quest:setVar(player, 'npcBastok', npcBastok + 1)
                    quest:setVar(player, 'npcWindurst', npcWindurst + 1)
                    quest:setVar(player, 'npcOtherlands', npcOtherlands + 1)
                    return quest:progressEvent(88, npcSandoria, npcBastok, npcWindurst, npcOtherlands, 180)
                end,
            },

            onEventFinish =
            {
                [88] = function(player, csid, option, npc)

                    if option ==  1 then -- Accept quest option.
                        quest:begin(player)
                    else
                        quest:setVar(player, 'npcSandoria', 0)
                        quest:setVar(player, 'npcBastok', 0)
                        quest:setVar(player, 'npcWindurst', 0)
                        quest:setVar(player, 'npcOtherlands', 0)
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
                        local npcSandoria   = quest:getVar(player, 'npcSandoria') - 1
                        local npcBastok     = quest:getVar(player, 'npcBastok') - 1
                        local npcWindurst   = quest:getVar(player, 'npcWindurst') - 1
                        local npcOtherlands = quest:getVar(player, 'npcOtherlands') - 1
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
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcSandoria') == 1 then
                        handleSandoriaTrade(player, npc, trade)
                    end
                end,
            },
            ['Sobane'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcSandoria') == 2 then
                        handleSandoriaTrade(player, npc, trade)
                    end
                end,
            },
        },
        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Taurette'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcSandoria') == 3 then
                        handleSandoriaTrade(player, npc, trade)
                    end
                end,
            },
            ['Maloquedil'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcSandoria') == 4 then
                        handleSandoriaTrade(player, npc, trade)
                    end
                end,
            },
        },
        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Sheridan'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcSandoria') == 5 then
                        handleSandoriaTrade(player, npc, trade)
                    end
                end,
            },
            ['Fontoumant'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcSandoria') == 6 then
                        handleSandoriaTrade(player, npc, trade)
                    end
                end,
            },
            ['Brifalien'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcSandoria') == 7 then
                        handleSandoriaTrade(player, npc, trade)
                    end
                end,
            },
            ['Rugiette'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcSandoria') == 8 then
                        handleSandoriaTrade(player, npc, trade)
                    end
                end,
            },
        },

        -- Bastok Zones and NPCs
        [xi.zone.BASTOK_MINES] =
        {
            ['Babenn'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcBastok') == 1 then
                        handleBastokTrade(player, npc, trade)
                    end
                end,
            },
        },
        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gwill'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcBastok') == 2 then
                        handleBastokTrade(player, npc, trade)
                    end
                end,
            },
            ['Brygid'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcBastok') == 3 then
                        handleBastokTrade(player, npc, trade)
                    end
                end,
            },
        },
        [xi.zone.PORT_BASTOK] =
        {
            ['Kaede'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcBastok') == 4 then
                        handleBastokTrade(player, npc, trade)
                    end
                end,
            },
            ['Hilda'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcBastok') == 5 then
                        handleBastokTrade(player, npc, trade)
                    end
                end,
            },
        },
        [xi.zone.METALWORKS] =
        {
            ['Naji'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcBastok') == 6 then
                        handleBastokTrade(player, npc, trade)
                    end
                end,
            },
            ['Raibaht'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcBastok') == 7 then
                        handleBastokTrade(player, npc, trade)
                    end
                end,
            },
            ['Lucius'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcBastok') == 8 then
                        handleBastokTrade(player, npc, trade)
                    end
                end,
            },
        },

        -- Windurst Zones and NPCs
        [xi.zone.WINDURST_WATERS] =
        {
            ['Koko_Lihzeh'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcWindurst') == 1 then
                        handleWindurstTrade(player, npc, trade)
                    end
                end,
            },
            ['Naiko-Paneiko'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcWindurst') == 2 then
                        handleWindurstTrade(player, npc, trade)
                    end
                end,
            },
            ['Kerutoto'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcWindurst') == 3 then
                        handleWindurstTrade(player, npc, trade)
                    end
                end,
            },
        },
        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcWindurst') == 4 then
                        handleWindurstTrade(player, npc, trade)
                    end
                end,
            },
        },
        [xi.zone.PORT_WINDURST] =
        {
            ['Shanruru'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcWindurst') == 5 then
                        handleWindurstTrade(player, npc, trade)
                    end
                end,
            },
        },
        [xi.zone.WINDURST_WOODS] =
        {
            ['Boizo-Naizo'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcWindurst') == 6 then
                        handleWindurstTrade(player, npc, trade)
                    end
                end,
            },
            ['Sola_Jaab'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcWindurst') == 7 then
                        handleWindurstTrade(player, npc, trade)
                    end
                end,
            },
        },
        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcWindurst') == 8 then
                        handleWindurstTrade(player, npc, trade)
                    end
                end,
            },
        },

        -- Otherlands (Selbina and Mhaura) Zones and NPCs
        [xi.zone.SELBINA] =
        {
            ['Mathilde'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcOtherlands') == 1 then
                        handleOtherlandsTrade(player, npc, trade)
                    end
                end,
            },
            ['Vobo'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcOtherlands') == 2 then
                        handleOtherlandsTrade(player, npc, trade)
                    end
                end,
            },
            ['Melyon'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcOtherlands') == 3 then
                        handleOtherlandsTrade(player, npc, trade)
                    end
                end,
            },
            ['Gabwaleid'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcOtherlands') == 4 then
                        handleOtherlandsTrade(player, npc, trade)
                    end
                end,
            },
        },
        [xi.zone.MHAURA] =
        {
            ['Celestina'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcOtherlands') == 5 then
                        handleOtherlandsTrade(player, npc, trade)
                    end
                end,
            },
            ['Ekokoko'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcOtherlands') == 6 then
                        handleOtherlandsTrade(player, npc, trade)
                    end
                end,
            },
            ['Bihoro-Guhoro'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcOtherlands') == 7 then
                        handleOtherlandsTrade(player, npc, trade)
                    end
                end,
            },
            ['Jikka-Abukka'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'npcOtherlands') == 8 then
                        handleOtherlandsTrade(player, npc, trade)
                    end
                end,
            },
        },
    },
}

return quest
