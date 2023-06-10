--------------------------------------
-- Synergy Furnace 
-- Custom work of Neckbeard (CatsEyeXI)
-- Steal this and die.
--------------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/utils")
require("scripts/globals/status")
require("scripts/globals/zone")
--------------------------------------

xi = xi or {}
xi.synergyFurnace = xi.synergyFurnace or {}

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
    [12549] = {141,  53,  39,  55}, -- *Koenig Cuirass*
    [14370] = {141,  53,  39,  55}, -- *Kaiser Cuirass*
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

    [13908] = {517,  27, 515, 362}, -- *Crimson Mask*
    [13909] = {517,  27, 515, 362}, -- *Crimson Mask+1*
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
    [15657] = {292,  97, 102, 141}, -- *Shadow Trews*
    [15658] = {292,  97, 102, 141}, -- *Valkyrie's Trews*
    [15742] = { 83, 288, 293, 291}, -- *Shadow Clogs*
    [15743] = { 83, 288, 293, 291}, -- *Valkyrie's Clogs*

    b1 = { 54,  25, 23,  31 }, -- *Kirin's Osode (Genbu)*
    w1 = { 25,  23, 79, 514 }, -- *Kirin's Pole (Genbu)*
    b2 = {328,  25, 23,  31 }, -- *Kirin's Osode (Suzaku)*
    w2 = { 25,  23, 83, 512 }, -- *Kirin's Pole (Suzaku)*
    b3 = { 29,  31, 23,  25 }, -- *Kirin's Osode (Seiryu)*
    w3 = { 25,  23, 83, 515 }, -- *Kirin's Pole (Seiryu)*
    b4 = { 41,  25, 23,  31 }, -- *Kirin's Osode (Byakko)*
    w4 = { 79,  25, 23, 513 }, -- *Kirin's Pole (Byakko)*

    [19304] = {  23,  25, 512, 188 }, -- *Sarissa*
    [18603] = { 133,  83, 516, 141 }, -- *Majestas*
    [19159] = {  23,  25, 512, 188 }, -- *Galatyn*
    [17765] = {  23, 299, 332, 512 }, -- *Concordia*    
    [19118] = {  23,  25, 513, 515 }, -- *Machismo*
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
    [ 5] = { 4106,   12,   654,    1,   708,    3,   745,    1,  1829,    1,  4387,    1,  3328,    1 }, -- Wind Cluster, Darksteel Ingot, Maple Lumber, Gold Ingot, Red Grass Cloth, Wild Onion, Culinarians' Emblem
    [ 6] = { 4105,   12,   654,    1,   708,    3,   745,    1,  1829,    1,  1117,    1,  3329,    1 }, -- Ice Cluster, Darksteel Ingot, Maple Lumber, Gold Ingot, Red Grass Cloth, Manticore Leather, Tanners' Emblem 
    [ 7] = { 4109,   12,   709,    1,   716,    4,   824,    1, 17388,    1,  3330,    1 },              -- Water Cluster, Beech Lumber, Oak Lumber, Grass Cloth, Fastwater Fishing Rod, Fishermen's Emblem
    [ 8] = { 4107,   12,   709,    1,   716,    4,   824,    1,  1657,    1,  3331,    1 },              -- Earth Cluster, Beech Lumber, Oak Lumber, Grass Cloth, Bundling Twine, Carpenters' Emblem
    [ 9] = { 4108,   12,   709,    1,   716,    4,   824,    1,  4145,    1,  3332,    1 },              -- Lightning cluster, Beech Lumber, Oak Lumber, Grass Cloth, Elixir, Alchemists' Emblem
}

local craftingSmocks =
{
--   [x] = {item1, Qty1, item2, Qty2},
    [ 1] = { 4107,   12,   14392,    1 }, -- Earth Cluster, Carpenters Apron
    [ 2] = { 4104,   12,   14393,    1 }, -- Fire Cluster, Blacksmiths Apron
    [ 3] = { 4110,   12,   14394,    1 }, -- Light Cluster, Goldsmiths Apron
    [ 4] = { 4107,   12,   14395,    1 }, -- Earth Cluster, Weavers Apron 
    [ 5] = { 4105,   12,   14396,    1 }, -- Ice Cluster,  Tanners Apron 
    [ 6] = { 4111,   12,   14397,    1 }, -- Dark Cluster, Boneworkers Apron 
    [ 7] = { 4108,   12,   14398,    1 }, -- Lightning Cluster, Alchemists Apron 
    [ 8] = { 4106,   12,   14399,    1 }, -- Wind Cluster, Culinarians Apron 
    [ 9] = { 4109,   12,   14400,    1 }, -- Water Cluster, Fishermans Apron
}

local augmentLimits = {
    [ 41] = 2, -- Critical Hit Rate 1~3%
    [ 49] = 2, -- Haste 1~3%
    [ 57] = 3, -- Magic Critical Hit rate 1~4%
    [137] = 2, -- Regen 1~3
    [138] = 0, -- Refresh 1
    [140] = 2, -- Fast Cast 1~3%
    [143] = 2, -- Double Attack 1~3%
    [144] = 2, -- Triple Attack 1~3%
    [211] = 2, -- Snapshot 1~3
    [328] = 2  -- Critical Hit Damage 1~3%
}

------------------------------------------------------------
-- Limit power of augments to 3
------------------------------------------------------------
local function limitPower(aug, pow)
    if augmentLimits[aug] then
        if augmentLimits[aug] > 0 then
            pow = math.random(0, augmentLimits[aug])
        else
            pow = 0
        end
    end
    return pow
