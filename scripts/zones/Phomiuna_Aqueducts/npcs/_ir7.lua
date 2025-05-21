-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _ir7 (Iron Gate)
-- !pos -70.800 -1.500 60.000 27
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- TODO: There may be a message displayed onTrade if the door is open.
    if player:getXPos() >= -70 and npc:getAnimation() == 9 then
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
end

entity.onTrigger = function(player, npc)
    if player:getXPos() <= -71 then
        npc:openDoor(15)
    elseif npc:getAnimation() == 9 then
        player:messageSpecial(ID.text.DOOR_LOCKED, xi.item.BRONZE_KEY)
    end
end

return entity
