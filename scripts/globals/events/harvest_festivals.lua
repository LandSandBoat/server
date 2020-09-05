---------------------------------------------------------
---------------------------------------------------------
------------    Harvest Festivals    --------------------
---------------------------------------------------------
---------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/settings")

---------------------------------------------------------
---------------------------------------------------------


function isHalloweenEnabled()
    local option = 0
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))
    if (month == 10 and day >= 20 or month == 11 and day == 1 or HALLOWEEN_YEAR_ROUND ~= 0) then -- According to wiki Harvest Fest is Oct 20 - Nov 1.
        if (HALLOWEEN_2005 == 1) then
            option = 1
        elseif (HALLOWEEN_2008 == 1) then
            option = 2
        elseif (HALLOWEEN_2009 == 1) then
            option = 3
        elseif (HALLOWEEN_2010 == 1) then
            option = 4
        end
    end
    return option
end


function halloweenItemsCheck(player)
    local headSlot = player:getEquipID(tpz.slot.HEAD)
    local mainHand = player:getEquipID(tpz.slot.MAIN)
    local reward = 0

    -- Normal Quality Rewards
    local pumpkinHead = 13916
    local pumpkinHead2 = 15176
    local trickStaff = 17565
    local trickStaff2 = 17587

    reward_list = {pumpkinHead, pumpkinHead2, trickStaff, trickStaff2}

    -- Checks for HQ Upgrade
    for ri = 1, #reward_list do
        if (headSlot == reward_list[ri] or mainHand == reward_list[ri]) then
            if (headSlot == pumpkinHead and player:hasItem(13917) == false) then
                reward = 13917 -- Horror Head
            elseif (headSlot == pumpkinHead2 and player:hasItem(15177) == false) then
                reward = 15177 -- Horror Head II
            elseif (mainHand == trickStaff and player:hasItem(17566) == false) then
                reward =  17566 -- Treat Staff
            elseif (mainHand == trickStaff2 and player:hasItem(17588) == false) then
                reward = 17588 -- Treat Staff II
            end
            return reward
        end
    end

    -- Checks the possible item rewards to ensure player doesnt already have the item we are about to give them
    local cnt = #reward_list

    while cnt ~= 0 do
        local picked = reward_list[math.random(1, #reward_list)]
        if (player:hasItem(picked) == false) then
            reward = picked
            cnt = 0
        else
            table.remove(reward_list, picked)
            cnt = cnt - 1
        end
    return reward
    end
end

function onHalloweenTrade(player, trade, npc)
    local zone = player:getZoneName()
    local ID = zones[player:getZoneID()]

    local contentEnabled = isHalloweenEnabled()
    local item = trade:getItemId()
    -------------------
    -- 2005 edition ---
    -------------------
    if (contentEnabled == 1) then
        -----------------------------------
        -- Treats allowed
        -----------------------------------
        local treats_table =
        {
            4510, -- Acorn Cookie
            5646, -- Bloody Chocolate
            4496, -- Bubble Chocolate
            4397, -- Cinna-cookie
            4394, -- Ginger Cookie
            4495, -- Goblin Chocolate
            4413, -- Apple Pie
            4488, -- Jack-o'-Pie
            4421, -- Melon Pie
            4563, -- Pamama Tart
            4446, -- Pumpkin Pie
            4414, -- Rolanberry Pie
            4406, -- Baked Apple
            5729, -- Bavarois
            5745, -- Cherry Bavarois
            5653, -- Cherry Muffin
            5655, -- Coffee Muffin
            5718, -- Cream Puff
            5144, -- Crimson Jelly
            5681, -- Cupid Chocolate
            5672, -- Dried Berry
            5567, -- Dried Date
            4556, -- Icecap Rolanberry
            5614, -- Konigskuchen
            5230, -- Love Chocolate
            4502, -- Marron Glace
            4393, -- Orange Kuchen
            5147, -- Snoll Gelato
            4270, -- Sweet Rice Cake
            5645, -- Witch Nougat
            5552, -- Black Pudding  --safe
            5550, -- Buche au Chocolat -- safe @ 43 items
            5616, -- Lebkuchen House --breaks
            5633, -- Chocolate Cake
            5542, -- Gateau aux Fraises
            5572, -- Irmik Helvasi
            5625, -- Maple Cake
            5559, -- Mille Feuille
            5557, -- Mont Blanc
            5629, -- Orange Cake
            5631, -- Pumpkin Cake
            5577, -- Sutlac
            5627, -- Yogurt Cake
        }

        for itemInList = 1, #treats_table  do

            if (item == treats_table[itemInList]) then
                local itemReward = halloweenItemsCheck(player)
                local varName = "harvestFestTreats"
                local harvestFestTreats
                if (itemInList < 32) then -- The size of the list is too big for int 32 used that stores the bit mask, as such there are two lists

                    harvestFestTreats = player:getCharVar(varName)
                else

                    varName = "harvestFestTreats2"
                    harvestFestTreats = player:getCharVar(varName) --  this is the second list
                    itemInList = itemInList - 32
                end

                local AlreadyTradedChk = player:getMaskBit(harvestFestTreats, itemInList)
                if (itemReward ~= 0 and player:getFreeSlotsCount() >= 1 and math.random(1, 3) < 2) then -- Math.random added so you have 33% chance on getting item

                    player:messageSpecial(ID.text.HERE_TAKE_THIS)
                    player:addItem(itemReward)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, itemReward)

                elseif target:canUseMisc(tpz.zoneMisc.COSTUME) and not AlreadyTradedChk then
                -- Other neat looking halloween type costumes
                -- two dragon skins: @420/421
                -- @422 dancing weapon
                -- @ 433/432 golem
                -- 265 dark eye, 266 Giant version
                -- 290 dark bombs
                -- 301 dark mandy
                -- 313 black spiders
                -- 488 gob
                -- 531 - 548 shade
                -- 564/579 skele

                    -- Possible costume values:
                    local Yagudo = math.random(580, 607)
                    local Quadav = math.random(644, 671)
                    local Shade = math.random(535, 538)
                    local Orc = math.random(612, 639)
                    local Ghost = 368
                    local Hound = 365
                    local Skeleton = 564
                    local Dark_Stalker = math.random(531, 534)

                    local halloween_costume_list = {Quadav, Orc, Yagudo, Shade, Ghost, Hound, Skeleton, Dark_Stalker}

                    local costumePicked = halloween_costume_list[math.random(1, #halloween_costume_list)] -- will randomly pick one of the costumes in the list
                    player:addStatusEffect(tpz.effect.COSTUME, costumePicked, 0, 3600)

                    -- pitchForkCostumeList defines the special costumes per zone that can trigger the pitch fork requirement
                    -- zone, costumeID
                    local pitchForkCostumeList =
                    {
                        234, Shade, Skeleton, -- Bastok mines
                        235, Hound, Ghost,    -- Bastok Markets
                        230, Ghost, Skeleton, -- Southern Sandoria
                        231, Hound, Skeleton, -- Northern Sandoria
                        241, Ghost, Shade,    -- Windurst Woods
                        238, Shade, Hound     -- Windurst Woods
                    }

                    for zi = 1, #pitchForkCostumeList, 3 do

                        if (zone == pitchForkCostumeList[zi] and (costumePicked == pitchForkCostumeList[zi + 1] or zone == pitchForkCostumeList[zi] and costumePicked == pitchForkCostumeList[zi + 2])) then -- Gives special hint for pitch fork costume
                            player:messageSpecial(ID.text.IF_YOU_WEAR_THIS)

                        elseif (zi == 16) then
                            player:messageSpecial(ID.text.THANK_YOU_TREAT)

                        end

                    end
                else
                    player:messageSpecial(ID.text.THANK_YOU)
                end

                if (AlreadyTradedChk == false) then
                    player:setMaskBit(harvestFestTreats, varName, itemInList, true)
                end

                player:tradeComplete()

                break
            end
        end
    end
end

function applyHalloweenNpcCostumes(zoneid)
    if isHalloweenEnabled() ~= 0 then
        local skins = zones[zoneid].npc.HALLOWEEN_SKINS
        if skins then
            for id, skin in pairs(skins) do
                local npc = GetNPCByID(id)
                if npc then
                    npc:changeSkin(skin)
                end
            end
        end
    end
end
