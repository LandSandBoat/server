-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Rolandienne
-- Records of Eminence NPC
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.sparkshop.onTrade(player, npc, trade, 4601)
end

entity.onTrigger = function(player, npc)
    if player:getEminenceProgress(1) then
        player:startEvent(993)
    elseif not player:hasKeyItem(xi.ki.MEMORANDOLL) then
        player:startEvent(994)
    else
        player:triggerRoeEvent(xi.roeTrigger.TRIGGER_NPC)
        player:messageSpecial(ID.text.YOU_WISH_TO_EXCHANGE_SPARKS)
        xi.sparkshop.onTrigger(player, npc, 995)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.sparkshop.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 993 and option == 1 then
        xi.roe.onRecordTrigger(player, 1)
        player:messageBasic(xi.msg.basic.ROE_BONUS_ITEM_PLURAL, 4376, 6)
    end
end

return entity
