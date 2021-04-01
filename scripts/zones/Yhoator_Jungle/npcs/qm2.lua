-----------------------------------
-- Area: Yhoator Jungle
--  NPC: ??? Used for Norg quest "Stop Your Whining"
-- !pos -94.073 -0.999 22.295 124
-----------------------------------
local ID = require("scripts/zones/Yhoator_Jungle/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local StopWhining = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.STOP_YOUR_WHINING)

    if StopWhining == QUEST_ACCEPTED and not player:hasKeyItem(xi.ki.BARREL_OF_OPOOPO_BREW) and player:hasKeyItem(xi.ki.EMPTY_BARREL) then
        player:messageSpecial(ID.text.TREE_CHECK)
        player:addKeyItem(xi.ki.BARREL_OF_OPOOPO_BREW) --Filled Barrel
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BARREL_OF_OPOOPO_BREW)
        player:delKeyItem(xi.ki.EMPTY_BARREL) --Empty Barrel
    elseif StopWhining == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.BARREL_OF_OPOOPO_BREW) then
        player:messageSpecial(ID.text.TREE_FULL) --Already have full barrel
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 1 then
        player:addKeyItem(xi.ki.SEA_SERPENT_STATUE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SEA_SERPENT_STATUE)
    end
end

return entity
