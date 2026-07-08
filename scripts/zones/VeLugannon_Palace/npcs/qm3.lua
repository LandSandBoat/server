-----------------------------------
-- Area: VeLugannon Palace
--  NPC: qm3 (???) 17502583
-- Note: Involved in Bartholomew's Knife mini-quest
-- !pos 0.21 0.57 -322.4 177
-----------------------------------
local ID = zones[xi.zone.VELUGANNON_PALACE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, { xi.item.BUCCANEERS_KNIFE }) then
        local item         = nil
        local canTransform = false

        -- check for exdata on item
        for i = 0, 8, 1 do
            item = trade:getItem(i)

            if item and item:getID() == xi.item.BUCCANEERS_KNIFE then
                canTransform = item:getExDataRaw()[0] == 8
                break
            end
        end

        if item then
            if canTransform then
                if
                    player:getFreeSlotsCount() <= 0 or
                    player:hasItem(xi.item.BARTHOLOMEWS_KNIFE)
                then
                    item:setReservedValue(0)
                    trade:clean()

                    -- add in 0x8000 "no validation" flag to the ID to remove the QM's name from the message
                    player:showText(npc, bit.bor(ID.text.ITEM_CANNOT_BE_OBTAINED_TRADE, 0x8000), xi.item.BARTHOLOMEWS_KNIFE, 0, 0, 0, false, false)
                    return
                else
                    player:confirmTrade()

                    player:messageSpecial(ID.text.KNIFE_CHANGES_SHAPE, xi.item.BUCCANEERS_KNIFE)
                    npcUtil.giveItem(player, xi.item.BARTHOLOMEWS_KNIFE)
                    return
                end
            end

            item:setReservedValue(0)
            trade:clean()
        end
    end

    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end

entity.onTrigger = function(player, npc)
    player:startEvent(2)
end

return entity
