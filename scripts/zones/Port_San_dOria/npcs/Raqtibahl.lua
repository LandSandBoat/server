-----------------------------------
-- Area: Port San d'Oria
--  NPC: Raqtibahl
-- (Corsair's Frac) !pos -59 -4 -39 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
    local letterRed = player:getCharVar("LeleroonsLetterRed")

    -- gold chain, velvet cloth, red grass cloth, sailcloth
    if (letterRed == 2 and trade:getItemCount() == 4 and trade:hasItemQty(761, 1) and trade:hasItemQty(828, 1) and trade:hasItemQty(1829, 1) and trade:hasItemQty(1997, 1)) then
        player:startEvent(755) -- accepts materials, now bring me imperial gold piece

    -- imperial gold piece
    elseif (letterRed == 3 and trade:getItemCount() == 1 and trade:hasItemQty(2187, 1)) then
        player:startEvent(760) -- accepts gold piece, now wait for next vana'diel day

    end
end

function onTrigger(player, npc)
    local letterRed = player:getCharVar("LeleroonsLetterRed")
    if (player:hasKeyItem(tpz.ki.LELEROONS_LETTER_RED)) then
        player:startEvent(753) -- accept letter, now bring me four items
    elseif (letterRed == 2) then
        player:startEvent(754) -- i'm waiting for four items
    elseif (letterRed == 3) then
        player:startEvent(761) -- i'm waiting for imperial gold piece
    elseif (letterRed == 4) then
        if (vanaDay() > player:getCharVar("corAfSubmitDay")) then
            player:startEvent(756) -- here's your cor frac
        else
            player:startEvent(757) -- patience. need to wait for vana'diel day
        end
    elseif (letterRed == 5) then
        player:startEvent(758) -- are you caring for your corsair's frac?
    else
        player:startEvent(759) -- default dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 753) then
        player:setCharVar("LeleroonsLetterRed", 2)
        player:delKeyItem(tpz.ki.LELEROONS_LETTER_RED)
    elseif (csid == 755) then
        player:tradeComplete()
        player:setCharVar("LeleroonsLetterRed", 3)
    elseif (csid == 760) then
        player:tradeComplete()
        player:setCharVar("LeleroonsLetterRed", 4)
        player:setCharVar("corAfSubmitDay", vanaDay())
    elseif (csid == 756) then
        player:setCharVar("LeleroonsLetterRed", 5)
        player:addItem(14522) -- corsair's frac
        player:messageSpecial(ID.text.ITEM_OBTAINED, 14522)
    end
end
