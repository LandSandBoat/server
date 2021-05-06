-----------------------------------
-- Area: Talacca_Cove
--  NPC: rock slab (corsair job flag quest)
-- !pos -99 -7 -91 57
-----------------------------------
local ID = require("scripts/zones/Talacca_Cove/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local LuckOfTheDraw = player:getCharVar("LuckOfTheDraw")

    if (LuckOfTheDraw ==4) then
        player:startEvent(3)
    elseif (EventTriggerBCNM(player, npc)) then
        return
    end

end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 3) then -- complete corsair job flag quest
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 5493)
        else
            player:setCharVar("LuckOfTheDraw", 5) -- var will remain for af quests
            player:addItem(5493)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 5493)
            player:delKeyItem(xi.ki.FORGOTTEN_HEXAGUN)
            player:unlockJob(xi.job.COR)
            player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_CORSAIR)
            player:completeQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.LUCK_OF_THE_DRAW)
        end
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end

end

return entity
