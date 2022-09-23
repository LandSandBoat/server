-----------------------------------
-- Area: East Ronfaure [S]
--  NPC: qm5 "???"
-- Involved in Quests: Steamed Rams
-- !pos 380.015 -26.5 -22.525
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/campaign")
local ID = require("scripts/zones/East_Ronfaure_[S]/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.STEAMED_RAMS) == QUEST_ACCEPTED) then
        if (player:hasKeyItem(xi.ki.OXIDIZED_PLATE)) then
            player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        else
            player:startEvent(3)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- print("CSID:", csid)
    -- print("RESULT:", option)
    if (csid == 3) then
        player:addKeyItem(xi.ki.OXIDIZED_PLATE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.OXIDIZED_PLATE)
    end
end

return entity
