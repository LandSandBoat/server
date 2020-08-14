-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Song Runes
--  Finishes Quest: The Old Monument
-- !pos -244 16 -280 118
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
-----------------------------------

local PARCHMENT = 917
local POETIC_PARCHMENT = 634

function onTrade(player, npc, trade)
    -- THE OLD MONUMENT (parchment)
    if player:getCharVar("TheOldMonument_Event") == 3 and trade:hasItemQty(PARCHMENT, 1) and trade:getItemCount() == 1 then
        player:startEvent(2)
    end
end

function onTrigger(player, npc)
    -- THE OLD MONUMENT
    if player:getCharVar("TheOldMonument_Event") == 2 then
        player:startEvent(0)
    elseif player:getCharVar("TheOldMonument_Event") == 3 then
        player:messageSpecial(ID.text.SONG_RUNES_REQUIRE, 917)

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.SONG_RUNES_DEFAULT)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 0 then
        player:setCharVar("TheOldMonument_Event", 3)
    elseif csid == 2 then
        player:tradeComplete()
        player:messageSpecial(ID.text.SONG_RUNES_WRITING, 917)
        player:addItem(POETIC_PARCHMENT, 1)
        player:messageSpecial(ID.text.ITEM_OBTAINED, POETIC_PARCHMENT)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.THE_OLD_MONUMENT)
        player:addTitle(tpz.title.RESEARCHER_OF_CLASSICS)
        player:addFame(BASTOK, 10)
        player:addFame(SANDORIA, 10)
        player:addFame(WINDURST, 10)
    end
end
