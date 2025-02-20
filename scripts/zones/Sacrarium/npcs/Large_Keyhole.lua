-----------------------------------
-- Area: Sacrarium
--  NPC: Large Keyhole
-- Notes: Used to open R. Gate
-- !pos 100.231 -1.414 51.700 28
-----------------------------------
local ID = zones[xi.zone.SACRARIUM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.TEMPLE_KNIGHT_KEY) then
        GetNPCByID(npc:getID() - 2):openDoor(15)
    else
        player:messageSpecial(ID.text.LARGE_KEYHOLE_DESCRIPTION)
    end
end

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.SEALION_CREST_KEY) then
        local smallKeyhole = GetNPCByID(ID.npc.SMALL_KEYHOLE)

        if
            smallKeyhole and
            smallKeyhole:getLocalVar('canTradeSecondKey') == 1
        then
            GetNPCByID(npc:getID() - 2):openDoor(15)
            smallKeyhole:setLocalVar('canTradeSecondKey', 0)
        else
            player:messageSpecial(ID.text.CANNOT_TRADE_NOW)
        end
    end
end

return entity
