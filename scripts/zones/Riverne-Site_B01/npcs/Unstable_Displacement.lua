-----------------------------------
-- Area: Riverne Site #B01
--  NPC: Unstable Displacement
-- Note: entrance for "Storms of Fate" and "The Wyrmking Descends"
-- !pos -612.800 1.750 693.190 29
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/quests")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_ACCEPTED and player:getCharVar('StormsOfFate') == 1 then
        player:startEvent(1)
    elseif EventTriggerBCNM(player, npc) then
        return
    else
        player:messageSpecial(ID.text.SPACE_SEEMS_DISTORTED)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 1 then
        player:setCharVar('StormsOfFate', 2)
    end
end

return entity
