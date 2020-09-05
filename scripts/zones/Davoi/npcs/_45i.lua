-----------------------------------
-- Area: Davoi
--  NPC: Wailing Pond
-- Used In Quest: Whence Blows the Wind
-- !pos 380 0.1 -181 149
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(52)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 52 and player:getCharVar("miniQuestForORB_CS") == 1) then

        local c = player:getCharVar("countRedPoolForORB")

        if (c == 0) then
            player:setCharVar("countRedPoolForORB", c + 2)
            player:delKeyItem(tpz.ki.WHITE_ORB)
            player:addKeyItem(tpz.ki.PINK_ORB)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PINK_ORB)
        elseif (c == 1 or c == 4 or c == 8) then
            player:setCharVar("countRedPoolForORB", c + 2)
            player:delKeyItem(tpz.ki.PINK_ORB)
            player:addKeyItem(tpz.ki.RED_ORB)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RED_ORB)
        elseif (c == 5 or c == 9 or c == 12) then
            player:setCharVar("countRedPoolForORB", c + 2)
            player:delKeyItem(tpz.ki.RED_ORB)
            player:addKeyItem(tpz.ki.BLOOD_ORB)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BLOOD_ORB)
        elseif (c == 13) then
            player:setCharVar("countRedPoolForORB", c + 2)
            player:delKeyItem(tpz.ki.BLOOD_ORB)
            player:addKeyItem(tpz.ki.CURSED_ORB)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CURSED_ORB)
            player:addStatusEffect(tpz.effect.CURSE_I, 50, 0, 900)
        end
    end

end
