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

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local gotItAllProg = player:getCharVar("gotitallCS")
    if gotItAllProg == 1 then
        player:startEvent(537)
    elseif gotItAllProg == 2 then
        player:startEvent(536)
    elseif gotItAllProg == 3 then
        player:startEvent(524)
    elseif player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.GOT_IT_ALL) == QUEST_COMPLETED then
        player:startEvent(531)
    else
        player:startEvent(532)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 537 then
        player:setCharVar("gotitallCS", 2)
    elseif csid == 524 then
        player:addKeyItem(tpz.ki.VIAL_OF_LUMINOUS_WATER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.VIAL_OF_LUMINOUS_WATER)
        player:setCharVar("gotitallCS", 4)
    end
end
