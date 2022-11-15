-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Door:House
-- !pos 148 0 27 80
-- Involved in Knot Quite There
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE) == QUEST_ACCEPTED and
        player:getCharVar("KnotQuiteThere") == 3
    then
        player:startEvent(63)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 63 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 751)
        else
            player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE)
            player:addItem(751)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 751) --Platinum Beastcoin
            player:setCharVar("KnotQuiteThere", 0)
        end
    end
end

return entity
