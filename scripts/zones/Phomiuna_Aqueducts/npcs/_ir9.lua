-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _ir9 (Iron Gate)
-- !pos 70 -1.5 140 27
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getXPos() < -70 then
        player:printToPlayer('You are standing too close to the gate.', xi.msg.channel.SYSTEM_3)
        return
    end

    if npc:getAnimation() ~= 9 then
        return
    end

    if npcUtil.tradeHasExactly(trade, xi.item.BRONZE_KEY) then
        player:confirmTrade()
        player:messageSpecial(ID.text.ITEM_BREAKS, xi.item.BRONZE_KEY)
        npc:openDoor(15)
    elseif
        player:getMainJob() == xi.job.THF and
        (npcUtil.tradeHasExactly(trade, xi.item.SKELETON_KEY) or
        npcUtil.tradeHasExactly(trade, xi.item.SET_OF_THIEFS_TOOLS) or
        npcUtil.tradeHasExactly(trade, xi.item.LIVING_KEY))
    then
        -- TODO: Needs verification for messages displayed, and if picking is 100% successful.
        player:confirmTrade()
        npc:openDoor(15)
    end
end

entity.onTrigger = function(player, npc)
    if player:getXPos() <= -71 then
        npc:openDoor(15)
    elseif npc:getAnimation() == 9 then
        player:messageSpecial(ID.text.DOOR_LOCKED, xi.item.BRONZE_KEY)
    end
end

return entity
