-----------------------------------
-- Area: Norg
--  NPC: Washu
-- Involved in Quest: Yomi Okuri
-- Starts and finishes Quest: Stop Your Whining
-- !pos 49 -6 15 252
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- YOMI OKURI (SAM AF2)
    if (
        player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI) == QUEST_ACCEPTED and
        player:getCharVar("yomiOkuriKilledNM") == 0 and
        not player:hasKeyItem(xi.ki.WASHUS_TASTY_WURST) and
        not player:hasKeyItem(xi.ki.YOMOTSU_FEATHER) and
        npcUtil.tradeHas(trade, {939, 4360, 4372, 4382}) -- Hecteyes Eye, Bastore Sardine, Giant Sheep Meat, Frost Turnip
    ) then
        player:startEvent(150)
    end
end

entity.onTrigger = function(player, npc)
    -- YOMI OKURI (SAM AF2)
    if (player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI) == QUEST_ACCEPTED) then
        if (player:getCharVar("yomiOkuriCS") == 1) then
            player:startEvent(148) -- start quest
        elseif (player:hasKeyItem(xi.ki.WASHUS_TASTY_WURST)) then
            player:startEvent(151) -- remind objective
        elseif (player:getCharVar("yomiOkuriKilledNM") == 0 and not player:hasKeyItem(xi.ki.WASHUS_TASTY_WURST)) then
            player:startEvent(149) -- remind ingredients
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- YOMI OKURI (SAM AF2)
    if (csid == 148) then
        player:setCharVar("yomiOkuriCS", 2)
    elseif (csid == 150) then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, xi.ki.WASHUS_TASTY_WURST)
        player:setCharVar("yomiOkuriCS", 3)
    end
end

return entity