end

------------------------------------------------------------
-- Handle Kirin Item Creation
------------------------------------------------------------
local function handleKirinItemCreation(player, itemId, aug0, pow0)
    -- Define augment variables.
    local aug1 = 0
    local pow1 = math.random(0, 2)
    local aug2 = 0
    local pow2 = 0

    -- Define augment 1 and 2 based on item and existing augment 0.
    if itemId == 12562 then
        if aug0 == 137 then
            aug1 = augmentTable.b1[math.random(1, 4)]
            aug2 = augmentTable.b1[math.random(1, 4)]
            if aug1 == aug2 then
                repeat aug2 = augmentTable.b1[math.random(1, 4)]
                until(aug2 ~= aug1)
            end
        elseif aug0 == 143 then
            aug1 = augmentTable.b2[math.random(1, 4)]
            aug2 = augmentTable.b2[math.random(1, 4)]
            if aug1 == aug2 then
                repeat aug2 = augmentTable.b2[math.random(1, 4)]
                until(aug2 ~= aug1)
            end
        elseif aug0 == 146 then
            aug1 = augmentTable.b4[math.random(1, 4)]
            aug2 = augmentTable.b4[math.random(1, 4)]
            if aug1 == aug2 then
                repeat aug2 = augmentTable.b4[math.random(1, 4)]
                until(aug2 ~= aug1)
            end
        elseif aug0 == 211 then
            aug1 = augmentTable.b3[math.random(1, 4)]
            aug2 = augmentTable.b3[math.random(1, 4)]
            if aug1 == aug2 then
                repeat aug2 = augmentTable.b3[math.random(1, 4)]
                until(aug2 ~= aug1)
            end
        end

    elseif itemId == 17567 then
        if aug0 == 290 then
            aug1 = augmentTable.w1[math.random(1, 4)]
            aug2 = augmentTable.w1[math.random(1, 4)]
            if aug1 == aug2 then
                repeat aug2 = augmentTable.w1[math.random(1, 4)]
                until(aug2 ~= aug1)
            end
        elseif aug0 == 291 then
            aug1 = augmentTable.w3[math.random(1, 4)]
            aug2 = augmentTable.w3[math.random(1, 4)]
            if aug1 == aug2 then
                repeat aug2 = augmentTable.w3[math.random(1, 4)]
                until(aug2 ~= aug1)
            end
        elseif aug0 == 292 then
            aug1 = augmentTable.w2[math.random(1, 4)]
            aug2 = augmentTable.w2[math.random(1, 4)]
            if aug1 == aug2 then
                repeat aug2 = augmentTable.w2[math.random(1, 4)]
                until(aug2 ~= aug1)
            end
        elseif aug0 == 294 then
            aug1 = augmentTable.w4[math.random(1, 4)]
            aug2 = augmentTable.w4[math.random(1, 4)]
            if aug1 == aug2 then
                repeat aug2 = augmentTable.w4[math.random(1, 4)]
                until(aug2 ~= aug1)
            end
        end
    end

    -- Roll for quality.
    local qualityRoll = math.random(1, 100)

    if qualityRoll > 90 then     -- Add +2 to augment 0, 1 and 2 power.
        pow0 = pow0 + 2
        pow1 = pow1 + 2
        pow2 = math.random(0, 2) + 2
        player:PrintToPlayer( "You have reached a HQ3 Augment!", 0xd )
    elseif qualityRoll > 85 then -- Remove Augment 2. Add +1 to Augment 0 and 1 power.
        pow0 = pow0 + 1
        pow1 = pow1 + 1
        player:PrintToPlayer( "You have reached a HQ2 Augment!", 0xd )
    elseif qualityRoll > 15 then -- Remove Augment 2.
        aug2 = nil
        pow2 = nil
        player:PrintToPlayer( "You have reached a HQ1 Augment!", 0xd )
    else                         -- Remove Augment 0 and 2.
        aug0 = nil
        pow0 = nil
        aug2 = nil
        pow2 = nil
        player:PrintToPlayer( "The Furnace has spoken! You can have the damaged NQ remains!", 0xd )
    end

    pow0 = limitPower(aug0, pow0) -- Limit power
    pow1 = limitPower(aug1, pow1) -- Limit power
    pow2 = limitPower(aug2, pow2) -- Limit power
    player:tradeComplete()
    player:addItem(itemId, 1, aug0, pow0, aug1, pow1, aug2, pow2)
    player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, itemId)
end

