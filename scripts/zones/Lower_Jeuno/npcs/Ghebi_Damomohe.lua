-----------------------------------
-- Area: Lower Jeuno
--  NPC: Ghebi Damomohe
-- Type: Standard Merchant
-- Starts and Finishes Quest: Tenshodo Membership
-- !pos 16 0 -5 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP) ~= QUEST_COMPLETED and
        npcUtil.tradeHas(trade, 548)
    then
        -- Finish Quest: Tenshodo Membership (Invitation)
        player:startEvent(108)
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getFameLevel(xi.quest.fame_area.JEUNO) >= 2 and
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP) == QUEST_AVAILABLE
    then
        -- Start Quest: Tenshodo Membership
        player:startEvent(106, 8)
    elseif player:hasKeyItem(xi.ki.TENSHODO_APPLICATION_FORM) then
        -- Finish Quest: Tenshodo Membership
        player:startEvent(107)
    else
        player:startEvent(106, 4)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 106 and option == 0 then
        local stock =
        {
            4405,  144, -- Rice Ball
            4457, 2700, -- Eel Kabob
            4467,    3, -- Garlic Cracker
        }

        xi.shop.general(player, stock, xi.quest.fame_area.NORG)

    elseif csid == 106 and option == 2 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP)

    elseif csid == 107 then
        -- Finish Quest: Tenshodo Membership (Application Form)
        if npcUtil.completeQuest(player, xi.quest.log_id.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP, { item = 548, title = xi.title.TENSHODO_MEMBER, ki = xi.ki.TENSHODO_MEMBERS_CARD }) then
            player:delKeyItem(xi.ki.TENSHODO_APPLICATION_FORM)
        end

    elseif csid == 108 then
        -- Finish Quest: Tenshodo Membership (Invitation)
        if npcUtil.completeQuest(player, xi.quest.log_id.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP, { item = 548, title = xi.title.TENSHODO_MEMBER, ki = xi.ki.TENSHODO_MEMBERS_CARD }) then
            player:confirmTrade()
            player:delKeyItem(xi.ki.TENSHODO_APPLICATION_FORM)
        end
    end
end

return entity
