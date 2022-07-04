-----------------------------------
-- Zeni NM System + Helpers
-- Soultrapper         : !additem 18721
-- Blank Soul Plate    : !additem 18722
-- Soultrapper 2000    : !additem 18724
-- Blank HS Soul Plate : !additem 18725
-- Soul Plate          : !additem 2477
-- Sanraku & Ryo       : !pos -127.0 0.9 22.6 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/npc_util")
require("scripts/globals/pankration")
require("scripts/globals/utils")
require("scripts/globals/znm_data")
-----------------------------------

xi = xi or {}
xi.znm = xi.znm or {}

--------------------------------------------------
-- Sanraku's Interest and Recommended Fauna
-- Applies bonuses to soul plate zeni-value
--------------------------------------------------
-- Called during JstMidnight tick
xi.znm.UpdateSanrakusMobs = function()
    SetServerVariable('[ZNM][Sanraku]Interest', math.random(#xi.znm.SANRAKUS_INTEREST))
    SetServerVariable('[ZNM][Sanraku]Fauna', math.random(#xi.znm.SANRAKUS_FAUNA))
end

-- Get Sanraku's "Subject of Interest"
xi.znm.getSanrakusInterest = function()
    local interest = GetServerVariable('[ZNM][Sanraku]Interest')

    -- Initialize the server var if it hasn't been already
    if interest == nil or interest == 0 then
        interest = math.random(#xi.znm.SANRAKUS_INTEREST)
        SetServerVariable('[ZNM][Sanraku]Interest', interest)
    end
    return interest
end

-- Get Sanraku's "Recommended Fauna"
xi.znm.getSanrakusFauna = function()
    local fauna = GetServerVariable('[ZNM][Sanraku]Fauna')

    -- Initialize the server var if it hasn't been already
    if fauna == nil or fauna == 0 then
        fauna = math.random(#xi.znm.SANRAKUS_FAUNA)
        SetServerVariable('[ZNM][Sanraku]Fauna', fauna)
    end
    return fauna
end

--- Does this mob fall under Sanraku's current "Subject of Interest"?
-- Some families had multiple famIDs (see Sea Monks), and some superfamIDs were too general (see elementals)
-- In order to only need to use/store a single ID per mob, a bool was added to check what type of ID is stored
xi.znm.isCurrentInterest = function(superfamID, famID)
    local family_row = xi.znm.SANRAKUS_INTEREST[xi.znm.getSanrakusInterest()]

    -- Is the ID stored a family ID or a superfamily ID?
    if family_row.isSuperFamID == 0 then  -- Check mob's family
        return family_row.familyID == famID
    else                                 -- Check mob's superfamily
        return family_row.familyID == superfamID
    end
end

--- Is this mob Sanraku's current "Recommended Fauna"?
xi.znm.isCurrentFauna = function(mobName, zoneID)
    local fauna_row = xi.znm.SANRAKUS_FAUNA[xi.znm.getSanrakusFauna()]
    if fauna_row.zone ~= zoneID then
        return false
    else
        if type(fauna_row.name) == "table" then
            for iter = 1, #fauna_row.name do
                if fauna_row.name[iter] == mobName then
                    return true
                end
            end
        else
            return fauna_row.name == mobName
        end
    end
    return false
end

-----------------------------------
-- Soultrapper
-----------------------------------
xi.znm.soultrapper = xi.znm.soultrapper or {}

xi.znm.soultrapper.onItemCheck = function(target, user)
    if (target:isMob() == false or xi.pankration.prohibitedFamilies[target:getFamily()] ~= nil) then
        return xi.msg.basic.ITEM_NO_USE_ON_TARGET
    end

    local id = user:getEquipID(xi.slot.AMMO)
    if
        id ~= xi.items.BLANK_SOUL_PLATE and
        id ~= xi.items.BLANK_HIGH_SPEED_SOUL_PLATE
    then
        return xi.msg.basic.ITEM_NO_ITEMS_EQUIPPED
    end

    if user:getFreeSlotsCount() == 0 then
        return xi.msg.basic.FULL_INVENTORY
    end

    return 0
end

xi.znm.soultrapper.getZeniValue = function(target, user, item)
    local hpp = target:getHPP()
    local isNM = target:isNM()
    local distance = user:checkDistance(target)
    local isFacing = target:isFacing(user)

    -- Starting value
    local zeni = 5

    -- HP% Component
    zeni = zeni * xi.znm.SOULPLATE_HPP_MULT * math.exp(100-hpp)

    -- Distance Component
    zeni = zeni * utils.clamp((1 / distance) * 8, 1, 2)

    -- Angle/Facing Component
    if isFacing then
        zeni = zeni * xi.znm.SOULPLATE_FACING_MULT
    end

    -- Bonus for HS Soul Plate
    if user:getEquipID(xi.slot.AMMO) == xi.items.BLANK_HIGH_SPEED_SOUL_PLATE then
        zeni = zeni * xi.znm.SOULPLATE_HS_MULT
    end

    -- Check for Sanraku's "Subject of Interest"
    if xi.znm.isCurrentInterest(target:getSuperFamily(), target:getFamily()) then
        zeni = zeni * xi.znm.SOULPLATE_INTEREST_MULT
    end

    -- Check for Sanraku's "Recommended Fauna"
    if xi.znm.isCurrentFauna(target:getName(), target:getZoneID()) then
        zeni = zeni * xi.znm.SOULPLATE_FAUNA_MULT
    -- Generic NM/Rarity Component
    elseif isNM then
        zeni = zeni * xi.znm.SOULPLATE_NM_MULT
    end

    -- Add a little randomness
    zeni = zeni + math.random(6)

    -- Sanitize Zeni
    zeni = math.floor(zeni) -- Remove any floating point information
    zeni = utils.clamp(zeni, 1, 150)

    return zeni
end

xi.znm.soultrapper.onItemUse = function(target, user, item)
    -- Soul plate not guaranteed
    if math.random(100) > xi.znm.SOULTRAPPER_SUCCESS then
        user:messageBasic(xi.msg.basic.SOULTRAPPER_FAILED)
    else
        -- Determine Zeni starting value
        local zeni = xi.znm.soultrapper.getZeniValue(target, user, item)

        -- Pick a skill totally at random...
        local skillIndex, skillEntry = utils.randomEntryIdx(xi.pankration.feralSkills)

        -- Add plate
        local plate = user:addSoulPlate(target:getName(), target:getFamily(), zeni, skillIndex, skillEntry.fp)
        local data = plate:getSoulPlateData()
        utils.unused(data)
        user:messageBasic(xi.msg.basic.SOULTRAPPER_SUCCESS, 0, xi.items.SOUL_PLATE)
    end
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

        xi.znm.setTradedPlateValue(player, plateData.zeni)

        player:startEvent(914)
    end
end

xi.znm.ryo.onTrigger = function(player, npc)
    if xi.znm.playerHasSpokenToSanrakuBefore(player) then
        player:startEvent(913)
    else
        player:showText(npc,13156)  -- TODO: csid instead?
    end
end

xi.znm.ryo.onEventUpdate = function(player, csid, option)
    if csid == 914 then  -- Get approximate value of traded soulplate
        local zeniValue = xi.znm.tradedPlateValue(player)
        xi.znm.setTradedPlateValue(player, 0)
        player:updateEvent(zeniValue)
    elseif csid == 913 then
        if option == 200 then -- "Sanraku's subject of interest"
            local param = xi.znm.getSanrakusInterest()
            player:updateEvent(param,0)
        elseif option == 201 then -- "Sanraku's recommended fauna"
            local param = xi.znm.getSanrakusFauna()
            player:updateEvent(param, 0)
        elseif option == 300 then -- "My zeni balance"
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
    local storedDay = xi.znm.playerTradingDay(player)

    if currentDay ~= storedDay then
        xi.znm.resetDailyTrackingVars(player)
        return 0
    end

    return xi.znm.playerTradingDay(player)
end

xi.znm.sanraku.onTrade = function(player, npc, trade)
    if (trade:getItemCount() == 1) then -- One soul plate or trophy at a time
        local item = trade:getItem(0)
        if trade:getItemId() == xi.items.SOUL_PLATE then
            if not player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE) then
                local trade_limit = xi.znm.SOULPLATE_TRADE_LIMIT
                if platesTradedToday(player) >= trade_limit then
                    player:showText(npc,13125,1,xi.items.SOUL_PLATE,trade_limit)
                    return
                end
            else -- If you have the KI, clear out the tracking vars!
                xi.znm.resetDailyTrackingVars(player)
            end
            -- Cache the soulplate value on the player
            local plateData = item:getSoulPlateData()
            player:setLocalVar("[ZNM][Sanraku]SoulPlateValue", plateData.zeni)
            player:startEvent(910, plateData.zeni)

        else -- Check Trophy trading (for ZNM seals)
            local znm_seal = xi.znm.TROPHIES[trade:getItemId()]
            if (znm_seal ~= nil) then
                if player:hasKeyItem(znm_seal) then
                    player:showText(npc,13155) -- TODO: csid instead?
                else
                    player:setCharVar("[ZNM]TrophyTrade", znm_seal)
                    player:startEvent(912, 0, 0, 1, znm_seal)
                end
            end
        end
    end
end

----- Helper Function for onTrigger
-- Update Sanraku's ZNM menu (csid 909) based on owned seals
xi.znm.SanrakuMenu = function(player)
    -- Default: Tier 1 ZNMs + "Don't Ask"
    -- (if bit = 0: add ZNM to Sanraku's Menu)
    local param = xi.znm.DefaultMenu

    for bitmask, seal in pairs(xi.znm.MENU_BITMASKS) do
        -- Check for each key item
        if type(seal) == "table" then -- Higher tier ZNMs require 3 seals
            if (player:hasKeyItem(seal[1]) and player:hasKeyItem(seal[2]) and player:hasKeyItem(seal[3])) then
                param = bit.band(param,bit.bnot(bitmask))
            end
        else
            if player:hasKeyItem(seal) then
                param = bit.band(param,bit.bnot(bitmask))
            end
        end
    end
    return param
end

xi.znm.sanraku.onTrigger = function(player, npc)
    -- ZNM and Zeni Ineractions
    if xi.znm.playerHasSpokenToSanrakuBefore(player) then
        local param = xi.znm.SanrakuMenu(player)
        player:startEvent(909,param)
    else -- First time introduction
        player:startEvent(908)
    end
end

xi.znm.sanraku.onEventUpdate = function(player, csid, option)
    if csid == 909 then
        if option >= 300 and option <= 302 then -- "Gaining access to islets"
            local zeni_cost = 500 -- Base cost charged by Sanraku
            if player:hasKeyItem(xi.keyItem.RHAPSODY_IN_AZURE) then -- Reduced zeni cost
                zeni_cost = 50
            end
            -- Give the correct island's information + salt
            local key_item = xi.keyItem.SICKLEMOON_SALT + option - 300
            if player:getCurrency("zeni_point") < zeni_cost then -- Not enough zeni
                player:updateEvent(2)
            elseif player:hasKeyItem(key_item) then -- Already have the salt
                local SANRAKU_ID = ID.npc.SANRAKU
                player:showText(GetNPCByID(SANRAKU_ID),13124) -- TODO: csid instead?
            else
                player:addKeyItem(key_item)
                player:delCurrency("zeni_point", zeni_cost)
                player:updateEvent(1, zeni_cost, 0, key_item)
            end
        elseif option >= 100 and option <= 130 then -- Are you sure you want info on <ZNM_mob>?
            -- Give the correct ZNM's zeni cost
             local diff = option - 99
             local zeni_cost = xi.znm.getPopPrice(xi.znm.POP_ITEMS[diff].tier)
            player:updateEvent(0,0,0,0,0,0,zeni_cost)
        elseif option >= 400 and option <= 440 then -- Yes, I want info on <ZNM_mob>
            -- (440 because Warden's option is offset by 10 for some reason)
            local diff = math.min(option - 399, 31) -- Determine the desired ZNM
            local pop_item = xi.znm.POP_ITEMS[diff].item
            local znm_tier = xi.znm.POP_ITEMS[diff].tier
            local zeni_cost = xi.znm.getPopPrice(znm_tier)
            if player:getCurrency("zeni_point") < zeni_cost then -- Not enough zeni
                player:updateEvent(2)
            elseif player:getFreeSlotsCount() == 0 then -- No inventory space
                player:updateEvent(4)
            elseif player:hasItem(pop_item) then -- Own pop already
                local SANRAKU_ID = ID.npc.SANRAKU
                player:showText(GetNPCByID(SANRAKU_ID),13124) -- TODO: csid instead?
            else
                -- Deduct zeni from player, increase future pop-item costs
                player:delCurrency("zeni_point", zeni_cost)
                xi.znm.updatePopPrice(znm_tier)
                -- Give the pop item and remove the corresponding seal(s), if applicable
                player:addItem(pop_item)
                local seal = xi.znm.POP_ITEMS[diff].seal
                if type(seal) == "table" then -- Three-seal ZNMs (Tinnin, etc.)
                    player:delKeyItem(seal[1])
                    player:delKeyItem(seal[2])
                    player:delKeyItem(seal[3])
                    player:updateEvent(1, zeni_cost, pop_item,seal[1],seal[2],seal[3])
                elseif seal == 0 then -- Tier 1s have no seal
                    player:updateEvent(1, zeni_cost, pop_item)
                else -- One-seal ZNMs
                    player:delKeyItem(seal)
                    player:updateEvent(1, zeni_cost, pop_item,seal)
                end
            end
        end
    end
end

xi.znm.sanraku.onEventFinish = function(player, csid, option)
    if csid == 910 then
        player:tradeComplete()
        xi.znm.setPlayerTradingDay(player, VanadielUniqueDay())
        xi.znm.incrementTradedPlates(player)

        local zeniValue = player:getLocalVar("[ZNM][Sanraku]SoulPlateValue")
        player:setLocalVar("[ZNM][Sanraku]SoulPlateValue", 0)

        player:addCurrency("zeni_point", zeniValue)
    elseif csid == 908 then
        xi.znm.setPlayerHasSpokenToSanrakuBefore(player)
    elseif csid == 912 then
        player:tradeComplete()
        player:addKeyItem(player:getCharVar("[ZNM]TrophyTrade"))
        player:setCharVar("[ZNM]TrophyTrade",0)
    end
end

-----------------------------------
---- ZNM Pop-Item Prices
-----------------------------------
xi.znm.getPopPrice = function(znm_tier)
    local pop_cost = GetServerVariable("[ZNM][T" .. znm_tier .. "]PopCost")

    -- Check to make sure the pop prices have a set value
    if pop_cost == nil or pop_cost == 0 then
        pop_cost = xi.znm.ZNM_POP_COSTS[znm_tier].minPrice
        SetServerVariable("[ZNM][T" .. znm_tier .. "]PopCost", pop_cost)
    end
    return pop_cost
end

xi.znm.updatePopPrice = function(znm_tier)
    if not xi.znm.ZNM_STATIC_POP_PRICES then
        local pop_cost = math.min(xi.znm.getPopPrice(znm_tier) + xi.znm.ZNM_POP_COSTS[znm_tier].addedPrice,
                xi.znm.ZNM_POP_COSTS[znm_tier].maxPrice)
        SetServerVariable("[ZNM][T" .. znm_tier .. "]PopCost", pop_cost )
    end
end


-- Prices decay over time (called every 2 hours)
xi.znm.ZNMPopPriceDecay = function()
    if not xi.znm.ZNM_STATIC_POP_PRICES then
        local pop_cost = 0
        for znm_tier = 1,5 do
            pop_cost = math.max(xi.znm.getPopPrice(znm_tier) - xi.znm.ZNM_POP_COSTS[znm_tier].decayPrice,
                    xi.znm.ZNM_POP_COSTS[znm_tier].minPrice)
            SetServerVariable("[ZNM][T" .. znm_tier .. "]PopCost", pop_cost)
        end
    end
end

-----------------------------------
---- General Utility Helpers
-----------------------------------


xi.znm.playerHasSpokenToSanrakuBefore = function(player)
    return player:getCharVar("ZeniStatus") == 1
end

xi.znm.setPlayerHasSpokenToSanrakuBefore = function(player)
    player:setCharVar("ZeniStatus", 1)
end

xi.znm.tradedPlateValue = function(player)
    return player:getLocalVar("[ZNM][Ryo]SoulPlateValue")
end

xi.znm.setTradedPlateValue = function(player, zeni)
    player:setLocalVar("[ZNM][Ryo]SoulPlateValue", zeni)
end

xi.znm.playerTradingDay = function(player)
    return player:getCharVar("[ZNM][Sanraku]TradingDay")
end

xi.znm.setPlayerTradingDay = function(player, day)
    player:setCharVar("[ZNM][Sanraku]TradingDay", day)
end

xi.znm.numberOfTradedPlates = function(player)
    return player:getCharVar("[ZNM][Sanraku]TradedPlates")
end

xi.znm.incrementTradedPlates = function(player)
    player:addCharVar("[ZNM][Sanraku]TradedPlates", 1)
end

xi.znm.resetDailyTrackingVars = function(player)
    player:setCharVar("[ZNM][Sanraku]TradingDay", 0)
    player:setCharVar("[ZNM][Sanraku]TradedPlates", 0)
end