------------------------------------------------------------
-- Handle HQ Item Creation
------------------------------------------------------------
local function handleHqItemCreation(player, itemId, aug0, pow0) -- This is for HQ items. Augment 0 will carry over from our NPC trade function.
    -- Define augment variables.
    local aug1 = augmentTable[itemId][math.random(1, 4)] -- Augment 1 happens always, so we define it now.
    local pow1 = math.random(1, 3)
    local aug2 = nil
    local pow2 = nil

    -- Roll for quality.
    local qualityRoll = math.random(1, 100)

    if qualityRoll > 5 then -- Add +2 to Augment 0, 1 and 2 power.
        pow0 = pow0 + 2
        pow1 = pow1 + 2
        aug2 = augmentTable[itemId][math.random(1, 4)]
        pow2 = 2 + math.random(1, 3)

        player:PrintToPlayer( "You have reached a HQ3 Augment(HQ)!", 0xd )
    elseif qualityRoll > 4 then -- Remove Augment 2. Add +1 to Augment 0 and Augment 1 power.
        pow0 = pow0 + 1
        pow1 = pow1 + 1

        player:PrintToPlayer( "You have reached a HQ2 Augment(HQ)!", 0xd )
    elseif qualityRoll > 2 then -- Remove Augment 2.
        player:PrintToPlayer( "You have reached a HQ1 Augment(HQ)!", 0xd )
    else -- Remove Augment 0.
        aug0 = nil
        pow0 = nil
        aug2 = augmentTable[itemId][math.random(1, 4)]
        pow2 = math.random(1, 3)

        player:PrintToPlayer( "The Furnace has spoken! You can have the crispy NQ remains!", 0xd )
    end

    if aug1 == aug2 then -- Check if augments are equal in value. If so we will reroll
        repeat aug2 = augmentTable[itemId][math.random(1, 4)]
        until(aug2 ~= aug1)
    end

    pow0 = limitPower(aug0, pow0) -- Limit power
    pow1 = limitPower(aug1, pow1) -- Limit power
    pow2 = limitPower(aug2, pow2) -- Limit power
    player:tradeComplete()
    player:addItem(itemId, 1, aug0, pow0, aug1, pow1, aug2, pow2)
    player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, itemId)
end

------------------------------------------------------------
-- Handle Augmented Item Creation
------------------------------------------------------------
local function handleAugmentedItemCreation(player, itemId, aug0, pow0)
    -- Define augment variables.
    local aug1 = augmentTable[itemId][math.random(1, 4)] -- Augment 1 happens always, so we define it now.
    local pow1 = math.random(0, 2)
    local aug2 = nil -- Augment 2 only happens 1 time, so we assume nil.
    local pow2 = nil

    -- Roll for quality.
    local qualityRoll = math.random(1, 100)

    if qualityRoll > 90 then     -- Add +2 to augment 0, 1 and 2 power.
        pow0 = pow0 + 2
        pow1 = pow1 + 2
        aug2 = augmentTable[itemId][math.random(1, 4)]
        pow2 = 2 + math.random(0, 2)
        if aug1 == aug2 then
            repeat aug2 = augmentTable[itemId][math.random(1, 4)]
            until(aug2 ~= aug1)
        end
        player:PrintToPlayer( "You have reached a HQ3 Augment!", 0xd )
    elseif qualityRoll > 85 then -- Remove Augment 2. Add +1 to Augment 0 and 1 power.
        pow0 = pow0 + 1
        pow1 = pow1 + 1
        player:PrintToPlayer( "You have reached a HQ2 Augment!", 0xd )
    elseif qualityRoll > 15 then -- Remove Augment 2.
        player:PrintToPlayer( "You have reached a HQ1 Augment!", 0xd )
    else                         -- Remove Augment 0 and 2.
        aug0 = nil
        pow0 = nil
        player:PrintToPlayer( "The Furnace has spoken! You can have the damaged NQ remains!", 0xd )
    end

    pow0 = limitPower(aug0, pow0) -- Limit power
    pow1 = limitPower(aug1, pow1) -- Limit power
    pow2 = limitPower(aug2, pow2) -- Limit power
    player:tradeComplete()
    player:addItem(itemId, 1, aug0, pow0, aug1, pow1, aug2, pow2)
    player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, itemId)
end

