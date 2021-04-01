-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ekhu Pesshyadha
-- Type: Standard NPC
-- !pos -13.043 0.999 103.423 50
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local gotItAllProg = player:getCharVar("gotitallCS")
    if gotItAllProg == 1 then
        player:startEvent(537)
    elseif gotItAllProg == 2 then
        player:startEvent(536)
    elseif gotItAllProg == 3 then
        player:startEvent(524)
    elseif player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.GOT_IT_ALL) == QUEST_COMPLETED then
        player:startEvent(531)
    else
        player:startEvent(532)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 537 then
        player:setCharVar("gotitallCS", 2)
    elseif csid == 524 then
        player:addKeyItem(xi.ki.VIAL_OF_LUMINOUS_WATER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.VIAL_OF_LUMINOUS_WATER)
        player:setCharVar("gotitallCS", 4)
    end
end

return entity
