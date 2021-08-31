-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Granite Door
-- !pos 340 0.1 329 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 1143) and player:getZPos() < 332 then -- Cursed Key
        if player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) == 4 then
            player:confirmTrade()
            player:startEvent(23)
        else
            player:confirmTrade()
            player:messageSpecial(ID.text.YOUR_KEY_BREAKS, 0, 1143)
            player:startEvent(25)
        end
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 23 then
        player:setPos(340, 0, 333)
        player:delKeyItem(xi.ki.BLANK_BOOK_OF_THE_GODS)
        player:addKeyItem(xi.ki.BOOK_OF_THE_GODS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BOOK_OF_THE_GODS)
        player:setMissionStatus(player:getNation(), 5)
    end
end

return entity
