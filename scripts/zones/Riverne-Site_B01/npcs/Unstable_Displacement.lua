-----------------------------------
-- Area: Riverne Site #B01
--  NPC: Unstable Displacement
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local offset = npc:getID() - ID.npc.DISPLACEMENT_OFFSET
    if (offset == 5 and TradeBCNM(player, npc, trade)) then -- The Wyrmking Descends
        return
    end
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.DISPLACEMENT_OFFSET

    -- STORMS OF FATE
    if offset == 5 and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_ACCEPTED and player:getCharVar('StormsOfFate') == 1 then
        player:startEvent(1)
    elseif offset == 5 and EventTriggerBCNM(player, npc) then
        return
    elseif offset == 5 then
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
