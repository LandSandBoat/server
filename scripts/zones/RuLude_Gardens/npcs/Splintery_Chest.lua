-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Splintery Chest
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(10133)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local ItemID = 0
--------------------
    -- Page 2
--------------------
    if (option == 0) then -- Pugilists
        ItemID = 19327
    elseif (option == 4) then -- Peeler
        ItemID = 19332
    elseif (option == 8) then -- Side-sword
        ItemID = 19337
    elseif (option == 12) then -- Break Blade
        ItemID = 19342
    elseif (option == 16) then -- Chopper
        ItemID = 19347
    elseif (option == 20) then -- Lumberjack
        ItemID = 19352
    elseif (option == 24) then -- Farmhand
        ItemID = 19357
    elseif (option == 28) then -- Ranseur
        ItemID = 19362
    elseif (option == 32) then -- KibaShiri
        ItemID = 19367
    elseif (option == 36) then -- Donto
        ItemID = 19372
    elseif (option == 40) then -- Stenz
        ItemID = 19377
    elseif (option == 44) then -- Crook
        ItemID = 19382
    elseif (option == 48) then -- Sparrow
        ItemID = 19387
    elseif (option == 52) then -- Thunderstick
        ItemID = 19392
--------------------
    -- Page 2
--------------------
    elseif (option == 64) then -- Barracudas
        ItemID = 19415
    elseif (option == 68) then -- Fusetto
        ItemID = 19419
    elseif (option == 72) then -- Machaera
        ItemID = 19423
    elseif (option == 76) then -- Kalavejs
        ItemID = 19427
    elseif (option == 80) then -- Renausd's Axe
        ItemID = 19431
    elseif (option == 84) then -- Sumaru
        ItemID = 19435
    elseif (option == 88) then -- Reckoning
        ItemID = 19439
    elseif (option == 92) then -- Stingray
        ItemID = 19443
    elseif (option == 96) then -- Uzuru
        ItemID = 19447
    elseif (option == 100) then -- Keitonotachi
        ItemID = 19451
    elseif (option == 104) then -- Makhila
        ItemID = 19455
    elseif (option == 108) then -- Sedikutchi
        ItemID = 18932
    elseif (option == 112) then -- Sparrowhawk
        ItemID = 18936
    elseif (option == 116) then -- Anachry
        ItemID = 18940
--------------------
    -- Page 3
--------------------
    elseif (option == 128) then -- Dumuzis -1
        ItemID = 20544
    elseif (option == 132) then -- Khandroma -1
        ItemID = 20631
    elseif (option == 140) then -- Brunello -1
        ItemID = 20732
    elseif (option == 144) then -- Xiphias -1
        ItemID = 20769
    elseif (option == 148) then -- Sacripante -1
        ItemID = 20821
    elseif (option == 152) then -- Shamash -1
        ItemID = 20867
    elseif (option == 156) then -- Umiliati -1
        ItemID = 20912
    elseif (option == 160) then -- Daboya -1
        ItemID = 20959
    elseif (option == 164) then -- Kasasagi -1
        ItemID = 21001
    elseif (option == 168) then -- Torigashiranotachi -1
        ItemID = 21048
    elseif (option == 172) then -- Rose Couverte -1
        ItemID = 21121
    elseif (option == 176) then -- Circinae -1
        ItemID = 21234
    elseif (option == 180) then -- Mollfrith -1
        ItemID = 21283
    end

    if (option ~= 1073741824) then
        if (player:getFreeSlotsCount() >= 1 and player:hasItem(ItemID) == false) then
            player:addItem(ItemID, 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, ItemID)
        elseif (ItemID == 0) then
            -- How did you get here??
            player:PrintToPlayer( "ItemID or OptionID related script error!" )
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, ItemID)
        end
    end

end
