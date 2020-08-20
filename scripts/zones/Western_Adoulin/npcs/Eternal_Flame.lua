-----------------------------------
-- Area: Western Adoulin
--  NPC: Eternal Flame
-- Records of Eminence NPC
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/keyitems")
require("scripts/globals/sparkshop")
local ID = require("scripts/zones/Western_Adoulin/IDs")

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    if player:getEminenceProgress(1) then
        player:startEvent(5079)
    elseif player:hasKeyItem(tpz.ki.MEMORANDOLL) == false then
        player:startEvent(5080)
    else
        player:messageSpecial(ID.text.SPARK_EXCHANGE)
        tpz.sparkshop.onTrigger(player,npc,5081)
    end
end

function onEventUpdate(player,csid,option)
    tpz.sparkshop.onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 5079 and option == 1 then
        npcUtil.completeRecord(player, 1, {
            item = { {4376,6} },
            keyItem = tpz.ki.MEMORANDOLL,
            sparks = 100,
            xp = 300
        })
        player:messageBasic(tpz.msg.basic.ROE_BONUS_ITEM_PLURAL,4376,6)
    end
end
