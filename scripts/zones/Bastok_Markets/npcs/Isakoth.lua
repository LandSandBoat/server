-----------------------------------
-- Area: Bastok Markets
--  NPC: Isakoth
-- Records of Eminence NPC
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/keyitems")
require("scripts/globals/sparkshop")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Bastok_Markets/IDs")

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    if player:getEminenceProgress(1) then
        player:startEvent(24)
    elseif player:hasKeyItem(tpz.ki.MEMORANDOLL) == false then
        player:startEvent(25)
    else
        player:messageSpecial(ID.text.TURNING_IN_SPARKS)
        tpz.sparkshop.onTrigger(player,npc,26)
    end
end

function onEventUpdate(player,csid,option)
    tpz.sparkshop.onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 24 and option == 1 then
        npcUtil.completeRecord(player, 1, {
            item = { {4376,6} },
            keyItem = tpz.ki.MEMORANDOLL,
            sparks = 100,
            xp = 300
        })
        player:messageBasic(tpz.msg.basic.ROE_BONUS_ITEM_PLURAL,4376,6)
    end
end
