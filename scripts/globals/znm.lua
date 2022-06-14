-----------------------------------
-- Zeni NM System + Helpers
-- Soultrapper         : !additem 18721
-- Blank Soul Plate    : !additem 18722
-- Soultrapper 2000    : !additem 18724
-- Blank HS Soul Plate : !additem 18725
-- Soul Plate          : !additem 2477
-- Sanraku & Ryo       : !pos -127.0 0.9 22.6 50
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/npc_util")
require("scripts/globals/pankration")
require("scripts/globals/utils")
require("scripts/globals/besieged")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

xi = xi or {}
xi.znm = xi.znm or {}

-----------------------------------
-- Soultrapper
-----------------------------------
xi.znm.soultrapper = xi.znm.soultrapper or {}

xi.znm.soultrapper.onItemCheck = function(target, user)
    if not user:isFacing(target) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    local id = user:getEquipID(xi.slot.AMMO)
    if
        id ~= xi.items.BLANK_SOUL_PLATE and
        id ~= xi.items.BLANK_HIGH_SPEED_SOUL_PLATE
    then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if user:getFreeSlotsCount() == 0 then
        return xi.msg.basic.FULL_INVENTORY
    end

    return 0
end

xi.znm.soultrapper.getZeniValue = function(target, user, item)
    local hpp = target:getHPP()
    local system = target:getSystem()
    local isNM = target:isNM()
    local distance = user:checkDistance(target)
    local isFacing = target:isFacing(user)

    -- Starting value
    local zeni = 5

    -- HP% Component
    local hpMultiplier = math.min(100 / hpp, 5)
    if hpp <= 5 then
        hpMultiplier = 10
    end
    zeni = zeni * hpMultiplier

    -- In-Demand System Component
    -- TODO: Make rotating server var
    local inDemandSystem = xi.ecosystem.DRAGON
    if system == inDemandSystem then
        zeni = zeni * 1.5
    end

    -- NM/Rarity Component
    if isNM then
        zeni = zeni * 1.5
    end

    -- Distance Component
    zeni = zeni * utils.clamp((1 / distance) * 2, 1, 2)

    -- Angle/Facing Component
    if isFacing then
        zeni = zeni * 1.5
    end

    -- Bonus for HS Soul Plate
    if user:getEquipID(xi.slot.AMMO) == xi.items.BLANK_HIGH_SPEED_SOUL_PLATE then
        zeni = zeni * 1.5
    end

    -- Add a little randomness
    zeni = zeni + math.random(0, 5)

    -- Sanitize Zeni
    zeni = math.floor(zeni) -- Remove any floating point information
    zeni = utils.clamp(zeni, 1, 100)

    return zeni
end

xi.znm.soultrapper.onItemUse = function(target, user, item)
    -- Determine Zeni starting value
    local zeni = xi.znm.soultrapper.getZeniValue(target, user, item)

    -- Pick a skill totally at random
    local skillIndex, skillEntry = utils.randomEntryIdx(xi.pankration.feralSkills)

    -- Add plate
    local plate = user:addSoulPlate(target:getName(), target:getFamily(), zeni, skillIndex, skillEntry.fp)
    local data = plate:getSoulPlateData()
    utils.unused(data)
end

-----------------------------------
-- Ryo
-----------------------------------
xi.znm.ryo = xi.znm.ryo or {}

xi.znm.ryo.onTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, xi.items.SOUL_PLATE) then
        -- Cache the soulplate value on the player
        local item = trade:getItem(0)
        local plateData = item:getSoulPlateData()
        player:setLocalVar("[ZNM][Ryo]SoulPlateValue", plateData.zeni)
        player:startEvent(914)
    end
end

xi.znm.ryo.onTrigger = function(player, npc)
    player:startEvent(913)
end

xi.znm.ryo.onEventUpdate = function(player, csid, option)
    if csid == 914 then
        local zeniValue = player:getLocalVar("[ZNM][Ryo]SoulPlateValue")
        player:setLocalVar("[ZNM][Ryo]SoulPlateValue", 0)
        player:updateEvent(zeniValue)
    elseif csid == 913 then
        if option == 300 then
            player:updateEvent(player:getCurrency("zeni_point"), 0)
        else
            player:updateEvent(0, 0)
        end
    end
end

