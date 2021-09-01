-----------------------------------
-- In Defiant Challenge
-----------------------------------
-- Log ID: 3, Quest ID: 128
-- Maat : !pos 8 3 118 243
-- Crawlers Nest
-- qm10 : !pos -83.391 -8.222 79.065 197
-- qm11 : !pos 98.081 -38.75 -181.198 197
-- qm12 : !pos 99.326 -0.126 -188.869 197
-- Garlaige Citadel
-- qm18 : !pos -13.425, -1.176, 191.669 200
-- qm19 : !pos -50.175 6.264 251.669 200
-- qm20 : !pos -137.047 0 347.502 200
-- The Eldieme Necropolis
-- qm7 : !pos 252.824 -32.000 -64.803 195
-- qm8 : !pos 105.275 -32 92.551 195
-- qm9 : !pos 92.272 -32 -64.676 195
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
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.IN_DEFIANT_CHALLENGE)
-----------------------------------

local function handleExorayMold(player)
    if player:hasKeyItem(xi.ki.EXORAY_MOLD_CRUMB1) and player:hasKeyItem(xi.ki.EXORAY_MOLD_CRUMB2) and player:hasKeyItem(xi.ki.EXORAY_MOLD_CRUMB3) then
        npcUtil.giveItem(player, xi.items.CLUMP_OF_EXORAY_MOLD)
        player:delKeyItem(xi.ki.EXORAY_MOLD_CRUMB1)
        player:delKeyItem(xi.ki.EXORAY_MOLD_CRUMB2)
        player:delKeyItem(xi.ki.EXORAY_MOLD_CRUMB3)
    end
end

local function handleBombCoal(player)
    if player:hasKeyItem(xi.ki.BOMB_COAL_FRAGMENT1) and player:hasKeyItem(xi.ki.BOMB_COAL_FRAGMENT2) and player:hasKeyItem(xi.ki.BOMB_COAL_FRAGMENT3) then
        npcUtil.giveItem(player, xi.items.CHUNK_OF_BOMB_COAL)
        player:delKeyItem(xi.ki.BOMB_COAL_FRAGMENT1)
        player:delKeyItem(xi.ki.BOMB_COAL_FRAGMENT2)
        player:delKeyItem(xi.ki.BOMB_COAL_FRAGMENT3)
    end
end

local function handleAncientPapyrus(player)
    if player:hasKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED1) and player:hasKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED2) and player:hasKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED3) then
        npcUtil.giveItem(player, xi.items.PIECE_OF_ANCIENT_PAPYRUS)
        player:delKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED1)
        player:delKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED2)
        player:delKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED3)
    end
end

quest.reward =
{
    fame  = 30,
    fameArea = JEUNO,
    title = xi.title.HORIZON_BREAKER,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() == 50 and
                player:getLevelCap() == 50 and
                xi.settings.MAX_LEVEL >= 55
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(79)
                end,
            },

            onEventFinish =
            {
                [79] = function(player, csid, option, npc)
                    if option ==  1 then -- Accept quest option.
                        quest:begin(player)
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
                    return quest:event(80)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {xi.items.CLUMP_OF_EXORAY_MOLD, xi.items.CHUNK_OF_BOMB_COAL, xi.items.PIECE_OF_ANCIENT_PAPYRUS}) then
                        return quest:progressEvent(81)
                    end
                end,
            },

            onEventFinish =
            {
                [81] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:setLevelCap(55)
                        -- Leaving this here for historic purposes. Unneeded. The event now returns this message on its own.
                        -- player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_55)
                    end
                end,
            },
        },

        [xi.zone.CRAWLERS_NEST] =
        {
            ['qm10'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasItem(xi.items.CLUMP_OF_EXORAY_MOLD) and not player:hasKeyItem(xi.ki.EXORAY_MOLD_CRUMB1) and not xi.settings.OLDSCHOOL_G1 then
                        npcUtil.giveKeyItem(player, xi.ki.EXORAY_MOLD_CRUMB1)
                        handleExorayMold(player)
                    end
                end,
            },

            ['qm11'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasItem(xi.items.CLUMP_OF_EXORAY_MOLD) and not player:hasKeyItem(xi.ki.EXORAY_MOLD_CRUMB2) and not xi.settings.OLDSCHOOL_G1 then
                        npcUtil.giveKeyItem(player, xi.ki.EXORAY_MOLD_CRUMB2)
                        handleExorayMold(player)
                    end
                end,
            },

            ['qm12'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasItem(xi.items.CLUMP_OF_EXORAY_MOLD) and not player:hasKeyItem(xi.ki.EXORAY_MOLD_CRUMB3) and not xi.settings.OLDSCHOOL_G1 then
                        npcUtil.giveKeyItem(player, xi.ki.EXORAY_MOLD_CRUMB3)
                        handleExorayMold(player)
                    end
                end,
            },
        },

        [xi.zone.GARLAIGE_CITADEL] =
        {
            ['qm18'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasItem(xi.items.CHUNK_OF_BOMB_COAL) and not player:hasKeyItem(xi.ki.BOMB_COAL_FRAGMENT1) and not xi.settings.OLDSCHOOL_G1 then
                        npcUtil.giveKeyItem(player, xi.ki.BOMB_COAL_FRAGMENT1)
                        handleBombCoal(player)
                    end
                end,
            },

            ['qm19'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasItem(xi.items.CHUNK_OF_BOMB_COAL) and not player:hasKeyItem(xi.ki.BOMB_COAL_FRAGMENT2) and not xi.settings.OLDSCHOOL_G1 then
                        npcUtil.giveKeyItem(player, xi.ki.BOMB_COAL_FRAGMENT2)
                        handleBombCoal(player)
                    end
                end,
            },

            ['qm20'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasItem(xi.items.CHUNK_OF_BOMB_COAL) and not player:hasKeyItem(xi.ki.BOMB_COAL_FRAGMENT3) and not xi.settings.OLDSCHOOL_G1 then
                        npcUtil.giveKeyItem(player, xi.ki.BOMB_COAL_FRAGMENT3)
                        handleBombCoal(player)
                    end
                end,
            },
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS] =
        {
            ['qm7'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasItem(xi.items.PIECE_OF_ANCIENT_PAPYRUS) and not player:hasKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED1) and not xi.settings.OLDSCHOOL_G1 then
                        npcUtil.giveKeyItem(player, xi.ki.ANCIENT_PAPYRUS_SHRED1)
                        handleAncientPapyrus(player)
                    end
                end,
            },

            ['qm8'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasItem(xi.items.PIECE_OF_ANCIENT_PAPYRUS) and not player:hasKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED2) and not xi.settings.OLDSCHOOL_G1 then
                        npcUtil.giveKeyItem(player, xi.ki.ANCIENT_PAPYRUS_SHRED2)
                        handleAncientPapyrus(player)
                    end
                end,
            },

            ['qm9'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasItem(xi.items.PIECE_OF_ANCIENT_PAPYRUS) and not player:hasKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED3) and not xi.settings.OLDSCHOOL_G1 then
                        npcUtil.giveKeyItem(player, xi.ki.ANCIENT_PAPYRUS_SHRED3)
                        handleAncientPapyrus(player)
                    end
                end,
            },
        },
    },
}

return quest
