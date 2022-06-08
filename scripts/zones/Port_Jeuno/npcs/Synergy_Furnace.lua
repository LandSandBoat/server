-----------------------------------
-- Area: Port Jeuno
--  NPC: Synergy Furnace
-- !pos  -52 0 -11 246
-- NOTE (324,0,0,0,0,0); -- Call Beast ability delay -1 IS NOT CODED
-- All super OP augments (like Haste, dual wield, triple attack, fast cast, etc, have been hard capped at +3% for HQ3
-- Don't ask me because I won't remember.
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/npc_util")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------

local entity = {}

local augmentTable =
{
    [12434] = { 54, 195,  53,  31}, -- *Genbu's Kabuto*
    [12296] = { 35, 323,  83,  79}, -- *Genbu's Shield*
    [12946] = {140, 134,  37, 117}, -- *Suzaku's Sune-Ate*
    [18043] = { 49, 512, 516, 517}, -- *Suzaku's Scythe*
    [12690] = { 41,  25,  23,  31}, -- *Seiryu's Kote*
    [17659] = { 146, 515, 23,  41}, -- *Seiryu's Sword*                  -- NOT RETAIL
    [12818] = {328, 514, 515, 517}, -- *Byakko's Haidate*
    [18198] = { 41, 514, 515, 133}, -- *Byakko's Axe*

    [13927] = { 25, 514, 516, 518}, -- *Hecatomb Cap*
    [13928] = { 25, 514, 516, 518}, -- *Hecatomb Cap+1*
    [14378] = {142, 333,  25, 115}, -- *Hecatomb Harness*
    [14379] = {142, 333,  25, 115}, -- *Hecatomb Harness+1*
    [14076] = { 23, 258, 259, 261}, -- *Hecatomb Mittens*
    [14077] = { 23, 258, 259, 261}, -- *Hecatomb Mittens+1*
    [14308] = { 23, 195,  31,  96}, -- *Hecatomb Subligar*
    [14309] = { 23, 195,  31,  96}, -- *Hecatomb Subligar+1*
    [14180] = { 25, 264, 263, 262}, -- *Hecatomb Leggings*
    [14181] = { 25, 264, 263, 262}, -- *Hecatomb Leggings+1*

    [12421] = { 42, 153, 329,  56}, -- *Koenig Schaller*
    [13911] = { 42, 153, 329,  56}, -- *Kaiser Schaller*
    [12549] = {141,  53,  39, 138}, -- *Koenig Cuirass*
    [14370] = {141,  53,  39, 138}, -- *Kaiser Cuirass*
    [12677] = { 83, 286,  23,  39}, -- *Koenig Handschuhs*
    [14061] = { 83, 286,  23,  39}, -- *Kaiser Handschuhs*
    [12805] = { 31,  83, 288, 289}, -- *Koenig Diechlings*
    [14283] = { 31,  83, 288, 289}, -- *Kaiser Handschuhs*
    [12933] = { 49,  23,  25,  31}, -- *Koenig Schuhs*
    [14163] = { 49,  23,  25,  31}, -- *Kaiser Schuhs*

    [12429] = {177, 141,  52,  35}, -- *Adaman Celata*
    [13924] = {177, 141,  52,  35}, -- *Armada Celata*
    [12557] = { 83, 142, 195,  79}, -- *Adaman Hauberk*
    [14371] = { 83, 142, 195,  79}, -- *Armada Hauberk*
    [12685] = {513, 514, 515, 518}, -- *Adaman Mufflers*
    [14816] = {513, 514, 515, 518}, -- *Armada Mufflers*
    [12813] = {107, 333,  40, 516}, -- *Adaman Breeches*
    [14296] = {107, 333,  40, 516}, -- *Armada Breeches*
    [12941] = {518, 324,  99, 116}, -- *Adaman Sollerets*
    [14175] = {518, 324,  99, 116}, -- *Armada Sollerets*

    [13934] = {513, 332, 333,  25}, -- *Shura Zunari Kabuto*
    [13935] = {513, 332, 333,  25}, -- *Shura Zunari Kabuto+1*
    [14387] = {195,  41, 215,  31}, -- *Shura Togi*
    [14388] = {195,  41, 215,  31}, -- *Shura Togi+1*
    [14821] = { 42,  31,  53, 515}, -- *Shura Kote*
    [14822] = { 42,  31,  53, 515}, -- *Shura Kote+1*
    [14303] = { 27,  39, 142, 515}, -- *Shura Haidate*
    [14304] = { 27,  39, 142, 515}, -- *Shura Haidate+1*
    [14184] = {514, 143, 512, 515}, -- *Shura Sune-Ate*
    [14185] = {514, 143, 512, 515}, -- *Shura Sune-Ate+1*

    [13876] = {288,  57, 290, 293}, -- *Zenith Crown*
    [13877] = {288,  57, 290, 293}, -- *Zenith Crown+1*
    [13787] = {119, 140, 133,  35}, -- *Dalmatica*
    [13788] = {119, 140, 133,  35}, -- *Dalmatica+1*
    [14006] = {100,  40, 334, 141}, -- *Zenith Mitts*
    [14007] = {100,  40, 334, 141}, -- *Zenith Mitts+1*
    [14247] = { 51,  52, 298,  17}, -- *Zenith Slacks*
    [14248] = { 51,  52, 298,  17}, -- *Zenith Slacks+1*
    [14123] = {101, 329, 323, 289}, -- *Zenith Pumps*
    [14124] = {101, 329, 323, 289}, -- *Zenith Pumps+1*

    [13908] = {517,  27, 515, 325}, -- *Crimson Mask*
    [13909] = {517,  27, 515, 325}, -- *Crimson Mask+1*
    [14367] = {518, 512, 515,  23}, -- *Crimson Scale Mail*
    [14368] = {518, 512, 515,  23}, -- *Crimson Scale Mail+1*
    [14058] = {517, 282, 195,  40}, -- *Crimson Finger Gauntlets*
    [14059] = {517, 282, 195,  40}, -- *Crimson Finger Gauntlets+1*
    [14280] = {514,  31, 134,  37}, -- *Crimson Cuisses*
    [14281] = {514,  31, 134,  37}, -- *Crimson Cuisses+1*
    [14160] = {195,  23, 332, 142}, -- *Crimson Greaves*
    [14161] = {195,  23, 332, 142}, -- *Crimson Greaves+1*

    [16113] = {516, 517,  39,  55}, -- *Shadow Helm*
    [16114] = {516, 517,  39,  55}, -- *Valkyrie's Helm*
    [14573] = {198,  23, 134,  37}, -- *Shadow Breastplate*
    [14574] = {198,  23, 134,  37}, -- *Valkyrie's Breastplate*
    [14995] = {512, 260, 262, 263}, -- *Shadow Gauntlets*
    [14996] = {512, 260, 262, 263}, -- *Valkyrie's Gauntlets*
    [15655] = {293, 512, 514, 515}, -- *Shadow Cuishes*
    [15656] = {293, 512, 514, 515}, -- *Valkyrie's Cuishes*
    [15740] = {328, 195,  31,  27}, -- *Shadow Sabatons*
    [15741] = {328, 195,  31,  27}, -- *Valkyrie's Sabatons*

    [16115] = {297, 292, 290, 100}, -- *Shadow Hat*
    [16116] = {297, 292, 290, 100}, -- *Valkyrie's Hat*
    [14575] = { 57, 516, 517, 518}, -- *Shadow Coat*
    [14576] = { 57, 516, 517, 518}, -- *Valkyrie's Coat*
    [14997] = {141,  53,  83, 101}, -- *Shadow Cuffs*
    [14998] = {141,  53,  83, 101}, -- *Valkyrie's Cuffs*
    [15657] = {292,  97, 102, 320}, -- *Shadow Trews*
    [15658] = {292,  97, 102, 320}, -- *Valkyrie's Trews*
    [15742] = { 83, 288, 293, 291}, -- *Shadow Clogs*
    [15743] = { 83, 288, 293, 291}, -- *Valkyrie's Clogs*

    b1 = { 54,  25,  23,  31}, -- *Kirin's Osode (Genbu)*
    w1 = { 25,  23, 79, 514}, -- *Kirin's Pole (Genbu)*
    b2 = {328,  25,  23,  31}, -- *Kirin's Osode (Suzaku)*
    w2 = { 25,  23, 83, 512}, -- *Kirin's Pole (Suzaku)*
    b3 = { 29,  31,  23,  25}, -- *Kirin's Osode (Seiryu)*
    w3 = { 25,  23, 83, 515}, -- *Kirin's Pole (Seiryu)*
    b4 = { 41,  25,  23,  31}, -- *Kirin's Osode (Byakko)*
    w4 = {79,  25,  23, 513}, -- *Kirin's Pole (Byakko)*

    [19304] = { 23, 25, 512, 188}, -- *Sarissa*
    [18603] = { 133, 83, 516, 141}, -- *Majestas*
    [19159] = { 23, 25, 512, 188}, -- *Galatyn*
    [17765] = { 23, 299, 332, 512}, -- *Concordia*	
    [19118] = { 23, 25, 513, 515}, -- *Machismo*
}

local randomAug =
{
    r1 = {768, 769, 770, 771, 772, 773, 774, 775},
    --Resist Fire, Earth, Water, Wind, Thunder, Ice, Light, or Darkness
    r2 = {176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188},
    --Resist Sleep, Poison, Paralyze, Blind, Silence, Virus, Petrify, Bind, Curse, Gravity, Slow, Stun, Charm
    r3 = {133, 35, 25, 23, 27, 29, 31, 37},
    -- M.atk./M.acc/Atk./Acc/R.atk/R.acc/Eva./M.Eva
    r4 = {512, 513, 514, 515, 516, 517, 518},
    -- STR/DEX/INT/MND/CHR/VIT/AGI
}

local craftingStallRequirements =
{
--   [x] = {item1, Qty1, item2, Qty2, item3, Qty3, item4, Qty4, item5, Qty5, item6, Qty6, item7, Qty7 },
    [ 1] = { 4104,   12,   662,    3,   718,    2,   829,    1,  2000,    1,  3324,    1 },              -- Fire Cluster, Iron Sheet, Rosewood Lumber, Silk Cloth, Dark Adaman Ingot, Blacksmiths' Emblem
    [ 2] = { 4110,   12,   662,    3,   718,    2,   829,    1,   743,    1,  3325,    1 },              -- Light Cluster, Iron Sheet, Rosewood Lumber, Silk Cloth, Phrygian Gold Ingot, Goldsmiths' Emblem 
    [ 3] = { 4111,   12,   662,    3,   718,    2,   829,    1,  2147,    1,  3326,    1 },              -- Dark Cluster, Iron Sheet, Rosewood Lumber, Silk Cloth, Marid Tusk, Boneworkers' Emblem
    [ 4] = { 4107,   12,   654,    1,   708,    3,   745,    1,  1829,    1,  2200,    1,  3327,    1 }, -- Earth Cluster, Darksteel Ingot, Maple Lumber, Gold Ingot, Red Grass Cloth, Twill Damask, Weavers' Emblem
    [ 5] = { 4106,   12,   654,    1,   708,    3,   745,    1,  2200,    1,  4387,    1,  3328,    1 }, -- Wind Cluster, Darksteel Ingot, Maple Lumber, Gold Ingot, Red Grass Cloth, Wild Onion, Culinarians' Emblem
    [ 6] = { 4105,   12,   654,    1,   708,    3,   745,    1,  1829,    1,  1117,    1,  3329,    1 }, -- Ice Cluster, Darksteel Ingot, Maple Lumber, Gold Ingot, Red Grass Cloth, Manticore Leather, Tanners' Emblem 
    [ 7] = { 4109,   12,   709,    1,   716,    4,   824,    1, 17388,    1,  3330,    1 },              -- Water Cluster, Beech Lumber, Oak Lumber, Grass Cloth, Fastwater Fishing Rod, Fishermen's Emblem
    [ 8] = { 4107,   12,   709,    1,   716,    4,   824,    1,  1657,    1,  3331,    1 },              -- Earth Cluster, Beech Lumber, Oak Lumber, Grass Cloth, Bundling Twine, Carpenters' Emblem
    [ 9] = { 4108,   12,   709,    1,   716,    4,   824,    1,  4145,    1,  3332,    1 },              -- Lightning cluster, Beech Lumber, Oak Lumber, Grass Cloth, Elixir, Alchemists' Emblem
}

local function handleKirinItemCreation(player, itemId, au0, po0) -- This is for Kirin Items(God). Augment 0 will carry over from our NPC trade function.
    -- NQ: ~15%, HQ1: ~60%, HQ2: ~15%, HQ3: ~10%.
    math.randomseed(os.time())
    local HQ3 = 90
    local HQ2 = 85
    local HQ1 = 15
    local NQ  = 1

    local au1 = 0 -- Augment 1
    local po1 = 0 -- Augment 1 Power
    local au2 = 0 -- Augment 2
    local po2 = 0 -- Augment 2 Power

    local fuckery = math.random(100) -- HQ Roll Chance

-- Below is our check for what table we should roll. Rather than itemId index only we will check also check au0
    if itemId == 12562 and au0 == 137 then
        au1 = augmentTable.b1[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
        au2 = augmentTable.b1[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    elseif itemId == 12562 and au0 == 143 then
        au1 = augmentTable.b2[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
        au2 = augmentTable.b2[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    elseif itemId == 12562 and au0 == 211 then
        au1 = augmentTable.b3[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
        au2 = augmentTable.b3[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    elseif itemId == 12562 and au0 == 146 then
        au1 = augmentTable.b4[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
        au2 = augmentTable.b4[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    end

    if itemId == 17567 and au0 == 290 then
        au1 = augmentTable.w1[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
        au2 = augmentTable.w1[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    elseif itemId == 17567 and au0 == 292 then
        au1 = augmentTable.w2[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
        au2 = augmentTable.w2[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    elseif itemId == 17567 and au0 == 291 then
        au1 = augmentTable.w3[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
        au2 = augmentTable.w3[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    elseif itemId == 17567 and au0 == 294 then
        au1 = augmentTable.w4[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
        au2 = augmentTable.w4[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    end

-- ROLL AGAIN (TY Wadski)
    if au1 == au2 and itemId == 12562 and au0 == 137 then -- Check if augments are equal in value. If so we will reroll
    repeat
        au2 = augmentTable.b1[math.random(4)]
    until( au2 ~= au1)

    elseif au1 == au2 and itemId == 12562 and au0 == 143 then
    repeat
        au2 = augmentTable.b2[math.random(4)]
    until( au2 ~= au1)

    elseif au1 == au2 and itemId == 12562 and au0 == 211 then
    repeat
        au2 = augmentTable.b3[math.random(4)]
    until( au2 ~= au1)

    elseif au1 == au2 and itemId == 12562 and au0 == 146 then
    repeat
        au2 = augmentTable.b4[math.random(4)]
    until( au2 ~= au1)

    elseif au1 == au2 and itemId == 17567 and au0 == 290 then
    repeat
        au2 = augmentTable.w1[math.random(4)]
    until( au2 ~= au1)

    elseif au1 == au2 and itemId == 17567 and au0 == 292 then
    repeat
        au2 = augmentTable.w2[math.random(4)]
    until( au2 ~= au1)

    elseif au1 == au2 and itemId == 17567 and au0 == 291 then
    repeat
        au2 = augmentTable.w3[math.random(4)]
    until( au2 ~= au1)

    elseif au1 == au2 and itemId == 17567 and au0 == 294 then
    repeat
        au2 = augmentTable.w4[math.random(4)]
    until( au2 ~= au1)
    end

    if au1 > 0 then
        po1 = math.random(0, 2) -- AUGMENT 1 POWER (THIS IS OUR AUGMENT POWERS 1-3)
    end

    if au2 > 0 then
        po2 = math.random(0, 2) -- AUGMENT 2 POWER (THIS IS OUR AUGMENT POWERS 1-3)
    end

    if fuckery > HQ3 then -- Add +2 to each randomly selected augment and +2 to Item Base Augment POWERS
        po0 = po0 +2
        po1 = po1 +2
        po2 = po2 +2
        player:PrintToPlayer( "You have reached a HQ3 Augment! Please show us on Discord!", 0xd )
    elseif fuckery > HQ2 then -- Add +1 to Augment 1 and Augment 0 (Item Base augment) POWERS
        po0 = po0 +1
        po1 = po1 +1
        au2 = nil -- Remove Augment 2
        po2 = nil
        player:PrintToPlayer( "You have reached a HQ2 Augment!", 0xd )
    elseif fuckery > HQ1 then -- Remove Augment 2
        au2 = nil
        po2 = nil
        player:PrintToPlayer( "You have reached a HQ1 Augment!", 0xd )
    elseif fuckery > NQ then -- Remove Augment 0 (Item Base Augment)
        au0 = nil
        po0 = nil
        au2 = nil
        po2 = nil
        player:PrintToPlayer( "The Furnace has spoken! You can have the damaged NQ remains!", 0xd )
    end

    player:tradeComplete()
    player:addItem(itemId, 1, au0, po0, au1, po1, au2, po2)
    player:messageSpecial(ID.text.ITEM_OBTAINED, itemId)
end

local function handleHqItemCreation(player, itemId, au0, po0) -- This is for HQ items. Augment 0 will carry over from our NPC trade function.
    -- HQ items will roll upto +6 on all status
    -- NQ: ~15%, HQ1: ~60%, HQ2: ~15%, HQ3: ~10%.
    math.randomseed(os.time())
    local HQ3 = 90
    local HQ2 = 85
    local HQ1 = 15
    local NQ  = 1

    local au1 = 0 -- Augment 1
    local po1 = 0 -- Augment 1 Power
    local au2 = 0 -- Augment 2
    local po2 = 0 -- Augment 2 Power

    local fuckery = math.random(100) -- HQ Roll Chance

    au1 = augmentTable[itemId][math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    au2 = augmentTable[itemId][math.random(4)] -- We will randomly select a augment from our [itemId] = {table}

-- ROLL AGAIN (TY Wadski)
    if au1 == au2 then -- Check if augments are equal in value. If so we will reroll
    repeat
        au2 = augmentTable[itemId][math.random(4)]
    until( au2 ~= au1)
    end

    if au1 > 0 then
        po1 = math.random(0, 3) -- AUGMENT 1 POWER (THIS IS OUR AUGMENT POWERS 1-4)
    end

    if au2 > 0 then
        po2 = math.random(0, 3) -- AUGMENT 2 POWER (THIS IS OUR AUGMENT POWERS 1-4)
    end

    if fuckery > HQ3 then -- Add +2 to each randomly selected augment and +2 to Item Base Augment POWERS
        po0 = po0 +2
        po1 = po1 +2
        po2 = po2 +2
        player:PrintToPlayer( "You have reached a HQ3 Augment(HQ)! Please show us on Discord!", 0xd )
    elseif fuckery > HQ2 then -- Add +1 to Augment 1 and Augment 0 (Item Base augment) POWERS
        po0 = po0 +1
        po1 = po1 +1
        au2 = nil -- Remove Augment 2
        po2 = nil
        player:PrintToPlayer( "You have reached a HQ2 Augment(HQ)!", 0xd )
    elseif fuckery > HQ1 then -- Remove Augment 2
        au2 = nil
        po2 = nil
        player:PrintToPlayer( "You have reached a HQ1 Augment(HQ)!", 0xd )
    elseif fuckery > NQ then -- Remove Augment 0 (Item Base Augment)
        au0 = nil
        po0 = nil
        player:PrintToPlayer( "The Furnace has spoken! You can have the crispy NQ remains!", 0xd )
    end

    player:tradeComplete()
    player:addItem(itemId, 1, au0, po0, au1, po1, au2, po2)
    player:messageSpecial(ID.text.ITEM_OBTAINED, itemId)
end

local function handleAugmentedItemCreation(player, itemId, au0, po0)
-- NQ: ~15%, HQ1: ~60%, HQ2: ~15%, HQ3: ~10%.
    local HQ3 = 90
    local HQ2 = 85
    local HQ1 = 15
    local NQ  = 0

    local au1 = 0 -- Augment 1
    local po1 = 0 -- Augment 1 Power
    local au2 = 0 -- Augment 2
    local po2 = 0 -- AUgment 2 Power

    local fuckery = math.random(100) -- HQ Roll Chance

    au1 = augmentTable[itemId][math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    au2 = augmentTable[itemId][math.random(4)] -- We will randomly select a augment from our [itemId] = {table}

-- ROLL AGAIN (TY Wadski)
    if au1 == au2 then -- Check if augments are equal in value. If so we will reroll
    repeat
        au2 = augmentTable[itemId][math.random(4)]
    until( au2 ~= au1)
    end

    if au1 > 0 then
        po1 = math.random(0, 2) -- AUGMENT 1 POWER (THIS IS OUR AUGMENT POWERS 1-3)
    end

    if au2 > 0 then
        po2 = math.random(0, 2) -- AUGMENT 1 POWER (THIS IS OUR AUGMENT POWERS 1-3)
    end

    if fuckery > HQ3 then -- Add +2 to each randomly selected augment and +2 to Item Base Augment POWERS
        po0 = po0 +2
        po1 = po1 +2
        po2 = po2 +2
        player:PrintToPlayer( "You have reached a HQ3 Augment! Please show us on Discord!", 0xd )
    elseif fuckery > HQ2 then -- Add +1 to Augment 1 and Augment 0 (Item Base augment) POWERS
        po0 = po0 +1
        po1 = po1 +1
        au2 = nil -- Remove Augment 2
        po2 = nil
        player:PrintToPlayer( "You have reached a HQ2 Augment!", 0xd )
    elseif fuckery > HQ1 then -- Remove Augment 2
        au2 = nil
        po2 = nil
        player:PrintToPlayer( "You have reached a HQ1 Augment!", 0xd )
    elseif fuckery > NQ then -- Remove Augment 0 (Item Base Augment)
        au0 = nil
        po0 = nil
        au2 = nil
        po2 = nil
        player:PrintToPlayer( "The Furnace has spoken! You can have the damaged NQ remains!", 0xd )
    end

    player:tradeComplete()
    player:addItem(itemId, 1, au0, po0, au1, po1, au2, po2)
    player:messageSpecial(ID.text.ITEM_OBTAINED, itemId)
end

local function handleRandomAugment(player, itemId, au0, po0)
-- We are collecting au1 and po1 from the items augment table
    local ra1 = 0
    local rp1 = 0
    local au1 = 0
    local po1 = 0

    local random = math.random(6) -- How we pick a random augment table(4 tables and 2 for HP and or MP)
    local randomA = math.random(6) -- How we randomly reroll augments if val == val
    local randomB = math.random(4) -- This will be our HQ roll chance

    if itemId == 12562 and au0 == 137 then -- Kirin's Osode
        au1 = augmentTable.b1[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    elseif itemId == 12562 and au0 == 143 then
        au1 = augmentTable.b2[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    elseif itemId == 12562 and au0 == 211 then
        au1 = augmentTable.b3[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    elseif itemId == 12562 and au0 == 146 then
        au1 = augmentTable.b4[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}

    elseif itemId == 17567 and au0 == 290 then -- Kirin's Pole
        au1 = augmentTable.w1[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    elseif itemId == 17567 and au0 == 292 then
        au1 = augmentTable.w2[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    elseif itemId == 17567 and au0 == 291 then
        au1 = augmentTable.w3[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}
    elseif itemId == 17567 and au0 == 294 then
        au1 = augmentTable.w4[math.random(4)] -- We will randomly select a augment from our [itemId] = {table}

    elseif itemId ~= 12562 or 17567 then
        au1 = augmentTable[itemId][math.random(4)]
    end

    if au1 > 0 then
        po1 = math.random(0, 2) -- AUGMENT 1 POWER (THIS IS OUR AUGMENT POWERS 1-3)
    end

    -- AUGMENT 2 IS NOT NEEDED HERE

-- We will roll for a augment within randomtable
    if random == 1 then
        ra1 = randomAug.r1[math.random(8)] -- We will randomly select a augment from our [itemId] = {table}
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    elseif random == 2 then
        ra1 = randomAug.r2[math.random(13)] -- We will randomly select a augment from our [itemId] = {table}
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    elseif random == 3 then
        ra1 = randomAug.r3[math.random(8)] -- We will randomly select a augment from our [itemId] = {table}
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    elseif random == 4 then
        ra1 = randomAug.r4[math.random(7)] -- We will randomly select a augment from our [itemId] = {table}
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    elseif random == 5 then -- HP +3 augment roll
        ra1 = 79
        rp1 = math.random(0, 4) -- POWER IS CAPPED AT +15
    elseif random == 6 then -- MP +3 augment roll
        ra1 = 83
        rp1 = math.random(0, 4) -- POWER IS CAPPED AT +15
    end

-- We will check for augment 1 and Random Augment equality. If val == val we will reroll
    if ra1 == au1 and randomA == 1 then
    repeat
        ra1 = randomAug.r1[math.random(8)]
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    until( ra1 ~= au1 )

    elseif ra1 == au1 and randomA == 2 then
    repeat
        ra1 = randomAug.r2[math.random(13)]
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    until( ra1 ~= au1 )

    elseif ra1 == au1 and randomA == 3 then
    repeat
        ra1 = randomAug.r3[math.random(8)]
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    until( ra1 ~= au1 )

    elseif ra1 == au1 and randomA == 4 then
    repeat
        ra1 = randomAug.r4[math.random(7)]
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    until( ra1 ~= au1 )

    elseif ra1 == au1 and randomA == 5 then
    repeat
        ra1 = 79
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    until( ra1 ~= au1 )

    elseif ra1 == au1 and randomA == 6 then
    repeat
        ra1 = 83
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    until( ra1 ~= au1 )
    end
-- We will check for augment 0 (Item Base Augment) and Random Augment equality. If val == val we will reroll
    if ra1 == au0 and randomA == 1 then
    repeat
        ra1 = randomAug.r1[math.random(8)]
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    until( ra1 ~= au0 )

    elseif ra1 == au0 and randomA == 2 then
    repeat
        ra1 = randomAug.r2[math.random(13)]
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    until( ra1 ~= au0 )

    elseif ra1 == au0 and randomA == 3 then
    repeat
        ra1 = randomAug.r3[math.random(8)]
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    until( ra1 ~= au0 )

    elseif ra1 == au0 and randomA == 4 then
    repeat
        ra1 = randomAug.r4[math.random(7)]
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    until( ra1 ~= au0 )

    elseif ra1 == au0 and randomA == 5 then
    repeat
        ra1 = 79
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    until( ra1 ~= au0 )

    elseif ra1 == au0 and randomA == 6 then
    repeat
        ra1 = 83
        rp1 = math.random(0, 4) -- RANDOM AUGMENT POWER (THIS IS OUR AUGMENT POWERS 1-5)
    until( ra1 ~= au0 )
    end

    -- HQ Roll of Random Augment Pool
    if randomB == 1 then -- nope
        au0 = nil
        po0 = nil
        au1 = nil
        po1 = nil
        player:PrintToPlayer( "Your item has been damaged! A Random Augment has remained!", 0xd )
    elseif randomB == 2 then -- 1 augment lost
        au1 = nil
        po1 = nil
        player:PrintToPlayer( "Randomizing your items base Augment with a Randomly selected Augment!", 0xd )
    elseif randomB == 3 then -- RIP Random Aug
        ra1 = nil
        rp1 = nil
        player:PrintToPlayer( "You have lost the Random Augment! Your item was saved by the Furnace!", 0xd )
    elseif randomB == 4 then -- Two Augs with one random aug (rare)
        po0 = po0 + 2
        po1 = po1 + 2
        player:PrintToPlayer( "You have reached a HQ Random Augment! The Furnace approves!", 0xd )
    end

    player:tradeComplete()
    player:addItem(itemId, 1, au0, po0, au1, po1, ra1, rp1)
    player:messageSpecial(ID.text.ITEM_OBTAINED, itemId)
end

entity.onTrade = function(player, npc, trade)
    local randomC = math.random(100)

    local itemId = 0
    local au0 = 0 -- Augments from table randomly selected
    local po0 = 0 -- Power randomly selected
    local augId = 0

-- Crafting Stalled: Credit Graves
    for i = 1, 9 do -- This variable "i" will be the index in the table.
        local reward = 3624 + i

        if i >= 4 and i <= 6 then
            if
                npcUtil.tradeHasExactly(trade,
                {
                    {craftingStallRequirements[i][1], craftingStallRequirements[i][2]},
                    {craftingStallRequirements[i][3], craftingStallRequirements[i][4]},
                    {craftingStallRequirements[i][5], craftingStallRequirements[i][6]},
                    {craftingStallRequirements[i][7], craftingStallRequirements[i][8]},
                    {craftingStallRequirements[i][9], craftingStallRequirements[i][10]},
                    {craftingStallRequirements[i][11], craftingStallRequirements[i][12]},
                    {craftingStallRequirements[i][13], craftingStallRequirements[i][14]},
                })
            then
                player:tradeComplete()
                player:addItem(reward)
                player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
            
                break
            end
        else
            if
                npcUtil.tradeHasExactly(trade,
                {
                    {craftingStallRequirements[i][1], craftingStallRequirements[i][2]},
                    {craftingStallRequirements[i][3], craftingStallRequirements[i][4]},
                    {craftingStallRequirements[i][5], craftingStallRequirements[i][6]},
                    {craftingStallRequirements[i][7], craftingStallRequirements[i][8]},
                    {craftingStallRequirements[i][9], craftingStallRequirements[i][10]},
                    {craftingStallRequirements[i][11], craftingStallRequirements[i][12]},
                })
            then
                player:tradeComplete()
                player:addItem(reward)
                player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
            
                break
            end
        end
    end
-- End Crafting Stalls
--------------------------------------------------------------------------------------------------
    -- *Genbu's Kabuto*
    if randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12434, 3275}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12434
            au0 = 49 -- + 1-3% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12434, 3275}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12434
            au0 = 49 -- + 1-3% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Genbu's Shield*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12296, 3275}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12296
            au0 = 329 -- + 1-3% Cure Potency. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12296, 3275}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12296
            au0 = 329 -- + 1-3% Cure Potency. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Suzaku's Sune-Ate*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12946, 3276}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12946
            au0 = 49 -- + 1-3% Haste. Guaranteed.
--            po0 = math.random(0, 2)
            po0 = 0 -- This should cap out at 3% haste

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12946, 3276}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12946
            au0 = 49 -- + 1-3% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Suzaku's Scythe*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {18043, 3276}) and player:getFreeSlotsCount() >= 1 then
            itemId = 18043
            au0 = 45 -- + 1-16 Base Damage. Guaranteed.
            po0 = math.random(0, 15)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {18043, 3276}) and player:getFreeSlotsCount() >= 1 then
            itemId = 18043
            au0 = 45 -- + 1-16 Base Damage. Guaranteed.
            po0 = math.random(0, 15)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Seiryu's Kote*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12690, 3277}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12690
            au0 = 142 -- + 1-3 Store TP. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12690, 3277}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12690
            au0 = 142 -- + 1-3 Store TP. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Seiryu's Sword* NOTE THIS IS NOT RETAIL. CHECK AUGMENT TABLE
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {17659, 3277}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17659
            au0 = 45 -- + 1-16 Base Damage. Guaranteed.
            po0 = math.random(0, 15)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {17659, 3277}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17659
            au0 = 45 -- + 1-16 Base Damage. Guaranteed.
            po0 = math.random(0, 15)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Byakko's Haidate*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12818, 3278}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12818
            au0 = 142 -- + 1-3 Store TP. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12818, 3278}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12818
            au0 = 142 -- + 1-3 Store TP. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Byakko's Axe* NOTE THIS IS NOT RETAIL. CHECK AUGMENT TABLE
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {18198, 3278}) and player:getFreeSlotsCount() >= 1 then
            itemId = 18198
            au0 = 45 -- + 1-16 Base Damage. Guaranteed.
            po0 = math.random(0, 15)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {18198, 3278}) and player:getFreeSlotsCount() >= 1 then
            itemId = 18198
            au0 = 45 -- + 1-16 Base Damage. Guaranteed.
            po0 = math.random(0, 15)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Zenith Crown* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {13876, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13876
            au0 = 133 --- + 1-3 Magic Attack Bonus. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {13876, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13876
            au0 = 133 --- + 1-3 Magic Attack Bonus. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {13877, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13877
            au0 = 133 --- + 1-4 Magic Attack Bonus. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {13877, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13877
            au0 = 133 --- + 1-4 Magic Attack Bonus. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Dalmatica* or +1 (BiS item after augments consider nerfing)
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {13787, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13787
            au0 = 351 -- + 1-3% Occasionally Quickens Spellcasting. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {13787, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13787
            au0 = 351 -- + 1-3% Occasionally Quickens Spellcasting. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {13788, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13788
            au0 = 351 -- + 1-4% Occasionally Quickens Spellcasting. Guaranteed.
            po0 = 0

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {13788, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13788
            au0 = 351 -- + 1-4% Occasionally Quickens Spellcasting. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Zenith Mitts* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14006, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14006
            au0 = 516 -- + INT (1-3)
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14006, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14006
            au0 = 516 -- + INT (1-3)
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14007, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14007
            au0 = 516 -- + INT (1-4)
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14007, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14007
            au0 = 516 -- + INT (1-4)
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Zenith Slacks* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14247, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14247
            au0 = 322 -- + 1-3% Song Spellcasting Time -. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14247, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14247
            au0 = 322 -- + 1-3% Song Spellcasting Time -. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14248, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14248
            au0 = 322 -- + 1-4% Song Spellcasting Time -. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14248, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14248
            au0 = 322 -- + 1-4% Song Spellcasting Time -. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Zenith Pumps* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14123, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14123
            au0 = 294 -- Summoning Magic Skill (1-3)
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14123, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14123
            au0 = 294 -- Summoning Magic Skill (1-3)
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14124, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14124
            au0 = 294 -- Summoning Magic Skill (1-4)
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14124, 3283}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14124
            au0 = 294 -- Summoning Magic Skill (1-4)
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Hecatomb Cap* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {13927, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13927
            au0 = 143 -- + 1-3 Double Attack. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {13927, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13927
            au0 = 143 -- + 1-3 Double Attack. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {13928, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13928
            au0 = 143 -- + 1-4 Double Attack. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {13928, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13928
            au0 = 143 -- + 1-4 Double Attack. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Hecatomb Harness* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14378, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14378
            au0 = 513 -- + 1-3 DEX. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14378, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14378
            au0 = 513 -- + 1-3 DEX. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14379, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14379
            au0 = 513 -- + 1-4 DEX. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14379, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14379
            au0 = 513 -- + 1-4 DEX. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Hecatomb Mittens* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14076, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14076
            au0 = 328 -- + 1-3% Crit. Hit Damage. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14076, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14076
            au0 = 328 -- + 1-3% Crit. Hit Damage. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14077, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14077
            au0 = 328 -- + 1-4% Crit. Hit Damage. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14077, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14077
            au0 = 328 -- + 1-4% Crit. Hit Damage. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Hecatomb Subligar* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14308, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14308
            au0 = 41 -- + 1-3 Crit. Hit Rate. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14308, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14308
            au0 = 41 -- + 1-3 Crit. Hit Rate. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14309, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14309
            au0 = 41 -- + 1-4 Crit. Hit Rate. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14309, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14309
            au0 = 41 -- + 1-4 Crit. Hit Rate. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Hecatomb Leggings* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14180, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14180
            au0 = 512 -- + 1-3 STR. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14180, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14180
            au0 = 512 -- + 1-3 STR. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14181, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14181
            au0 = 512 -- + 1-4 STR. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14181, 3279}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14181
            au0 = 512 -- + 1-4 STR. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Koenig Schaller* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12421, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12421
            au0 = 140 -- + 1-3 Fast Cast. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12421, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12421
            au0 = 140 -- + 1-3 Fast Cast. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {13911, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13911
            au0 = 140 -- + 1-4 Fast Cast. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {13911, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13911
            au0 = 140 -- + 1-4 Fast Cast. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Koenig Cuirass* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12549, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12549
            au0 = 54 -- + 1-3% Physical Damage Taken -. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12549, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12549
            au0 = 54 -- + 1-3% Physical Damage Taken -. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14370, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14370
            au0 = 54 -- + 1-4% Physical Damage Taken -. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14370, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14370
            au0 = 54 -- + 1-4% Physical Damage Taken -. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Koenig Handschuhs* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12677, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12677
            au0 = 145 -- + 1-3 Counter. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12677, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12677
            au0 = 145 -- + 1-3 Counter. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14061, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14061
            au0 = 145 -- + 1-4 Counter. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14061, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14061
            au0 = 145 -- + 1-4 Counter. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Koenig Diechlings* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12805, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12805
            au0 = 55 -- + 1-3 Magic Damage Taken -. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12805, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12805
            au0 = 55 -- + 1-3 Magic Damage Taken -. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14283, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14283
            au0 = 55 -- + 1-4 Magic Damage Taken -. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14283, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14283
            au0 = 55 -- + 1-4 Magic Damage Taken -. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Koenig Schuhs* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12933, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12933
            au0 = 137 -- + 1-3 Regen. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12933, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12933
            au0 = 137 -- + 1-3 Regen. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14163, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14163
            au0 = 137 -- + 1-4 Regen. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14163, 3280}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14163
            au0 = 137 -- + 1-4 Regen. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Adaman Celata* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12429, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12429
            au0 = 293 -- + 1-3 Dark Magic Skill. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12429, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12429
            au0 = 293 -- + 1-3 Dark Magic Skill. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {13924, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13924
            au0 = 293 -- + 1-4 Dark Magic Skill. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {13924, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13924
            au0 = 293 -- + 1-4 Dark Magic Skill. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Adaman Hauberk* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12557, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12557
            au0 = 143 -- + 1-3 Double Attack. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12557, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12557
            au0 = 143 -- + 1-3 Double Attack. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14371, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14371
            au0 = 143 -- + 1-4 Double Attack. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14371, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14371
            au0 = 143 -- + 1-4 Double Attack. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Adaman Mufflers* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12685, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12685
            au0 = 49 -- + 1-3% Haste. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12685, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12685
            au0 = 49 -- + 1-3% Haste. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14816, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14816
            au0 = 49 -- + 1-4% Haste. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14816, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14816
            au0 = 49 -- + 1-4% Haste. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Adaman Breeches* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12813, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12813
            au0 = 512 -- + 1-3 STR. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12813, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12813
            au0 = 512 -- + 1-3 STR. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14296, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14296
            au0 = 512 -- + 1-4 STR. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14296, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14296
            au0 = 512 -- + 1-4 STR. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Adaman Sollerets* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12941, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12941
            au0 = 111 -- + 1-3% Pet: Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12941, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12941
            au0 = 111 -- + 1-3% Pet: Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14175, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14175
            au0 = 111 -- + 1-4% Pet: Haste. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14175, 3281}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14175
            au0 = 111 -- + 1-4% Pet: Haste. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shura Zunari Kabuto* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {13934, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13934
            au0 = 327 -- + 1-3% Weapon Skill Damage. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {13934, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13934
            au0 = 327 -- + 1-3% Weapon Skill Damage. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {13935, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13935
            au0 = 327 -- + 1-4% Weapon Skill Damage. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {13935, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13935
            au0 = 327 -- + 1-4% Weapon Skill Damage. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shura Togi* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14387, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14387
            au0 = 49 -- + 1-3% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14387, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14387
            au0 = 49 -- + 1-3% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14388, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14388
            au0 = 49 -- + 1-4% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14388, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14388
            au0 = 49 -- + 1-4% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shura Kote* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14821, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14821
            au0 = 145 -- + 1-3 Counter. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14821, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14821
            au0 = 145 -- + 1-3 Counter. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14822, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14822
            au0 = 145 -- + 1-4 Counter. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14822, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14822
            au0 = 145 -- + 1-4 Counter. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shura Haidate* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14303, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14303
            au0 = 146 -- + 1-3 Dual Weild. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14303, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14303
            au0 = 146 -- + 1-3 Dual Weild. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14304, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14304
            au0 = 146 -- + 1-4 Dual Weild. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14304, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14304
            au0 = 146 -- + 1-4 Dual Weild. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shura Sune-Ate* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14184, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14184
            au0 = 194 -- + 1-3 Kick Attacks. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14184, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14184
            au0 = 194 -- + 1-3 Kick Attacks. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14185, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14185
            au0 = 194 -- + 1-4 Kick Attacks. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14185, 3282}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14185
            au0 = 194 -- + 1-4 Kick Attacks. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Crimson Mask* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {13908, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13908
            au0 = 35 -- + 1-3 Magic Accuracy. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {13908, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13908
            au0 = 35 -- + 1-3 Magic Accuracy. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {13909, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13909
            au0 = 35 -- + 1-4 Magic Accuracy. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {13909, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 13909
            au0 = 35 -- + 1-4 Magic Accuracy. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Crimson Scale Mail* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14367, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14367
            au0 = 49 -- + 1-3% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14367, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14367
            au0 = 49 -- + 1-3% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14368, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14368
            au0 = 49 -- + 1-4% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14368, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14368
            au0 = 49 -- + 1-4% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Crimson Finger Gauntlets* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14058, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14058
            au0 = 211 -- + 1-3 Snapshot. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14058, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14058
            au0 = 211 -- + 1-3 Snapshot. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14059, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14059
            au0 = 211 -- + 1-4 Snapshot. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14059, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14059
            au0 = 211 -- + 1-4 Snapshot. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Crimson Cuisses* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14280, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14280
            au0 = 140 -- + 1-3 Fast Cast. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14280, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14280
            au0 = 140 -- + 1-3 Fast Cast. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14281, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14281
            au0 = 140 -- + 1-4 Fast Cast. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14281, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14281
            au0 = 140 -- + 1-4 Fast Cast. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Crimson Greaves* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14160, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14160
            au0 = 299 -- + 1-3 Blue Magic Skill. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14160, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14160
            au0 = 299 -- + 1-3 Blue Magic Skill. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14161, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14161
            au0 = 299 -- + 1-4 Blue Magic Skill. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14161, 3284}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14161
            au0 = 299 -- + 1-4 Blue Magic Skill. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shadow Hat* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {16115, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 16115
            au0 = 101 -- + 1-3 Pet: Magic Attack Bonus. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {16115, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 16115
            au0 = 101 -- + 1-3 Pet: Magic Attack Bonus. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {16116, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 16116
            au0 = 101 -- + 1-4 Pet: Magic Attack Bonus. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {16116, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 16116
            au0 = 101 -- + 1-4 Pet: Magic Attack Bonus. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shadow Coat* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14575, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14575
            au0 = 35 -- + 1-3 Magic Accuracy. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14575, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14575
            au0 = 35 -- + 1-3 Magic Accuracy. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14576, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14576
            au0 = 35 -- + 1-4 Magic Accuracy. Guaranteed.
            po0 = math.random(0, 2)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14576, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14576
            au0 = 35 -- + 1-4 Magic Accuracy. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shadow Cuffs* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14997, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14997
            au0 = 133 -- + 1-3 Magic Attack Bonus. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14997, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14997
            au0 = 133 -- + 1-3 Magic Attack Bonus. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14998, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14998
            au0 = 133 -- + 1-4 Magic Attack Bonus. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14998, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14998
            au0 = 133 -- + 1-4 Magic Attack Bonus. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shadow Trews* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {15657, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15657
            au0 = 133 -- + 1-3 Magic Attack Bonus. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {15657, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15657
            au0 = 133 -- + 1-3 Magic Attack Bonus. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {15658, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15658
            au0 = 133 -- + 1-4 Magic Attack Bonus. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {15658, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15658
            au0 = 133 -- + 1-4 Magic Attack Bonus. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shadow Clogs* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {15742, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15742
            au0 = 296 -- + 1-3 Singing Skill. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {15742, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15742
            au0 = 296 -- + 1-3 Singing Skill. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {15743, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15743
            au0 = 296 -- + 1-4 Singing Skill. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {15743, 3286}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15743
            au0 = 296 -- + 1-4 Singing Skill. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shadow Helm* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {16113, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 16113
            au0 = 138 -- + 1-3 Refresh. Guaranteed.
--            po0 = math.random(0, 2)
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {16113, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 16113
            au0 = 138 -- + 1-3 Refresh. Guaranteed.
--            po0 = math.random(0, 2)
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {16114, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 16114
            au0 = 138 -- + 1-4 Refresh. Guaranteed.
--            po0 = math.random(0, 3)
            po0 = 0
			
            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {16114, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 16114
            au0 = 138 -- + 1-4 Refresh. Guaranteed.
--            po0 = math.random(0, 3)
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shadow Breastplate* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14573, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14573
            au0 = 144 -- + 1-3 Triple Attack. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14573, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14573
            au0 = 144 -- + 1-3 Triple Attack. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14574, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14574
            au0 = 144 -- + 1-4 Triple Attack. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14574, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14574
            au0 = 144 -- + 1-4 Triple Attack. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shadow Gauntlets* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14995, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14995
            au0 = 143 -- + 1-3% Double Attack. Guaranteed.
            po0 = 0

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14995, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14995
            au0 = 143 -- + 1-3% Double Attack. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {14996, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14996
            au0 = 143 -- + 1-4% Double Attack. Guaranteed.
            po0 = math.random(0, 1)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {14996, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 14996
            au0 = 143 -- + 1-4% Double Attack. Guaranteed.
            po0 = math.random(0, 1)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shadow Cuishes* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {15655, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15655
            au0 = 49 -- + 1-3% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {15655, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15655
            au0 = 49 -- + 1-3% Haste. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {15656, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15656
            au0 = 49 -- + 1-4% Haste. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {15656, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15656
            au0 = 49 -- + 1-4% Haste. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Shadow Sabatons* or +1
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {15740, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15740
            au0 = 41 -- + 1-3% Crit. Hit Rate. Guaranteed.
            po0 = math.random(0, 2)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {15740, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15740
            au0 = 41 -- + 1-3% Crit. Hit Rate. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)

    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {15741, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15741
            au0 = 41 -- + 1-4% Crit. Hit Rate. Guaranteed.
            po0 = math.random(0, 3)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {15741, 3285}) and player:getFreeSlotsCount() >= 1 then
            itemId = 15741
            au0 = 41 -- + 1-4% Crit. Hit Rate. Guaranteed.
            po0 = math.random(0, 3)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
-- *Kirin's Osode (Genbu)*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12562, 3275}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12562
            au0 = 137 -- + 1-3 Regen. Guaranteed.
            po0 = math.random(0, 2)

            handleKirinItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12562, 3275}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12562
            au0 = 137 -- + 1-3 Regen. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-- *Kirin's Osode (Suzaku)*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12562, 3276}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12562
            au0 = 143 -- + 1-3 Double Attack. Guaranteed.
            po0 = 0

            handleKirinItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12562, 3276}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12562
            au0 = 143 -- + 1-3 Double Attack. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)
-- *Kirin's Osode (Seiryu)*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12562, 3277}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12562
            au0 = 211 -- + 1-3 Snapshot. Guaranteed.
            po0 = math.random(0, 2)

            handleKirinItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12562, 3277}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12562
            au0 = 211 -- + 1-3 Snapshot. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-- *Kirin's Osode (Byakko)*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {12562, 3278}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12562
            au0 = 146 -- + 1-3 Dual Weild. Guaranteed.
            po0 = 0

            handleKirinItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {12562, 3278}) and player:getFreeSlotsCount() >= 1 then
            itemId = 12562
            au0 = 146 -- + 1-3 Dual Weild. Guaranteed.
            po0 = 0

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
-- *Kirin's Pole (Genbu)*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {17567, 3275}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17567
            au0 = 290 -- + 1-3 Enhancing Magic Skill
            po0 = math.random(0, 2)

            handleKirinItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {17567, 3275}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17567
            au0 = 290 -- + 1-3 Enhancing Magic Skill
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-- *Kirin's Pole (Suzaku)*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {17567, 3276}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17567
            au0 = 292 -- + 1-3 Elemental Magic Skill
            po0 = math.random(0, 2)

            handleKirinItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {17567, 3276}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17567
            au0 = 292 -- + 1-3 Elemental Magic Skill
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-- *Kirin's Pole (Seiryu)*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {17567, 3277}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17567
            au0 = 291 -- + 1-3 Enfeebling Magic Skill
            po0 = math.random(0, 2)

            handleKirinItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {17567, 3277}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17567
            au0 = 291 -- + 1-3 Enfeebling Magic Skill
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-- *Kirin's Pole (Byakko)*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {17567, 3278}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17567
            au0 = 294 -- + 1-3 Summoning Magic Skill
            po0 = math.random(0, 2)

            handleKirinItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {17567, 3278}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17567
            au0 = 294 -- + 1-3 Summoning Magic Skill
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
-----------------------------------------------------------------------------------------------
    -- *Sarissa*
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 19307}) and player:getFreeSlotsCount() >= 1 then
            itemId = 19304
            au0 = 45 -- + 1-12 Base Damage. Guaranteed.
            po0 = math.random(0, 11)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 19307}) and player:getFreeSlotsCount() >= 1 then
            itemId = 19304
            au0 = 45 -- + 1-12 Base Damage. Guaranteed.
            po0 = math.random(0, 11)

            handleRandomAugment(player, itemId, au0, po0)
			
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 19304}) and player:getFreeSlotsCount() >= 1 then
            itemId = 19304
            au0 = 45 -- + 1-12 Base Damage. Guaranteed.
            po0 = math.random(0, 11)

            handleAugmentedItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 19304}) and player:getFreeSlotsCount() >= 1 then
            itemId = 19304
            au0 = 45 -- + 1-12 Base Damage. Guaranteed.
            po0 = math.random(0, 11)

            handleRandomAugment(player, itemId, au0, po0)			
-----------------------------------------------------------------------------------------------
    -- *Majestas* 
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 18617}) and player:getFreeSlotsCount() >= 1 then
            itemId = 18603
            au0 = 35 -- + 1-10 Magic Acc. Guaranteed.
            po0 = math.random(0, 9)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 18617}) and player:getFreeSlotsCount() >= 1 then
            itemId = 18603
            au0 = 35 -- + 1-10 Magic Acc. Guaranteed.
            po0 = math.random(0, 9)

            handleRandomAugment(player, itemId, au0, po0)
			
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 18603}) and player:getFreeSlotsCount() >= 1 then
            itemId = 18603
            au0 = 35 -- + 1-10 Magic Acc. Guaranteed.
            po0 = math.random(0, 9)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 18603}) and player:getFreeSlotsCount() >= 1 then
            itemId = 18603
            au0 = 35 -- + 1-10 Magic Acc. Guaranteed.
            po0 = math.random(0, 9)

            handleRandomAugment(player, itemId, au0, po0)			
-----------------------------------------------------------------------------------------------
    -- *Galatyn* 
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2858, 2859, 19162}) and player:getFreeSlotsCount() >= 1 then
            itemId = 19159
            au0 = 45 -- + 1-12 Base Damage. Guaranteed.
            po0 = math.random(0, 11)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2858, 2859, 19162}) and player:getFreeSlotsCount() >= 1 then
            itemId = 19159
            au0 = 45 -- + 1-12 Base Damage. Guaranteed.
            po0 = math.random(0, 11)

            handleRandomAugment(player, itemId, au0, po0)
			
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2858, 2859, 19159}) and player:getFreeSlotsCount() >= 1 then
            itemId = 19159
            au0 = 45 -- + 1-12 Base Damage. Guaranteed.
            po0 = math.random(0, 11)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2858, 2859, 19159}) and player:getFreeSlotsCount() >= 1 then
            itemId = 19159
            au0 = 45 -- + 1-12 Base Damage. Guaranteed.
            po0 = math.random(0, 11)

            handleRandomAugment(player, itemId, au0, po0)			
-----------------------------------------------------------------------------------------------
    -- *Concordia* 
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 2859, 17767}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17765
            au0 = 45 -- + 1-3 Base Damage. Guaranteed.
            po0 = math.random(0, 2)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 2859, 17767}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17765
            au0 = 45 -- + 1-3 Base Damage. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
			
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 2859, 17765}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17765
            au0 = 45 -- + 1-3 Base Damage. Guaranteed.
            po0 = math.random(0, 2)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 2859, 17765}) and player:getFreeSlotsCount() >= 1 then
            itemId = 17765
            au0 = 45 -- + 1-3 Base Damage. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)			
-----------------------------------------------------------------------------------------------
    -- *Machismo* 
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2859, 2859, 19128}) and player:getFreeSlotsCount() >= 1 then
            itemId = 19118
            au0 = 45 -- + 1-3 Base Damage. Guaranteed.
            po0 = math.random(0, 2)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2859, 2859, 19128}) and player:getFreeSlotsCount() >= 1 then
            itemId = 19118
            au0 = 45 -- + 1-3 Base Damage. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)
			
    elseif randomC > 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2859, 2859, 19118}) and player:getFreeSlotsCount() >= 1 then
            itemId = 19118
            au0 = 45 -- + 1-3 Base Damage. Guaranteed.
            po0 = math.random(0, 2)

            handleHqItemCreation(player, itemId, au0, po0)

        elseif randomC < 30 and
            npcUtil.tradeHasExactly(trade, {2858, 2859, 2859, 19118}) and player:getFreeSlotsCount() >= 1 then
            itemId = 19118
            au0 = 45 -- + 1-3 Base Damage. Guaranteed.
            po0 = math.random(0, 2)

            handleRandomAugment(player, itemId, au0, po0)			
-----------------------------------------------------------------------------------------------
-- FallBack
else
    player:PrintToPlayer( "This item combination is incorrect or not enough inventory space available.", 0xd ) -- OG CODE TY
    end
end

entity.onTrigger = function(player, npc)
    player:PrintToPlayer( "The Furnace is powered by the souls [GM]Xaver has collected.", 0xd )
end

return entity