xi.znm.ryo.onEventFinish = function(player, csid, option)
end

-----------------------------------
-- Sanraku
-----------------------------------
xi.znm.sanraku = xi.znm.sanraku or {}

local platesTradedToday = function(player)
    local currentDay = VanadielUniqueDay()
    local storedDay = player:getCharVar("[ZNM][Sanraku]TradingDay")

    if currentDay ~= storedDay then
        player:setCharVar("[ZNM][Sanraku]TradingDay", 0)
        player:setCharVar("[ZNM][Sanraku]TradedPlates", 0)
        return 0
    end

    return player:getCharVar("[ZNM][Sanraku]TradedPlates")
end

xi.znm.sanraku.onTrade = function(player, npc, trade)
    if (trade:hasItemQty(65535, 20000)) then
	    player:addKeyItem(xi.ki.SICKLEMOON_SALT)
		player:addKeyItem(xi.ki.SILVER_SEA_SALT)   
		player:addKeyItem(xi.ki.CYAN_DEEP_SALT)		
		player:tradeComplete()
		player:messageSpecial(ID.text.KEYITEM_OBTAINED,xi.ki.SICKLEMOON_SALT)  
		player:messageSpecial(ID.text.KEYITEM_OBTAINED,xi.ki.SILVER_SEA_SALT)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED,xi.ki.CYAN_DEEP_SALT)      	
	end
    
    local trophies =
    {
        2616, 2617, 2618, 2613, 2614, 2615, 2610, 2611, 2612,
        2609, 2626, 2627, 2628, 2623, 2624, 2625, 2620, 2621,
        2622, 2619, 2636, 2637, 2638, 2633, 2634, 2635, 2630,
        2631, 2632, 2629
    }

    local seals =
    {
        xi.ki.MAROON_SEAL, xi.ki.MAROON_SEAL, xi.ki.MAROON_SEAL,
        xi.ki.APPLE_GREEN_SEAL,xi.ki.APPLE_GREEN_SEAL,xi.ki.APPLE_GREEN_SEAL,
        xi.ki.CHARCOAL_GREY_SEAL, xi.ki.DEEP_PURPLE_SEAL, xi.ki.CHESTNUT_COLORED_SEAL,
        xi.ki.LILAC_COLORED_SEAL,
        xi.ki.CERISE_SEAL,xi.ki.CERISE_SEAL,xi.ki.CERISE_SEAL,
        xi.ki.SALMON_COLORED_SEAL,xi.ki.SALMON_COLORED_SEAL,xi.ki.SALMON_COLORED_SEAL,
        xi.ki.PURPLISH_GREY_SEAL, xi.ki.GOLD_COLORED_SEAL, xi.ki.COPPER_COLORED_SEAL,
        xi.ki.BRIGHT_BLUE_SEAL,
        xi.ki.PINE_GREEN_SEAL,xi.ki.PINE_GREEN_SEAL,xi.ki.PINE_GREEN_SEAL,
        xi.ki.AMBER_COLORED_SEAL,xi.ki.AMBER_COLORED_SEAL,xi.ki.AMBER_COLORED_SEAL,
        xi.ki.FALLOW_COLORED_SEAL,xi.ki.TAUPE_COLORED_SEAL,xi.ki.SIENNA_COLORED_SEAL,
        xi.ki.LAVENDER_COLORED_SEAL
    }

    if trade:getItemCount() == 1 then
        if trade:hasItemQty(2477,1) then -- Trade Soul Plate
            zeni = math.random(5,1000) -- random value since soul plates aren't implemented yet.
            player:tradeComplete()
            player:addCurrency("zeni_point", zeni)
            player:startEvent(910,zeni)
        else
            znm = -1
            found = false

            while znm <= 30 and not(found) do
                znm = znm + 1
                found = trade:hasItemQty(trophies[znm + 1],1)
            end

            if (found) then
                znm = znm + 1

                if player:hasKeyItem(seals[znm]) == false then
                    player:tradeComplete()
                    player:addKeyItem(seals[znm])
                    player:startEvent(912,0,0,0,seals[znm])
                else
                    player:messageSpecial(ID.text.SANCTION + 8,seals[znm]) -- You already possess .. (not sure this is authentic)
                end
            end
        end
    end
    
end

