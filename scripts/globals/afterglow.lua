require("scripts/globals/gear_sets")
-----------------------------------

xi = xi or {}
xi.afterglow = xi.afterglow or {}

xi.afterglow.onTrigger = function(player)
    -- add afterglow effect if player has it unlocked
    
    local rTable = 
    {-- Ranged weapons need to be on a separate loop
        [1] = { "hasLastStandUnlock",    19007, 107 }, -- death_penalty
        [2] = { "hasLastStandUnlock",    18336, 103 }, -- annihilator
        [3] = { "hasApexArrowUnlock",    18348, 104 }, -- yoichinoyumi
    }    
    
    local rangedWeapon     = player:getEquipID(xi.slot.RANGED)
    local expectedWeapon = 0
    
    for i = 1, 3 do
        expectedWeapon = rTable[i][2]
    
        if rangedWeapon == expectedWeapon and player:getCharVar(rTable[i][1]) == 1 then
            printf("Applying afterglow for %s...", player:getName())
            player:setModelId(rTable[i][3], 2)
            break
        end
    end
    
    local pTable =
    {
    -- [Iterator] = {varName, weaponId, animation},
        -- Mythic weapons
        [1 ] = { "hasExenteratorUnlock",  18989, 569 }, -- terpsichore
        [2 ] = { "hasShattersoulUnlock",  18990, 570 }, -- tupsimati
        [3 ] = { "hasUpheavalUnlock",     18991, 555 }, -- conquerer
        [4 ] = { "hasShijinSpiralUnlock", 18992, 496 }, -- glanzfaust
        [5 ] = { "hasRealmrazerUnlock",   18993, 556 }, -- yagrush
        [6 ] = { "hasShattersoulUnlock",  18994, 557 }, -- laevateinn
        [7 ] = { "hasRequiescatUnlock",   18995, 558 }, -- murgleis
        [8 ] = { "hasExenteratorUnlock",  18996, 559 }, -- vajra
        [9 ] = { "hasRequiescatUnlock",   18997, 560 }, -- burtgang
        [10] = { "hasEntropyUnlock",      18998, 561 }, -- liberator
        [11] = { "hasRuinatorUnlock",     18999, 562 }, -- aymur
        [12] = { "hasExenteratorUnlock",  19000, 563 }, -- carnwenhan
        [13] = { "hasLastStandUnlock",    19001, 106 }, -- gastraphetes
        [14] = { "hasTachiShohaUnlock",   19002, 564 }, -- kogarasumaru
        [15] = { "hasBladeShunUnlock",    19003, 565 }, -- nagi
        [16] = { "hasStadiverUnlock",     19004, 566 }, -- ryunohige
        [17] = { "hasShattersoulUnlock",  19005, 567 }, -- nirvana
        [18] = { "hasRequiescatUnlock",   19006, 568 }, -- tizona
        [19] = { "hasLastStandUnlock",    19007, 107 }, -- death_penalty
        [20] = { "hasShijinSpiralUnlock", 19008, 495 }, -- kenkonken
        -- Relic weapons
        [21] = { "hasShijinSpiralUnlock", 18264, 497 }, -- spharai
        [22] = { "hasExenteratorUnlock",  18270, 544 }, -- mandau
        [23] = { "hasRequiescatUnlock",   18276, 545 }, -- excalibur
        [24] = { "hasResolutionUnlock",   18282, 546 }, -- ragnarok
        [25] = { "hasRuinatorUnlock",     18288, 547 }, -- guttler
        [26] = { "hasUpheavalUnlock",     18294, 548 }, -- bravura
        [27] = { "hasStadiverUnlock",     18300, 549 }, -- gungnir
        [28] = { "hasEntropyUnlock",      18306, 550 }, -- apocalypse
        [29] = { "hasBladeShunUnlock",    18312, 551 }, -- kikoku
        [30] = { "hasTachiShohaUnlock",   18318, 552 }, -- amanomurakumo
        [31] = { "hasRealmrazerUnlock",   18324, 553 }, -- mjollnir
        [32] = { "hasShattersoulUnlock",  18330, 554 }, -- claustrum
    }
    
    local mainWeapon     = player:getEquipID(xi.slot.MAIN)
    local rangedWeapon   = player:getEquipID(xi.slot.RANGED)
    local expectedWeapon = 0
    
    for i = 1, 32 do
        expectedWeapon = pTable[i][2]
    
        if mainWeapon == expectedWeapon and player:getCharVar(pTable[i][1]) == 1 then
            printf("Applying afterglow for %s...", player:getName())
            player:setModelId(pTable[i][3], 0)
            break
        end
    end
end
