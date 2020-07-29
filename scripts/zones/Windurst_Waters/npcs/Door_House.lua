-----------------------------------
-- Area: Windurst Waters
--  NPC: Door_House
-- (Corsair's Gants) !pos -200 -4 -111 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
    local npcID = npc:getID()
    if (npcID == ID.npc.LELEROON_GREEN_DOOR) then
        local letterGreen = player:getCharVar("LeleroonsLetterGreen")

        -- gold thread, karakul leather, red grass cloth, wamoura silk
        if (letterGreen == 2 and trade:getItemCount() == 4 and trade:hasItemQty(823, 1) and trade:hasItemQty(879, 1) and trade:hasItemQty(1829, 1) and trade:hasItemQty(2304, 1)) then
            player:startEvent(943) -- accepts materials, now bring me 4 imperial mythril pieces

        -- 4 imperial mythril pieces
        elseif (letterGreen == 3 and trade:getItemCount() == 4 and trade:hasItemQty(2186, 4)) then
            player:startEvent(946) -- accepts mythril pieces, now wait for next vana'diel day

        end
    end
end

function onTrigger(player, npc)
    local npcID = npc:getID()
    if (npcID == ID.npc.LELEROON_GREEN_DOOR) then
        local letterGreen = player:getCharVar("LeleroonsLetterGreen")
        if (player:hasKeyItem(tpz.ki.LELEROONS_LETTER_GREEN)) then
            player:startEvent(941) -- accept letter, now bring me four items
        elseif (letterGreen == 2) then
            player:startEvent(942) -- i'm waiting for four items
        elseif (letterGreen == 3) then
            player:startEvent(954) -- i'm waiting for 4 imperial mythril pieces
        elseif (letterGreen == 4) then
            if (vanaDay() > player:getCharVar("corAfSubmitDay")) then
                player:startEvent(944) -- here's your cor gants
            else
                player:startEvent(945) -- patience. need to wait for vana'diel day
            end
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 941) then
        player:setCharVar("LeleroonsLetterGreen", 2)
        player:delKeyItem(tpz.ki.LELEROONS_LETTER_GREEN)
    elseif (csid == 943) then
        player:tradeComplete()
        player:setCharVar("LeleroonsletterGreen", 3)
    elseif (csid == 946) then
        player:tradeComplete()
        player:setCharVar("LeleroonsletterGreen", 4)
        player:setCharVar("corAfSubmitDay", vanaDay())
    elseif (csid == 944) then
        player:setCharVar("LeleroonsletterGreen", 5)
        player:addItem(14929) -- corsair's gants
        player:messageSpecial(ID.text.ITEM_OBTAINED, 14929)
    end
end