------------------------------------------------------------
-- Handle Random Augments
------------------------------------------------------------
local function handleRandomAugment(player, itemId, aug0, pow0)
    -- Define augment variables.
    local aug1 = 0
    local pow1 = 0
    local aug2 = 0
    local pow2 = 0

    -- Roll for quality.
    local qualityRoll = math.random(1, 4)

    if qualityRoll == 1 then     -- Nullify augments 0 and 1.
        aug0 = nil
        pow0 = nil
        aug1 = nil
        pow1 = nil
        player:PrintToPlayer( "Your item has been damaged! A Random Augment has remained!", 0xd )
    elseif qualityRoll == 2 then -- Nullify augment 1.
        aug1 = nil
        pow1 = nil
        player:PrintToPlayer( "Randomizing your items base Augment with a Randomly selected Augment!", 0xd )
    elseif qualityRoll == 3 then -- Nullify augment 2.
        aug2 = nil
        pow2 = nil
        player:PrintToPlayer( "You have lost the Random Augment! Your item was saved by the Furnace!", 0xd )
    else                         -- Enhances augment 0 and 1 power.
        pow0 = pow0 + 2
        pow1 = 2
        player:PrintToPlayer( "You have reached a HQ Random Augment! The Furnace approves!", 0xd )
    end

    -- Augment 1 work.
    if qualityRoll >= 3 then
        if itemId == 12562 then -- Kirin's Osode
            if aug0 == 137 then
                aug1 = augmentTable.b1[math.random(1, 4)] -- We will randomly select a augment from our [itemId] = {table}
            elseif aug0 == 143 then
                aug1 = augmentTable.b2[math.random(1, 4)] -- We will randomly select a augment from our [itemId] = {table}
            elseif aug0 == 211 then
                aug1 = augmentTable.b3[math.random(1, 4)] -- We will randomly select a augment from our [itemId] = {table}
            elseif aug0 == 146 then
                aug1 = augmentTable.b4[math.random(1, 4)] -- We will randomly select a augment from our [itemId] = {table}
            end
        elseif itemId == 17567 then -- Kirin's Pole
            if aug0 == 290 then
                aug1 = augmentTable.w1[math.random(1, 4)] -- We will randomly select a augment from our [itemId] = {table}
            elseif aug0 == 292 then
                aug1 = augmentTable.w2[math.random(1, 4)] -- We will randomly select a augment from our [itemId] = {table}
            elseif aug0 == 291 then
                aug1 = augmentTable.w3[math.random(1, 4)] -- We will randomly select a augment from our [itemId] = {table}
            elseif aug0 == 294 then
                aug1 = augmentTable.w4[math.random(1, 4)] -- We will randomly select a augment from our [itemId] = {table}
            end
        else
            aug1 = augmentTable[itemId][math.random(1, 4)]
        end

        -- Set power.
        pow1 = pow1 + math.random(0, 2)
    end

    -- Augment 2 work.
    if qualityRoll ~= 3 then
        local augmentRoll = math.random(1, 6) -- How we pick a random augment table (4 tables and 2 for HP and or MP)

        if augmentRoll == 1 then
            aug2 = randomAug.r1[math.random(1, 8)]
            if aug2 == aug0 or aug2 == aug1 then
                repeat aug2 = randomAug.r1[math.random(1, 8)]
                until(aug2 ~= aug0 and aug2 ~= aug1)
            end
        elseif augmentRoll == 2 then
            aug2 = randomAug.r2[math.random(1, 13)]
            if aug2 == aug0 or aug2 == aug1 then
                repeat aug2 = randomAug.r2[math.random(1, 13)]
                until(aug2 ~= aug0 and aug2 ~= aug1)
            end
        elseif augmentRoll == 3 then
            aug2 = randomAug.r3[math.random(1, 8)]
            if aug2 == aug0 or aug2 == aug1 then
                repeat aug2 = randomAug.r3[math.random(1, 8)]
                until(aug2 ~= aug0 and aug2 ~= aug1)
            end
        elseif augmentRoll == 4 then
            aug2 = randomAug.r4[math.random(1, 7)]
            if aug2 == aug0 or aug2 == aug1 then
                repeat aug2 = randomAug.r4[math.random(1, 7)]
                until(aug2 ~= aug0 and aug2 ~= aug1)
            end
        elseif augmentRoll == 5 then -- HP+ augment.
            aug2 = 79
        elseif augmentRoll == 6 then -- MP+ augment.
            aug2 = 83
        end

        -- Set power.
        pow2 = math.random(0, 4)
    end

    pow0 = limitPower(aug0, pow0) -- Limit power
    pow1 = limitPower(aug1, pow1) -- Limit power
    pow2 = limitPower(aug2, pow2) -- Limit power
    player:tradeComplete()
    player:addItem(itemId, 1, aug0, pow0, aug1, pow1, aug2, pow2)
    player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, itemId)
end

-----------------------------------
-- Public functions
-----------------------------------
xi.synergyFurnace.onTrigger = function(player)
--    player:PrintToPlayer( "The Furnace is powered by the souls [GM]Xaver has collected.", 0xd )
    player:PrintToPlayer( "The Furnace is under construction. Come back later!", 0xd )
end

