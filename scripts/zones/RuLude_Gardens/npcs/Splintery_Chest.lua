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
    local optionTable =
    {
        [0] = 19327, -- Pugilists
        [4] = 19332, -- Peeler
        [8] = 19337, -- Side-sword
        [12] = 19342, -- Break Blade
        [16] = 19347, -- Chopper
        [20] = 19352, -- Lumberjack
        [24] = 19357, -- Farmhand
        [28] = 19362, -- Ranseur
        [32] = 19367, -- KibaShiri
        [36] = 19372, -- Donto
        [40] = 19377, -- Stenz
        [44] = 19382, -- Crook
        [48] = 19387, -- Sparrow
        [52] = 19392, -- Thunderstick
    --------------------
        -- Page 2
    --------------------
        [64] = 19415, -- Barracudas
        [68] = 19419, -- Fusetto
        [72] = 19423, -- Machaera
        [76] = 19427, -- Kalavejs
        [80] = 19431, -- Renausd's Axe
        [84] = 19435, -- Sumaru
        [88] = 19439, -- Reckoning
        [92] = 19443, -- Stingray
        [96] = 19447, -- Uzuru
        [100] = 19451, -- Keitonotachi
        [104] = 19455, -- Makhila
        [108] = 18932, -- Sedikutchi
        [112] = 18936, -- Sparrowhawk
        [116] = 18940, -- Anachry
    --------------------
        -- Page 3
    --------------------
        [128] = 20544, -- Dumuzis -1
        [132] = 20631, -- Khandroma -1
        [140] = 20732, -- Brunello -1
        [144] = 20769, -- Xiphias -1
        [148] = 20821, -- Sacripante -1
        [152] = 20867, -- Shamash -1
        [156] = 20912, -- Umiliati -1
        [160] = 20959, -- Daboya -1
        [164] = 21001, -- Kasasagi -1
        [168] = 21048, -- Torigashiranotachi -1
        [172] = 21121, -- Rose Couverte -1
        [176] = 21234, -- Circinae -1
        [180] = 21283, -- Mollfrith -1
    }

    itemId = optionTable[option]
    if (option ~= 1073741824) then
        if (not itemId) then
            -- How did you get here??
            player:PrintToPlayer( "itemId or OptionID related script error!" )
        elseif player:getFreeSlotsCount() >= 1 then
            player:addItem(itemId,1)
            player:messageSpecial(ID.text.ITEM_OBTAINED,itemId)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED,itemId)
        end
    end
end
