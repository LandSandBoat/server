-----------------------------------
-- Area: Bastok Mines
--  NPC: Door_House (Corsair's Bottes)
-- !pos 10 0 -16 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npc:getID() == ID.npc.LELEROON_BLUE_DOOR then
        local letterBlue = player:getCharVar("LeleroonsLetterBlue")
        if letterBlue == 2 and npcUtil.tradeHas(trade, {663, 879, 2007, 2010}) then -- mythril sheet, karakul leather, laminated buffalo leather, wolf felt
            player:startEvent(521) -- accepts materials, now bring me 4 imperial mythril pieces
        elseif letterBlue == 3 and npcUtil.tradeHas(trade, {{2186, 4}}) then -- 4 imperial mythril pieces
            player:startEvent(524) -- accepts mythril pieces, now wait for next vana'diel day
        end
    end
end

function onTrigger(player, npc)
    if npc:getID() == ID.npc.LELEROON_BLUE_DOOR then
        local letterBlue = player:getCharVar("LeleroonsletterBlue")
        if player:hasKeyItem(tpz.ki.LELEROONS_LETTER_BLUE) then
            player:startEvent(519) -- accept letter, now bring me four items
        elseif letterBlue == 2 then
            player:startEvent(520) -- i'm waiting for four items
        elseif letterBlue == 3 then
            player:startEvent(535) -- i'm waiting for 4 imperial mythril pieces
        elseif letterBlue == 4 then
            if vanaDay() > player:getCharVar("corAfSubmitDay") then
                player:startEvent(522) -- here's your cor bottes
            else
                player:startEvent(523) -- patience. need to wait for vana'diel day
            end
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 519 then
        player:setCharVar("LeleroonsletterBlue", 2)
        player:delKeyItem(tpz.ki.LELEROONS_LETTER_BLUE)
    elseif csid == 521 then
        player:confirmTrade()
        player:setCharVar("LeleroonsletterBlue", 3)
    elseif csid == 524 then
        player:confirmTrade()
        player:setCharVar("LeleroonsletterBlue", 4)
        player:setCharVar("corAfSubmitDay", vanaDay())
    elseif csid == 522 and npcUtil.giveItem(player, 15685) then
        player:setCharVar("LeleroonsletterBlue", 5)
    end
end
