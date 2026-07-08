-----------------------------------
-- Area: Bastok Markets
--  NPC: Isakoth
-- Records of Eminence NPC
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.sparkshop.onTrade(player, npc, trade, 27)
end

entity.onTrigger = function(player, npc)
    if player:getEminenceProgress(1) then
        local tutorialStarted = player:getVar('HQuest[Tutorial]Prog') > 0 and 0 or 1
        player:startEvent(24, tutorialStarted)
    elseif not player:hasKeyItem(xi.ki.MEMORANDOLL) then
        player:startEvent(25)
    else
        player:triggerRoeEvent(xi.roeTrigger.TRIGGER_NPC)
        player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.TURNING_IN_SPARKS)
        xi.sparkshop.onTrigger(player, npc, 26)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.sparkshop.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 24 then
        xi.roe.onRecordTrigger(player, 1)
    end
end

return entity
