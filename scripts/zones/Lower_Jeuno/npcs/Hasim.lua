-----------------------------------
-- Area: Lower Jeuno
--  NPC: Hasim
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4612,  23400,    -- Scroll of Cure IV
        4616,  11200,    -- Scroll of Curaga II
        4617,  19932,    -- Scroll of Curaga III
        4625,   2330,    -- Scroll of Silena
        4626,  19200,    -- Scroll of Stona
        4627,  13300,    -- Scroll of Viruna
        4628,   8586,    -- Scroll of Cursna
        4653,  32000,    -- Scroll of Protect III
        4734,   7074,    -- Scroll of Protectra II
        4735,  19200,    -- Scroll of Protectra III
        4658,  26244,    -- Scroll of Shell III
        4738,   1760,    -- Scroll of Shellra
        4739,  14080,    -- Scroll of Shellra II
        4740,  26244,    -- Scroll of Shellra III
        4668,   1760,    -- Scroll of Barfire
        4669,   3624,    -- Scroll of Barblizzard
        4670,    930,    -- Scroll of Baraero
        4671,    156,    -- Scroll of Barstone
        4672,   5754,    -- Scroll of Barthunder
        4673,    360,    -- Scroll of Barwater
        4674,   1760,    -- Scroll of Barfira
        4675,   3624,    -- Scroll of Barblizzara
        4676,    930,    -- Scroll of Baraera
        4677,    156,    -- Scroll of Barstonra
        4678,   5754,    -- Scroll of Barthundra
        4679,    360,    -- Scroll of Barwatera
        4680,    244,    -- Scroll of Barsleep
        4681,    400,    -- Scroll of Barpoison
        4682,    780,    -- Scroll of Barparalyze
        4683,   2030,    -- Scroll of Barblind
        4684,   4608,    -- Scroll of Barsilence
        4694,    244,    -- Scroll of Barsleepra
        4695,    400,    -- Scroll of Barpoisonra
        4696,    780,    -- Scroll of Barparalyzra
        4697,   2030,    -- Scroll of Barblindra
        4698,   4608,    -- Scroll of Barsilencera
        4685,  15120,    -- Scroll of Barpetrify
        4686,   9600,    -- Scroll of Barvirus
        4699,  15120,    -- Scroll of Barpetra
        4700,   9600,    -- Scroll of Barvira
        5089,  73740,    -- Scroll of Gain-VIT
        5092,  77500,    -- Scroll of Gain-MND
        5090,  85680,    -- Scroll of Gain-AGI
        5093,  81900,    -- Scroll of Gain-CHR
        5087,  89804,    -- Scroll of Gain-STR
        5091,  94461,    -- Scroll of Gain-INT
        5088,  99613,    -- Scroll of Gain-DEX
        5096,  73740,    -- Scroll of Boost-VIT
        5099,  77500,    -- Scroll of Boost-MND
        5097,  85680,    -- Scroll of Boost-AGI
        5100,  81900,    -- Scroll of Boost-CHR
        5094,  89804,    -- Scroll of Boost-STR
        5098,  94461,    -- Scroll of Boost-INT
        5095,  99613,    -- Scroll of Boost-DEX
        5106,  73500,    -- Scroll of Inundation
        4849, 130378,    -- Scroll of Addle
        4629,  35000,    -- Scroll of Holy
        4647,  20000,    -- Scroll of Banishga II
        4737, 119240,    -- Scroll of Protecra V
        4742, 124540,    -- Scroll of Shellra V
        4633, 139135,    -- Scroll of Dia III
        6569, 139135,    -- Scroll of Slow II
        6570, 139135,    -- Scroll of Paralyze II
        6571, 139135,    -- Scroll of Phalanx II
    }

    player:showText(npc, ID.text.HASIM_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
