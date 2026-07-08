-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Granite Door
-- !pos 340 0.1 329 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.item.CURSED_KEY) and
        player:getZPos() < 332
    then
        -- Cursed Key
        player:confirmTrade()
        player:messageSpecial(ID.text.YOUR_KEY_BREAKS, 0, xi.item.CURSED_KEY)
        player:startEvent(25)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() < 332 then
        player:messageSpecial(ID.text.DOOR_LOCKED)
    else
        player:startEvent(26)
    end
end

return entity
