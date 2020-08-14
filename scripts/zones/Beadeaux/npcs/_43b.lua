-----------------------------------
-- Area: Beadeaux
--  NPC: Jail Door
-- Involved in Quests: The Rescue
-- !pos 56 0.1 -23 147
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Beadeaux/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_RESCUE) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.TRADERS_SACK) == false) then
        if (trade:hasItemQty(495, 1) == true and trade:getItemCount() == 1) then
            player:startEvent(1000)
        end
    end
end

function onTrigger(player, npc)
    if (player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_RESCUE) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.TRADERS_SACK) == false) then
        player:messageSpecial(ID.text.LOCKED_DOOR_QUADAV_HAS_KEY)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 1000) then
        player:addKeyItem(tpz.ki.TRADERS_SACK)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TRADERS_SACK)
    end
end