xi.znm.sanraku.onTrigger = function(player, npc)
if player:getCharVar("ZeniStatus") == 0 then
        player:startEvent(908)
    else
        local param = 2140136440 -- Defaut bitmask, Tier 1 ZNM Menu + don't ask option

        -- Tinnin Path
        if player:hasKeyItem(xi.ki.MAROON_SEAL) then
            param = param - 0x38 -- unlocks Tinnin path tier 2 ZNMs.
        end
        if player:hasKeyItem(xi.ki.APPLE_GREEN_SEAL) then
            param = param - 0x1C0 -- unlocks Tinnin path tier 3 ZNMs.
        end
        if player:hasKeyItem(xi.ki.CHARCOAL_GREY_SEAL) and player:hasKeyItem(xi.ki.DEEP_PURPLE_SEAL) and player:hasKeyItem(xi.ki.CHESTNUT_COLORED_SEAL) then
            param = param - 0x200 -- unlocks Tinnin.
        end

        -- Sarameya Path
        if player:hasKeyItem(xi.ki.CERISE_SEAL) then
            param = param - 0xE000 -- unlocks Sarameya path tier 2 ZNMs.
        end
        if player:hasKeyItem(xi.ki.SALMON_COLORED_SEAL) then
            param = param - 0x70000 -- unlocks Sarameya path tier 3 ZNMs.
        end
        if player:hasKeyItem(xi.ki.PURPLISH_GREY_SEAL) and player:hasKeyItem(xi.ki.GOLD_COLORED_SEAL) and player:hasKeyItem(xi.ki.COPPER_COLORED_SEAL) then
            param = param - 0x80000 -- unlocks Sarameya.
        end

        -- Tyger Path
        if player:hasKeyItem(xi.ki.PINE_GREEN_SEAL) then
            param = param - 0x3800000 -- unlocks Tyger path tier 2 ZNMs.
        end
        if player:hasKeyItem(xi.ki.AMBER_COLORED_SEAL) then
            param = param - 0x1C000000 -- unlocks Tyger path tier 3 ZNMs.
        end
        if player:hasKeyItem(xi.ki.TAUPE_COLORED_SEAL) and player:hasKeyItem(xi.ki.FALLOW_COLORED_SEAL) and player:hasKeyItem(xi.ki.SIENNA_COLORED_SEAL) then
            param = param - 0x20000000 -- unlocks Tyger.
        end

        if player:hasKeyItem(xi.ki.LILAC_COLORED_SEAL) and player:hasKeyItem(xi.ki.BRIGHT_BLUE_SEAL) and player:hasKeyItem(xi.ki.LAVENDER_COLORED_SEAL) then
            param = param - 0x40000000 -- unlocks Pandemonium Warden.
        end

        player:startEvent(909,param)
    end
    
end