xi.synergyFurnace.onTrade = function(player, npc, trade)
--[[
    ----------------------------------------------------------------------------------------------
    -- Crafting Track Suit
    local fireclusters = npcUtil.tradeHas(trade, {{ 4104, 12 }})

    if fireclusters then
        if npcUtil.tradeHas(trade, 27325, 27325) then
            player:tradeComplete()
            player:addItem(27326)
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 27326) -- Give Track Pants +1  
        elseif npcUtil.tradeHas(trade, 25713, 25713) then
            player:tradeComplete()
            player:addItem(25714)
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 25714) -- Give Track Shirt +1
        end
    end

    ----------------------------------------------------------------------------------------------
    -- Crafting Smocks
    for i = 1, 9 do -- This variable "i" will be the index in the table.
        local reward = 11328 + i

        if
            npcUtil.tradeHasExactly(trade,
            {
                {craftingSmocks[i][1], craftingSmocks[i][2]},
                {craftingSmocks[i][3], craftingSmocks[i][4]},
            })
        then
            player:tradeComplete()
            player:addItem(reward)
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, reward)

            break
        end
    end

    ----------------------------------------------------------------------------------------------
    -- Crafting Stalls
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
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, reward)

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
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, reward)

                break
            end
        end
    end

    ----------------------------------------------------------------------------------------------
    -- Augments
    if player:getFreeSlotsCount() >= 1 then
        local randomC = math.random(1, 100)

        local itemId = 0
        local aug0   = 0 -- Augments from table randomly selected
        local pow0   = 0 -- Power randomly selected
        local type   = 0 -- Type of augment (Kirin = 3, HQ = 2, NQ = 1)

        -- *Genbu's Kabuto*
        if npcUtil.tradeHasExactly(trade, {12434, 3275}) then
            itemId = 12434
            aug0   = 49 -- + 1-3% Haste. Guaranteed.
            pow0   = 0
            type   = 1

        -- *Genbu's Shield*
        elseif npcUtil.tradeHasExactly(trade, {12296, 3275}) then
            itemId = 12296
            aug0   = 329 -- + 1-3% Cure Potency. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        -- *Suzaku's Sune-Ate*
        elseif npcUtil.tradeHasExactly(trade, {12946, 3276}) then
            itemId = 12946
            aug0   = 49 -- + 1% Haste. Guaranteed.
            pow0   = 0 -- This should cap out at 3% haste
            type   = 1

        -- *Suzaku's Scythe*
        elseif npcUtil.tradeHasExactly(trade, {18043, 3276}) then
            itemId = 18043
            aug0   = 25 -- + 1-8 Attack Damage. Guaranteed.
            pow0   = math.random(0, 7)
            type   = 1

        -- *Seiryu's Kote*
        elseif npcUtil.tradeHasExactly(trade, {12690, 3277}) then
            itemId = 12690
            aug0   = 142 -- + 1-3 Store TP. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        -- *Seiryu's Sword* NOTE THIS IS NOT RETAIL. CHECK AUGMENT TABLE
        elseif npcUtil.tradeHasExactly(trade, {17659, 3277}) then
            itemId = 17659
            aug0   = 25 -- + 1-8 Attack Damage. Guaranteed.
            pow0   = math.random(0, 7)
            type   = 1

        -- *Byakko's Haidate*
        elseif npcUtil.tradeHasExactly(trade, {12818, 3278}) then
            itemId = 12818
            aug0   = 142 -- + 1-3 Store TP. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        -- *Byakko's Axe* NOTE THIS IS NOT RETAIL. CHECK AUGMENT TABLE
        elseif npcUtil.tradeHasExactly(trade, {18198, 3278}) then
            itemId = 18198
            aug0   = 25 -- + 1-8 Attack Damage. Guaranteed.
            pow0   = math.random(0, 7)
            type   = 1

        -- *Zenith Crown*
        elseif npcUtil.tradeHasExactly(trade, {13876, 3283}) then
            itemId = 13876
            aug0   = 133 --- + 1-3 Magic Attack Bonus. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        -- *Zenith Crown +1*
        elseif npcUtil.tradeHasExactly(trade, {13877, 3283}) then
            itemId = 13877
            aug0   = 133 --- + 2-4 Magic Attack Bonus. Guaranteed.
            pow0   = math.random(1, 3)
            type   = 2

        -- *Dalmatica*
        elseif npcUtil.tradeHasExactly(trade, {13787, 3283}) then
            itemId = 13787
            aug0   = 351 -- + 1% Occasionally Quickens Spellcasting. Guaranteed.
            pow0   = 0
            type   = 1

        -- *Dalmatica +1*
        elseif npcUtil.tradeHasExactly(trade, {13788, 3283}) then    
            itemId = 13788
            aug0   = 351 -- + 1% Occasionally Quickens Spellcasting. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Zenith Mitts*
        elseif npcUtil.tradeHasExactly(trade, {14006, 3283}) then
            itemId = 14006
            aug0   = 516 -- + INT (1-3)
            pow0   = math.random(0, 2)
            type   = 1

        -- *Zenith Mitts +1*
        elseif npcUtil.tradeHasExactly(trade, {14007, 3283}) then
            itemId = 14007
            aug0   = 516 -- + INT (2-4)
            pow0   = math.random(1, 3)
            type   = 2

        -- *Zenith Slacks*
        elseif npcUtil.tradeHasExactly(trade, {14247, 3283}) then
            itemId = 14247
            aug0   = 322 -- + 1-3% Song Spellcasting Time -. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        -- *Zenith Slacks +1*
        elseif npcUtil.tradeHasExactly(trade, {14248, 3283}) then
            itemId = 14248
            aug0   = 322 -- + 2-4% Song Spellcasting Time -. Guaranteed.
            pow0   = math.random(1, 3)
            type   = 2

        -- *Zenith Pumps*
        elseif npcUtil.tradeHasExactly(trade, {14123, 3283}) then
            itemId = 14123
            aug0   = 294 -- Summoning Magic Skill (1-3)
            pow0   = math.random(0, 2)
            type   = 1

        -- *Zenith Pumps +1*
        elseif npcUtil.tradeHasExactly(trade, {14124, 3283}) then
            itemId = 14124
            aug0   = 294 -- Summoning Magic Skill (2-4)
            pow0   = math.random(1, 3)
            type   = 2

        -- *Hecatomb Cap*
        elseif npcUtil.tradeHasExactly(trade, {13927, 3279}) then
            itemId = 13927
            aug0   = 143 -- + 1 Double Attack. Guaranteed.
            pow0   = 0
            type   = 1

        -- *Hecatomb Cap +1*
        elseif npcUtil.tradeHasExactly(trade, {13928, 3279}) then
            itemId = 13928
            aug0   = 143 -- + 1 Double Attack. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Hecatomb Harness* or +1
        elseif npcUtil.tradeHasExactly(trade, {14378, 3279}) then
            itemId = 14378
            aug0   = 513 -- + 1-3 DEX. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14379, 3279}) then
            itemId = 14379
            aug0   = 513 -- + 2-4 DEX. Guaranteed.
            pow0   = math.random(1, 3)
            type   = 2

        -- *Hecatomb Mittens* or +1
        elseif npcUtil.tradeHasExactly(trade, {14076, 3279}) then
            itemId = 14076
            aug0   = 328 -- + 1% Crit. Hit Damage. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14077, 3279}) then
            itemId = 14077
            aug0   = 328 -- + 1% Crit. Hit Damage. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Hecatomb Subligar* or +1
        elseif npcUtil.tradeHasExactly(trade, {14308, 3279}) then
            itemId = 14308
            aug0   = 41 -- + 1 Crit. Hit Rate. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14309, 3279}) then
            itemId = 14309
            aug0   = 41 -- + 1 Crit. Hit Rate. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Hecatomb Leggings* or +1
        elseif npcUtil.tradeHasExactly(trade, {14180, 3279}) then
            itemId = 14180
            aug0   = 512 -- + 1-3 STR. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14181, 3279}) then
            itemId = 14181
            aug0   = 512 -- + 2-4 STR. Guaranteed.
            pow0   = math.random(1, 3)
            type   = 2

        -- *Koenig Schaller* or +1
        elseif npcUtil.tradeHasExactly(trade, {12421, 3280}) then
            itemId = 12421
            aug0   = 140 -- + 1 Fast Cast. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {13911, 3280}) then
            itemId = 13911
            aug0   = 140 -- + 1 Fast Cast. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Koenig Cuirass* or +1
        elseif npcUtil.tradeHasExactly(trade, {12549, 3280}) then
            itemId = 12549
            aug0   = 54 -- + 1% Physical Damage Taken -. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14370, 3280}) then
            itemId = 14370
            aug0   = 54 -- + 1-2% Physical Damage Taken -. Guaranteed.
            pow0   = math.random(0, 1)
            type   = 2

        -- *Koenig Handschuhs* or +1
        elseif npcUtil.tradeHasExactly(trade, {12677, 3280}) then
            itemId = 12677
            aug0   = 145 -- + 1-3 Counter. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14061, 3280}) then
            itemId = 14061
            aug0   = 145 -- + 2-4 Counter. Guaranteed.
            pow0   = math.random(1, 3)
            type   = 2

        -- *Koenig Diechlings* or +1
        elseif npcUtil.tradeHasExactly(trade, {12805, 3280}) then
            itemId = 12805
            aug0   = 55 -- + 1 Magic Damage Taken -. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14283, 3280}) then
            itemId = 14283
            aug0   = 55 -- + 1-2 Magic Damage Taken -. Guaranteed.
            pow0   = math.random(0, 1)
            type   = 2

        -- *Koenig Schuhs* or +1
        elseif npcUtil.tradeHasExactly(trade, {12933, 3280}) then
            itemId = 12933
            aug0   = 137 -- + 1 Regen. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14163, 3280}) then
            itemId = 14163
            aug0   = 137 -- + 1 Regen. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Adaman Celata* or +1
        elseif npcUtil.tradeHasExactly(trade, {12429, 3281}) then
            itemId = 12429
            aug0   = 293 -- + 1-3 Dark Magic Skill. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {13924, 3281}) then
            itemId = 13924
            aug0   = 293 -- + 2-4 Dark Magic Skill. Guaranteed.
            pow0   = math.random(1, 3)
            type   = 2

        -- *Adaman Hauberk* or +1
        elseif npcUtil.tradeHasExactly(trade, {12557, 3281}) then
            itemId = 12557
            aug0   = 143 -- + 1 Double Attack. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14371, 3281}) then
            itemId = 14371
            aug0   = 143 -- + 1 Double Attack. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Adaman Mufflers* or +1
        elseif npcUtil.tradeHasExactly(trade, {12685, 3281}) then
            itemId = 12685
            aug0   = 49 -- + 1% Haste. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14816, 3281}) then
            itemId = 14816
            aug0   = 49 -- + 1% Haste. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Adaman Breeches* or +1
        elseif npcUtil.tradeHasExactly(trade, {12813, 3281}) then
            itemId = 12813
            aug0   = 512 -- + 1-3 STR. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14296, 3281}) then
            itemId = 14296
            aug0   = 512 -- + 2-4 STR. Guaranteed.
            pow0   = math.random(1, 3)
            type   = 2

        -- *Adaman Sollerets* or +1
        elseif npcUtil.tradeHasExactly(trade, {12941, 3281}) then
            itemId = 12941
            aug0   = 111 -- + 1-3% Pet: Haste. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14175, 3281}) then
            itemId = 14175
            aug0   = 111 -- + 2-4% Pet: Haste. Guaranteed.
            pow0   = math.random(1, 3)
            type   = 2

        -- *Shura Zunari Kabuto* or +1
        elseif npcUtil.tradeHasExactly(trade, {13934, 3282}) then
            itemId = 13934
            aug0   = 327 -- + 1% Weapon Skill Damage. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {13935, 3282}) then
            itemId = 13935
            aug0   = 327 -- + 1-2% Weapon Skill Damage. Guaranteed.
            pow0   = math.random(0, 1)
            type   = 2

        -- *Shura Togi* or +1
        elseif npcUtil.tradeHasExactly(trade, {14387, 3282}) then
            itemId = 14387
            aug0   = 49 -- + 1% Haste. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14388, 3282}) then
            itemId = 14388
            aug0   = 49 -- + 1% Haste. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Shura Kote* or +1
        elseif npcUtil.tradeHasExactly(trade, {14821, 3282}) then
            itemId = 14821
            aug0   = 145 -- + 1-3 Counter. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14822, 3282}) then
            itemId = 14822
            aug0   = 145 -- + 2-4 Counter. Guaranteed.
            pow0   = math.random(1, 3)
            type   = 2

        -- *Shura Haidate* or +1
        elseif npcUtil.tradeHasExactly(trade, {14303, 3282}) then
            itemId = 14303
            aug0   = 146 -- + 1 Dual Weild. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14304, 3282}) then
            itemId = 14304
            aug0   = 146 -- + 1-2 Dual Weild. Guaranteed.
            pow0   = math.random(0, 1)
            type   = 2

        -- *Shura Sune-Ate* or +1
        elseif npcUtil.tradeHasExactly(trade, {14184, 3282}) then
            itemId = 14184
            aug0   = 194 -- + 1-3 Kick Attacks. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14185, 3282}) then
            itemId = 14185
            aug0   = 194 -- + 2-4 Kick Attacks. Guaranteed.
            pow0   = math.random(1, 3)
            type   = 2

        -- *Crimson Mask* or +1
        elseif npcUtil.tradeHasExactly(trade, {13908, 3284}) then
            itemId = 13908
            aug0   = 35 -- + 1-3 Magic Accuracy. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {13909, 3284}) then
            itemId = 13909
            aug0   = 35 -- + 2-4 Magic Accuracy. Guaranteed.
            pow0   = math.random(1, 3)
            type   = 2

        -- *Crimson Scale Mail* or +1
        elseif npcUtil.tradeHasExactly(trade, {14367, 3284}) then
            itemId = 14367
            aug0   = 49 -- + 1% Haste. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14368, 3284}) then
            itemId = 14368
            aug0   = 49 -- + 1% Haste. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Crimson Finger Gauntlets* or +1
        elseif npcUtil.tradeHasExactly(trade, {14058, 3284}) then
            itemId = 14058
            aug0   = 211 -- + 1 Snapshot. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14059, 3284}) then
            itemId = 14059
            aug0   = 211 -- + 1 Snapshot. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Crimson Cuisses* or +1
        elseif npcUtil.tradeHasExactly(trade, {14280, 3284}) then
            itemId = 14280
            aug0   = 140 -- + 1 Fast Cast. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14281, 3284}) then
            itemId = 14281
            aug0   = 140 -- + 1 Fast Cast. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Crimson Greaves* or +1
        elseif npcUtil.tradeHasExactly(trade, {14160, 3284}) then
            itemId = 14160
            aug0   = 299 -- + 1-3 Blue Magic Skill. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14161, 3284}) then
            itemId = 14161
            aug0   = 299 -- + 2-4 Blue Magic Skill. Guaranteed.
            pow0   = math.random(1, 3)
            type   = 2

        -- *Shadow Hat* or +1
        elseif npcUtil.tradeHasExactly(trade, {16115, 3286}) then
            itemId = 16115
            aug0   = 101 -- + 1 Pet: Magic Attack Bonus. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {16116, 3286}) then
            itemId = 16116
            aug0   = 101 -- + 1-2 Pet: Magic Attack Bonus. Guaranteed.
            pow0   = math.random(0, 1)
            type   = 2

        -- *Shadow Coat* or +1
        elseif npcUtil.tradeHasExactly(trade, {14575, 3286}) then
            itemId = 14575
            aug0   = 35 -- + 1-3 Magic Accuracy. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14576, 3286}) then
            itemId = 14576
            aug0   = 35 -- + 1-3 Magic Accuracy. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 2

        -- *Shadow Cuffs* or +1
        elseif npcUtil.tradeHasExactly(trade, {14997, 3286}) then
            itemId = 14997
            aug0   = 133 -- + 1 Magic Attack Bonus. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14998, 3286}) then
            itemId = 14998
            aug0   = 133 -- + 1-2 Magic Attack Bonus. Guaranteed.
            pow0   = math.random(0, 1)
            type   = 2

        -- *Shadow Trews* or +1
        elseif npcUtil.tradeHasExactly(trade, {15657, 3286}) then
            itemId = 15657
            aug0   = 133 -- + 1 Magic Attack Bonus. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {15658, 3286}) then
            itemId = 15658
            aug0   = 133 -- + 1-2 Magic Attack Bonus. Guaranteed.
            pow0   = math.random(0, 1)
            type   = 2

        -- *Shadow Clogs* or +1
        elseif npcUtil.tradeHasExactly(trade, {15742, 3286}) then
            itemId = 15742
            aug0   = 296 -- + 1-3 Singing Skill. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {15743, 3286}) then
            itemId = 15743
            aug0   = 296 -- + 1-4 Singing Skill. Guaranteed.
            pow0   = math.random(0, 3)
            type   = 2

        -- *Shadow Helm* or +1
        elseif npcUtil.tradeHasExactly(trade, {16113, 3285}) then
            itemId = 16113
            aug0   = 138 -- + 1 Refresh. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {16114, 3285}) then
            itemId = 16114
            aug0   = 138 -- + 1 Refresh. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Shadow Breastplate* or +1
        elseif npcUtil.tradeHasExactly(trade, {14573, 3285}) then
            itemId = 14573
            aug0   = 144 -- + 1 Triple Attack. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14574, 3285}) then
            itemId = 14574
            aug0   = 144 -- + 1 Triple Attack. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Shadow Gauntlets* or +1
        elseif npcUtil.tradeHasExactly(trade, {14995, 3285}) then
            itemId = 14995
            aug0   = 143 -- + 1% Double Attack. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {14996, 3285}) then
            itemId = 14996
            aug0   = 143 -- + 1% Double Attack. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Shadow Cuishes* or +1
        elseif npcUtil.tradeHasExactly(trade, {15655, 3285}) then
            itemId = 15655
            aug0   = 49 -- + 1% Haste. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {15656, 3285}) then
            itemId = 15656
            aug0   = 49 -- + 1% Haste. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Shadow Sabatons* or +1
        elseif npcUtil.tradeHasExactly(trade, {15740, 3285}) then
            itemId = 15740
            aug0   = 41 -- + 1% Crit. Hit Rate. Guaranteed.
            pow0   = 0
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {15741, 3285}) then
            itemId = 15741
            aug0   = 41 -- + 1% Crit. Hit Rate. Guaranteed.
            pow0   = 0
            type   = 2

        -- *Kirin's Osode (Genbu)*
        elseif npcUtil.tradeHasExactly(trade, {12562, 3275}) then
            itemId = 12562
            aug0   = 137 -- + 1 Regen. Guaranteed.
            pow0   = 0
            type   = 3

        -- *Kirin's Osode (Suzaku)*
        elseif npcUtil.tradeHasExactly(trade, {12562, 3276}) then
            itemId = 12562
            aug0   = 143 -- + 1 Double Attack. Guaranteed.
            pow0   = 0
            type   = 3

        -- *Kirin's Osode (Seiryu)*
        elseif npcUtil.tradeHasExactly(trade, {12562, 3277}) then
            itemId = 12562
            aug0   = 211 -- + 1 Snapshot. Guaranteed.
            pow0   = 0
            type   = 3

        -- *Kirin's Osode (Byakko)*
        elseif npcUtil.tradeHasExactly(trade, {12562, 3278}) then
            itemId = 12562
            aug0   = 146 -- + 1 Dual Weild. Guaranteed.
            pow0   = 0
            type   = 3

        -- *Kirin's Pole (Genbu)*
        elseif npcUtil.tradeHasExactly(trade, {17567, 3275}) then
            itemId = 17567
            aug0   = 290 -- + 1-3 Enhancing Magic Skill
            pow0   = math.random(0, 2)
            type   = 3

        -- *Kirin's Pole (Suzaku)*
        elseif npcUtil.tradeHasExactly(trade, {17567, 3276}) then
            itemId = 17567
            aug0   = 292 -- + 1-3 Elemental Magic Skill
            pow0   = math.random(0, 2)
            type   = 3

        -- *Kirin's Pole (Seiryu)*
        elseif npcUtil.tradeHasExactly(trade, {17567, 3277}) then
            itemId = 17567
            aug0   = 291 -- + 1-3 Enfeebling Magic Skill
            pow0   = math.random(0, 2)
            type   = 3

        -- *Kirin's Pole (Byakko)*
        elseif npcUtil.tradeHasExactly(trade, {17567, 3278}) then
            itemId = 17567
            aug0   = 294 -- + 1-3 Summoning Magic Skill
            pow0   = math.random(0, 2)
            type   = 3

        -- *Sarissa*
        elseif npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 19307}) then
            itemId = 19304
            aug0   = 25 -- + 1-8 Attack Damage. Guaranteed.
            pow0   = math.random(0, 7)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 19304}) then
            itemId = 19304
            aug0   = 25 -- + 1-8 Attack Damage. Guaranteed.
            pow0   = math.random(0, 7)
            type   = 1

        -- *Majestas* 
        elseif npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 18617}) then
            itemId = 18603
            aug0   = 35 -- + 1-10 Magic Acc. Guaranteed.
            pow0   = math.random(0, 9)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 18603}) then
            itemId = 18603
            aug0   = 35 -- + 1-10 Magic Acc. Guaranteed.
            pow0   = math.random(0, 9)
            type   = 1

        -- *Galatyn* 
        elseif npcUtil.tradeHasExactly(trade, {2858, 2858, 2858, 2859, 19162}) then
            itemId = 19159
            aug0   = 25 -- + 1-7 Attack Damage. Guaranteed.
            pow0   = math.random(0, 6)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {2858, 2858, 2858, 2859, 19159}) then
            itemId = 19159
            aug0   = 25 -- + 1-8 Attack Damage. Guaranteed.
            pow0   = math.random(0, 7)
            type   = 1

        -- *Concordia* 
        elseif npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 2859, 17767}) then
            itemId = 17765
            aug0   = 25 -- + 1-3 Attack Damage. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {2858, 2858, 2859, 2859, 17765}) then
            itemId = 17765
            aug0   = 25 -- + 1-3 Attack Damage. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        -- *Machismo* 
        elseif npcUtil.tradeHasExactly(trade, {2858, 2859, 2859, 19128}) then
            itemId = 19118
            aug0   = 25 -- + 1-3 Attack Damage. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1

        elseif npcUtil.tradeHasExactly(trade, {2858, 2859, 2859, 19118}) then
            itemId = 19118
            aug0   = 25 -- + 1-3 Attack Damage. Guaranteed.
            pow0   = math.random(0, 2)
            type   = 1
        end

        -- FallBack
        if type > 0 then
            if randomC > 30 then
                if type == 1 then
                    handleAugmentedItemCreation(player, itemId, aug0, pow0)
                elseif type == 2 then
                    handleHqItemCreation(player, itemId, aug0, pow0)
                elseif type == 3 then
                    handleKirinItemCreation(player, itemId, aug0, pow0)
                end
            else
                handleRandomAugment(player, itemId, aug0, pow0)
            end
        else
            player:PrintToPlayer( "This item combination is incorrect.", 0xd )
        end

    else
]]
--        player:PrintToPlayer( "Not enough space in the inventory.", 0xd )
        player:PrintToPlayer( "The Furnace is under construction. Come back later!", 0xd )
--    end
end