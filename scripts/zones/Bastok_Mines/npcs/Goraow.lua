-----------------------------------
-- Area: Bastok Mines
--  NPC: Goraow
-- Starts Quests: Vengeful Wrath
-- !pos 38 .1 14 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    local Vengeful = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.VENGEFUL_WRATH)

    if (Vengeful ~= QUEST_AVAILABLE) then
        QuadavHelm = trade:hasItemQty(501, 1)
        if (QuadavHelm == true and trade:getItemCount() == 1) then
            player:startEvent(107)
        end
    end
end

entity.onTrigger = function(player, npc)

    local Vengeful = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.VENGEFUL_WRATH)
    local Fame = player:getFameLevel(BASTOK)

    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatBastok, 16)) then
        player:startEvent(506)
    elseif (Vengeful == QUEST_AVAILABLE and Fame >= 3) then
        player:startEvent(106)
    else
        player:startEvent(105)
    end
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 106) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.VENGEFUL_WRATH)
    elseif (csid == 107) then
        Vengeful = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.VENGEFUL_WRATH)
        if (Vengeful == QUEST_ACCEPTED) then
            player:addTitle(xi.title.AVENGER)
            player:addFame(BASTOK, 120)
        else
            player:addFame(BASTOK, 8)
        end
        player:tradeComplete()
        player:addGil(GIL_RATE*900)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*900)
        player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.VENGEFUL_WRATH) -- for save fame
    elseif (csid == 506) then
        player:setCharVar("WildcatBastok", utils.mask.setBit(player:getCharVar("WildcatBastok"), 16, true))
    end
end

return entity