xi.znm.sanraku.onEventUpdate = function(player, csid, option)
  printf("updateRESULT: %u",option)
    
    local lures =
    {
        2580, 2581, 2582, 2577, 2578, 2579, 2574, 2575, 2576,
        2573, 2590, 2591, 2592, 2587, 2588, 2589, 2584, 2585,
        2586, 2583, 2600, 2601, 2602, 2597, 2598, 2599, 2594,
        2595, 2596, 2593, 2572
    }

    local seals =
    {
        xi.ki.MAROON_SEAL, xi.ki.MAROON_SEAL, xi.ki.MAROON_SEAL,
        xi.ki.APPLE_GREEN_SEAL,xi.ki.APPLE_GREEN_SEAL,xi.ki.APPLE_GREEN_SEAL,
        xi.ki.CHARCOAL_GREY_SEAL, xi.ki.DEEP_PURPLE_SEAL, xi.ki.CHESTNUT_COLORED_SEAL,
        xi.ki.LILAC_COLORED_SEAL,
        xi.ki.CERISE_SEAL,xi.ki.CERISE_SEAL,xi.ki.CERISE_SEAL,
        xi.ki.SALMON_COLORED_SEAL,xi.ki.SALMON_COLORED_SEAL,xi.ki.SALMON_COLORED_SEAL,
        xi.ki.PURPLISH_GREY_SEAL, xi.ki.GOLD_COLORED_SEAL, xi.ki.COPPER_COLORED_SEAL,
        xi.ki.BRIGHT_BLUE_SEAL,
        xi.ki.PINE_GREEN_SEAL,xi.ki.PINE_GREEN_SEAL,xi.ki.PINE_GREEN_SEAL,
        xi.ki.AMBER_COLORED_SEAL,xi.ki.AMBER_COLORED_SEAL,xi.ki.AMBER_COLORED_SEAL,
        xi.ki.FALLOW_COLORED_SEAL,xi.ki.TAUPE_COLORED_SEAL,xi.ki.SIENNA_COLORED_SEAL,
        xi.ki.LAVENDER_COLORED_SEAL
    }

    if csid == 909 then
        local zeni = player:getCurrency("zeni_point")

        if option >= 300 and option <= 302 then
            if option == 300 then
                salt = xi.ki.SICKLEMOON_SALT
            elseif option == 301 then
                salt = xi.ki.SILVER_SEA_SALT
            elseif option == 302 then
                salt = xi.ki.CYAN_DEEP_SALT
            end
            if zeni < 500 then
                player:updateEvent(2,500) -- not enough zeni
            elseif player:hasKeyItem(salt) then
                player:updateEvent(3,500) -- has salt already
            else
                player:updateEvent(1,500,0,salt)
                player:addKeyItem(salt)
                player:delCurrency("zeni_point", 500)
            end
        else -- player is interested in buying a pop item.
            n = option % 10

            if n <= 2 then
                if option == 130 or option == 440 then
                    tier = 5
                else
                    tier = 1
                end
            elseif n >= 3 and n <= 5 then
                tier = 2
            elseif n >= 6 and n <= 8 then
                tier = 3
            else
                tier = 4
            end

            cost = tier * 1000 -- static pricing for now.

            if option >= 100 and option <= 130 then
                player:updateEvent(0,0,0,0,0,0,cost)
            elseif option >= 400 and option <=440 then
                if option == 440 then
                    option = 430
                end

                item = lures[option-399]

                if option == 430 then -- Pandemonium Warden
                    keyitem1 = xi.ki.LILAC_COLORED_SEAL keyitem2 = xi.ki.BRIGHT_BLUE_SEAL keyitem3 = xi.ki.LAVENDER_COLORED_SEAL
                elseif option == 409 then -- Tinnin
                    keyitem1 = xi.ki.CHARCOAL_GREY_SEAL keyitem2 = xi.ki.DEEP_PURPLE_SEAL keyitem3 = xi.ki.CHESTNUT_COLORED_SEAL
                elseif option == 419 then -- Sarameya
                    keyitem1 = xi.ki.PURPLISH_GREY_SEAL keyitem2 = xi.ki.GOLD_COLORED_SEAL keyitem3 = xi.ki.COPPER_COLORED_SEAL
                elseif option == 429 then -- Tyger
                    keyitem1 = xi.ki.TAUPE_COLORED_SEAL keyitem2 = xi.ki.FALLOW_COLORED_SEAL keyitem3 = xi.ki.SIENNA_COLORED_SEAL
                else
                    keyitem1 = seals[option - 402] keyitem2 = nil keyitem3 = nil
                end
                if cost > zeni then
                    player:updateEvent(2, cost, item, keyitem1,keyitem2,keyitem3) -- you don't have enough zeni.
                elseif player:addItem(item) then
                    if keyitem1 ~= nil then
                        player:delKeyItem(keyitem1)
                    end
                    if keyitem2 ~= nil then
                        player:delKeyItem(keyitem2)
                    end
                    if keyitem3 ~= nil then
                        player:delKeyItem(keyitem3)
                    end

                    player:updateEvent(1, cost, item, keyitem1,keyitem2,keyitem3)
                    player:delCurrency("zeni_point", cost)
                else
                    player:updateEvent(4, cost, item, keyitem1,keyitem2,keyitem3) -- Cannot obtain.
                end
            elseif option == 500 then -- player has declined to buy a pop item
                player:updateEvent(1,1) -- restore the "Gaining access to the islets" option.
            else
                 print("onEventSelection - CSID:",csid)
                 print("onEventSelection - option ===",option)
            end
        end
    end
    
end


xi.znm.sanraku.onEventFinish = function(player, csid, option)
  printf("finishRESULT: %u",option)
    
    if csid == 908 then
        player:setCharVar("ZeniStatus",1)
        player:addCurrency("zeni_point", 2000)
    end
	
end
