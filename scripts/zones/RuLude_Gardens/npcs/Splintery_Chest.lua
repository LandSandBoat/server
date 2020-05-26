-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Splintery Chest
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    player:startEvent(10133)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    local itemId = 0
--------------------
    -- Page 2
--------------------
    if (option == 0) then -- Pugilists
        itemId = 19327
    elseif (option == 4) then -- Peeler
        itemId = 19332
    elseif (option == 8) then -- Side-sword
        itemId = 19337
    elseif (option == 12) then -- Break Blade
        itemId = 19342
    elseif (option == 16) then -- Chopper
        itemId = 19347
    elseif (option == 20) then -- Lumberjack
        itemId = 19352
    elseif (option == 24) then -- Farmhand
        itemId = 19357
    elseif (option == 28) then -- Ranseur
        itemId = 19362
    elseif (option == 32) then -- KibaShiri
        itemId = 19367
    elseif (option == 36) then -- Donto
        itemId = 19372
    elseif (option == 40) then -- Stenz
        itemId = 19377
    elseif (option == 44) then -- Crook
        itemId = 19382
    elseif (option == 48) then -- Sparrow
        itemId = 19387
    elseif (option == 52) then -- Thunderstick
        itemId = 19392
--------------------
    -- Page 2
--------------------
    elseif (option == 64) then -- Barracudas
        itemId = 19415
    elseif (option == 68) then -- Fusetto
        itemId = 19419
    elseif (option == 72) then -- Machaera
        itemId = 19423
    elseif (option == 76) then -- Kalavejs
        itemId = 19427
    elseif (option == 80) then -- Renausd's Axe
        itemId = 19431
    elseif (option == 84) then -- Sumaru
        itemId = 19435
    elseif (option == 88) then -- Reckoning
        itemId = 19439
    elseif (option == 92) then -- Stingray
        itemId = 19443
    elseif (option == 96) then -- Uzuru
        itemId = 19447
    elseif (option == 100) then -- Keitonotachi
        itemId = 19451
    elseif (option == 104) then -- Makhila
        itemId = 19455
    elseif (option == 108) then -- Sedikutchi
        itemId = 18932
    elseif (option == 112) then -- Sparrowhawk
        itemId = 18936
    elseif (option == 116) then -- Anachry
        itemId = 18940
--------------------
    -- Page 3
--------------------
    elseif (option == 128) then -- Dumuzis -1
        itemId = 20544
    elseif (option == 132) then -- Khandroma -1
        itemId = 20631
    elseif (option == 140) then -- Brunello -1
        itemId = 20732
    elseif (option == 144) then -- Xiphias -1
        itemId = 20769
    elseif (option == 148) then -- Sacripante -1
        itemId = 20821
    elseif (option == 152) then -- Shamash -1
        itemId = 20867
    elseif (option == 156) then -- Umiliati -1
        itemId = 20912
    elseif (option == 160) then -- Daboya -1
        itemId = 20959
    elseif (option == 164) then -- Kasasagi -1
        itemId = 21001
    elseif (option == 168) then -- Torigashiranotachi -1
        itemId = 21048
    elseif (option == 172) then -- Rose Couverte -1
        itemId = 21121
    elseif (option == 176) then -- Circinae -1
        itemId = 21234
    elseif (option == 180) then -- Mollfrith -1
        itemId = 21283
    end

    if (option ~= 1073741824) then
        if player:getFreeSlotsCount() >= 1 then
            player:addItem(itemId,1)
            player:messageSpecial(ID.text.ITEM_OBTAINED,itemId)
        elseif (itemId == 0) then
            -- How did you get here??
            player:PrintToPlayer( "itemId or OptionID related script error!" )
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED,itemId)
        end
    end
end
