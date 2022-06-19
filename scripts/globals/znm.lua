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
    local success = xi.znm.SOULTRAPPER_SUCCESS -- Soul plate not guaranteed

    if math.random(0,99) > success then
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
        player:setLocalVar("[ZNM][Ryo]SoulPlateValue", plateData.zeni)
        player:startEvent(914)
    end
end

xi.znm.ryo.onTrigger = function(player, npc)
    if player:getCharVar("ZeniStatus") == 1 then
        player:startEvent(913)
    else
        player:showText(npc,13156)
    end
end

xi.znm.ryo.onEventUpdate = function(player, csid, option)
    if csid == 914 then
        local zeniValue = player:getLocalVar("[ZNM][Ryo]SoulPlateValue")
        player:setLocalVar("[ZNM][Ryo]SoulPlateValue", 0)
        player:updateEvent(zeniValue)
    elseif csid == 913 then
        local param = 39
        if option == 200 then -- Sanraku's subject of interest
            --local param = xi.znm.getSanrakusInterest()
            player:updateEvent(param, 0)
        elseif option == 201 then -- Sanraku's rare fauna
            --local param = xi.znm.getSanrakusFauna()
            player:updateEvent(param, 0)
        elseif option == 300 then
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
    if (trade:getItemCount() == 1) then -- One soul plate or trophy at a time
        local item = trade:getItem(0)
        if trade:getItemId() == xi.items.SOUL_PLATE then
            if not player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE) then
                if platesTradedToday(player) >= 10 then
                    player:showText(npc,13125,1,xi.items.SOUL_PLATE,10)
                    return
                end
            else -- If you have the KI, clear out the tracking vars!
                player:setCharVar("[ZNM][Sanraku]TradingDay", 0)
                player:setCharVar("[ZNM][Sanraku]TradedPlates", 0)
            end
            -- Cache the soulplate value on the player
            local plateData = item:getSoulPlateData()
            player:setLocalVar("[ZNM][Sanraku]SoulPlateValue", plateData.zeni)
            player:startEvent(910, plateData.zeni)

        else -- Check Trophy trading (for ZNM seals)
            local znm_seal = xi.znm.trophies[trade:getItemId()]
            if (znm_seal ~= nil) then
                if player:hasKeyItem(znm_seal) then
                    player:messageBasic(xi.msg.basic.ALREADY_HAVE_KEY_ITEM,0,znm_seal) -- TODO: better text line?
                else
                    player:confirmTrade()
                    player:setCharVar("[ZNM]TrophyTrade", znm_seal)
                    player:startEvent(912, 0, 0, 1, znm_seal)
                end
            end
        end
    end
end

----- Update Sanraku's ZNM menu based on owned seals
xi.znm.SanrakuMenu = function(player)
    -- Default: Tier 1 ZNMs + "Don't Ask"
    local param = xi.znm.DefaultMenu

    for bitmask, seal in pairs(xi.znm.KeyItem_Params) do
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
    if player:getCharVar("ZeniStatus") == 1 then
        local param = xi.znm.SanrakuMenu(player)
        player:startEvent(909,param)
    else -- First time introduction
        player:startEvent(908)
    end
end

xi.znm.sanraku.onEventUpdate = function(player, csid, option)
    if csid == 909 then
        player:PrintToPlayer(string.format("CSID '%i' option: '%i'", csid, option))
        if option >= 300 and option <= 302 then -- Gaining access to islets
            local zeni_cost = 500 -- Base cost charged by Sanraku
            if player:hasKeyItem(xi.keyItem.RHAPSODY_IN_AZURE) then -- Reduced zeni cost
                zeni_cost = 50
            end
            -- Give the correct island's information + salt
            local key_item = xi.keyItem.SICKLEMOON_SALT + option - 300
            if player:getCurrency("zeni_point") < zeni_cost then -- Not enough zeni
                player:updateEvent(2)
            elseif player:hasKeyItem(key_item) then -- Already have the salt
                player:updateEvent(3)
            else
                player:addkeyItem(key_item)
                player:delCurrency("zeni_point", zeni_cost)
                player:updateEvent(1, zeni_cost, 0, key_item)
            end
        elseif option >= 100 and option <= 130 then-- Are you sure you want info on <ZNM_mob>?
            -- Give the correct ZNM's zeni cost
            -- local diff = option - 99
            -- local zeni_cost = xi.znm.getPopPrice(xi.znm.pop_items[diff].tier)
            local zeni_cost = 1000 -- TODO: GetServerVar the cost
            player:updateEvent(0,0,0,0,0,0,zeni_cost)
        elseif option >= 400 and option <= 440 then -- Yes, I want info on <ZNM_mob>
            -- (440 because Warden's option is offset by 10 for some reason)
            local diff = math.min(option - 399, 31) -- Determine the desired ZNM
            local pop_item = xi.znm.pop_items[diff].item
            local zeni_cost = 1000 -- TODO: GetServerVar the cost
            -- local zeni_cost = xi.znm.getPopPrice(xi.znm.pop_items[diff].tier)
            if player:getCurrency("zeni_point") < zeni_cost then -- Not enough zeni
                player:updateEvent(2)
            elseif player:getFreeSlotsCount() == 0 then -- No inventory space
                player:updateEvent(4)
            elseif player:hasItem(pop_item) then -- Own pop already
                player:updateEvent(4) -- TODO: find "it seems you are in possession of one"?
            else
                player:delCurrency("zeni_point", zeni_cost)
                player:addItem(pop_item)
                -- xi.znm.updatePopPrice(xi.znm.pop_items[diff].tier) -- TODO: SetServerVar new cost
                -- Remove the corresponding seal(s), if applicable
                local seal = xi.znm.pop_items[diff].seal
                if type(seal) == "table" then -- three-seal ZNMs (Tinnin, etc.)
                    player:delKeyItem(seal[1])
                    player:delKeyItem(seal[2])
                    player:delKeyItem(seal[3])
                    player:updateEvent(1, zeni_cost, xi.znm.pop_items[diff].item,seal[1],seal[2],seal[3])
                elseif seal == 0 then -- Tier 1s have no seal
                    player:updateEvent(1, zeni_cost, xi.znm.pop_items[diff].item)
                else -- one-seal ZNMs
                    player:delKeyItem(seal)
                    player:updateEvent(1, zeni_cost, xi.znm.pop_items[diff].item,seal)
                end
            end
        end
    end
end

xi.znm.sanraku.onEventFinish = function(player, csid, option)
    if csid == 910 then
        player:confirmTrade()
        player:setCharVar("[ZNM][Sanraku]TradingDay", VanadielUniqueDay())
        player:addCharVar("[ZNM][Sanraku]TradedPlates", 1)

        local zeniValue = player:getLocalVar("[ZNM][Sanraku]SoulPlateValue")
        player:setLocalVar("[ZNM][Sanraku]SoulPlateValue", 0)

        player:addCurrency("zeni_point", zeniValue)
    elseif csid == 908 then
        player:setCharVar("ZeniStatus",1)
    elseif csid == 912 then
        player:addKeyItem(player:getCharVar("[ZNM]TrophyTrade"))
        player:setCharVar("[ZNM]TrophyTrade",0)
    end
end