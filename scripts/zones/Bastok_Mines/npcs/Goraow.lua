-----------------------------------
-- Area: Bastok Mines
--  NPC: Goraow
-- Starts Quests: Vengeful Wrath
-- !pos 38 .1 14 234
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/titles")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    local Vengeful = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.VENGEFUL_WRATH)

    if (Vengeful ~= QUEST_AVAILABLE) then
        QuadavHelm = trade:hasItemQty(501, 1)
        if (QuadavHelm == true and trade:getItemCount() == 1) then
            player:startEvent(107)
        end
    end
end

function onTrigger(player, npc)

    local Vengeful = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.VENGEFUL_WRATH)
    local Fame = player:getFameLevel(BASTOK)

    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatBastok, 16) == false) then
        player:startEvent(506)
    elseif (Vengeful == QUEST_AVAILABLE and Fame >= 3) then
        player:startEvent(106)
    else
        player:startEvent(105)
    end
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)

    if (csid == 106) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.VENGEFUL_WRATH)
    elseif (csid == 107) then
        Vengeful = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.VENGEFUL_WRATH)
        if (Vengeful == QUEST_ACCEPTED) then
            player:addTitle(tpz.title.AVENGER)
            player:addFame(BASTOK, 120)
        else
            player:addFame(BASTOK, 8)
        end
        player:tradeComplete()
        player:addGil(GIL_RATE*900)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*900)
        player:completeQuest(BASTOK, tpz.quest.id.bastok.VENGEFUL_WRATH) -- for save fame
    elseif (csid == 506) then
        player:setMaskBit(player:getCharVar("WildcatBastok"), "WildcatBastok", 16, true)
    end
end
