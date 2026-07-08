-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _ir8 (Iron Gate)
-- !pos 20 -1.5 50 0
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getZPos() > 50 and npc:getAnimation() == xi.animation.CLOSE_DOOR then
        if npcUtil.tradeHasExactly(trade, xi.item.BRONZE_KEY) then
            player:confirmTrade()
            player:messageSpecial(ID.text.ITEM_BREAKS, xi.item.BRONZE_KEY)
            npc:openDoor(15)
        elseif player:getMainJob() == xi.job.THF then
            local itemId = npcUtil.tradeHasExactly(trade, xi.item.SKELETON_KEY) and xi.item.SKELETON_KEY or 0

            itemId = npcUtil.tradeHasExactly(trade, xi.item.SET_OF_THIEFS_TOOLS) and xi.item.SET_OF_THIEFS_TOOLS or itemId
            itemId = npcUtil.tradeHasExactly(trade, xi.item.LIVING_KEY) and xi.item.LIVING_KEY or itemId

            if itemId ~= 0 then
                local noValidationFlag = 0x8000

                player:showText(npc, bit.bor(ID.text.ITEM_BREAKS + 2, noValidationFlag), itemId, 0, 0, 0, false, false)
                player:confirmTrade()

                npc:openDoor(15)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() <= 50 then
        npc:openDoor(15)
    elseif npc:getAnimation() == xi.animation.CLOSE_DOOR then
        local noValidationFlag = 0x8000

        if player:getMainJob() == xi.job.THF then
            player:showText(npc, bit.bor(ID.text.DOOR_LOCKED + 1, noValidationFlag), xi.item.BRONZE_KEY, xi.item.SET_OF_THIEFS_TOOLS, 0, 0, false, false)
        else
            player:showText(npc, bit.bor(ID.text.DOOR_LOCKED, noValidationFlag), xi.item.BRONZE_KEY, 0, 0, 0, false, false)
        end
    end
end

return entity
