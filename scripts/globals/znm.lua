-----------------------------------
-- Zeni NM System + Helpers
--
-- Soultrapper         : !additem 18721
-- Blank Soul Plate    : !additem 18722
-- Soultrapper 2000    : !additem 18724
-- Blank HS Soul Plate : !additem 18725
-- Soul Plate          : !additem 2477
-- Sanraku & Ryo       : !pos -127.0 0.9 22.6 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
xi = xi or {}
xi.znm = xi.znm or {}

local getHighBits16 = function(data)
    return bit.rshift(data, 16)
end

local getLowBits16 = function(data)
    return bit.band(data, 0xFFFF)
end

local setHighBits16 = function(data, diff)
    return bit.bor(data, bit.lshift(getLowBits16(diff), 16))
end

local setLowBits16 = function(data, diff)
    return bit.bor(data, getLowBits16(diff))
end

-----------------------------------
-- Sanraku's Interest and Recommended Fauna
-- Applies bonuses to soul plate zeni-value
-----------------------------------

-- Called during JstMidnight tick
xi.znm.UpdateSanrakusMobs = function()
    SetServerVariable('[ZNM][Sanraku]Interest', math.random(#xi.znm.SANRAKUS_INTEREST))
    SetServerVariable('[ZNM][Sanraku]Fauna', math.random(#xi.znm.SANRAKUS_FAUNA))
    SetServerVariable('[ZNM][Sanraku]Trades', math.random(0, 250))
end

xi.znm.serverPlateTrades = function()
    local currentTrades = GetServerVariable('[ZNM][Sanraku]Trades')

    if currentTrades >= 500 then
        xi.znm.UpdateSanrakusMobs()
    else
        SetServerVariable('[ZNM][Sanraku]Trades', currentTrades + 1)
    end
end

-- Get Sanraku's 'Subject of Interest'
xi.znm.getSanrakusInterest = function()
    local interest = GetServerVariable('[ZNM][Sanraku]Interest')

    -- Initialize the server var if it hasn't been already
    if interest == nil or interest == 0 then
        interest = math.random(#xi.znm.SANRAKUS_INTEREST)
        SetServerVariable('[ZNM][Sanraku]Interest', interest)
    end

    return interest
end

-- Get Sanraku's 'Recommended Fauna'
xi.znm.getSanrakusFauna = function()
    local fauna = GetServerVariable('[ZNM][Sanraku]Fauna')

    -- Initialize the server var if it hasn't been already
    if fauna == nil or fauna == 0 then
        fauna = math.random(#xi.znm.SANRAKUS_FAUNA)
        SetServerVariable('[ZNM][Sanraku]Fauna', fauna)
    end

    return fauna
end

--- Is this mob Sanraku's current 'Recommended Fauna'?

xi.znm.isCurrentFauna = function(plateData)
    -- local zeni     = plateData.zeni

    local data     = plateData.interestData
    local zoneID   = getHighBits16(data)
    local mobName  = plateData.name
    local faunaRow = xi.znm.SANRAKUS_FAUNA[xi.znm.getSanrakusFauna()]

    if faunaRow.zone ~= zoneID then
        return false
    else
        if type(faunaRow.name) == 'table' then
            for iter = 1, #faunaRow.name do
                if faunaRow.name[iter] == mobName then
                    return true
                end
            end
        else
            if faunaRow.name == mobName then
                return true
            end
        end
    end

    return false
end

-- Main interest objective

xi.znm.isCurrentSuperFamily = function(plateData)
    local data            = plateData.interestData
    local superFamily     = getLowBits16(data)
    local currectInterest = xi.znm.getSanrakusInterest()
    local interestRow     = xi.znm.SANRAKUS_INTEREST[currectInterest]

    if superFamily == interestRow.superFamily then
        -- Handle elementals as all have same superFamily
        if currectInterest >= 45 and currectInterest <= 51 then
            if plateData.name ~= interestRow.name then
                return false
            end
        end

        return true
    end

    return false
end

-- Secondary interest objective
xi.znm.isCurrentEcosystem = function(plateData)
    local data            = plateData.interestData
    local superFamily     = getLowBits16(data)
    local currectInterest = xi.znm.getSanrakusInterest()
    local interestRow     = xi.znm.SANRAKUS_INTEREST[currectInterest]

    if utils.contains(superFamily, interestRow.ecoSystem) then
        return true
    end

    return false
end

xi.znm.calculatePlateZeni = function(player, plateData)
    -- Cache the soulplate value on the player
    local zeni  = plateData.zeni
    local bonus = 'none'

    if xi.znm.isCurrentFauna(plateData) then
        zeni = zeni + xi.znm.SOULPLATE_FAUNA
        bonus = 'Fauna'
    elseif xi.znm.isCurrentSuperFamily(plateData) then
        zeni = zeni + xi.znm.SOULPLATE_INTEREST
        bonus = 'superFamily'
    elseif xi.znm.isCurrentEcosystem(plateData) then
        zeni = zeni + xi.znm.SOULPLATE_ECOSYSTEM
        bonus = 'ecoSystem'
    end

    utils.unused(bonus)

    -- to avoid pictures being handed to low level chars, adding this check
    -- low level chars get 1/3 less when they take the pic, customizing to also affect trade in.
    if player:getMainLvl() <= 10 then
        zeni = zeni / 3
    end

    zeni = utils.clamp(zeni, xi.znm.SOULPLATE_MIN_VALUE, xi.znm.SOULPLATE_MAX_VALUE)

    -- if player:getDebugMode() then
    --     player:printToPlayer(string.format('name: %s zeni %i, bonus: %s', plateData.name, zeni, bonus))
    -- end

    return zeni
end

-----------------------------------
-- Soultrapper
-----------------------------------

xi.znm.soultrapper = xi.znm.soultrapper or {}

-----------------------------------
-- onItemCheck
-----------------------------------

xi.znm.soultrapper.onItemCheck = function(target, item, param, caster)
    -- can not be used on non mobs or Structure type mobs
    if
        not target:isMob() or
        (target:getFamily() >= 236 and target:getFamily() <= 239)
    then
        return xi.msg.basic.ITEM_CANNOT_USE_TARGET
    end

    if
        caster:hasStatusEffect(xi.effect.INVISIBLE) or
        caster:hasStatusEffect(xi.effect.SNEAK) or
        caster:hasStatusEffect(xi.effect.DEODORIZE) or
        caster:hasStatusEffect(xi.effect.HIDE) or
        caster:hasStatusEffect(xi.effect.CAMOUFLAGE)
    then
        return xi.msg.basic.ITEM_NO_USE_SNEAK, caster:getEquipID(xi.slot.RANGED)
    end

    local id = caster:getEquipID(xi.slot.AMMO)
    if
        id ~= xi.item.BLANK_SOUL_PLATE and
        id ~= xi.item.BLANK_HIGH_SPEED_SOUL_PLATE
    then
        return xi.msg.basic.ITEM_NO_ITEMS_EQUIPPED
    end

    if caster:getFreeSlotsCount() == 0 then
        return xi.msg.basic.FULL_INVENTORY
    end

    return 0
end

-----------------------------------
-- onItemUse
-----------------------------------

xi.znm.soultrapper.onItemUse = function(target, player, item)
    -- Soul plate not guaranteed
    -- to validate long term: some posts hint at level correction on success rate vs. higher level mobs.
    if math.random(100) > xi.znm.SOULTRAPPER_SUCCESS * xi.znm.SOULPLATE_HS_MULT then
        -- todo, message should show to all in area
        player:timer(4000, function(playerArg)
            playerArg:messageBasic(xi.msg.basic.SOULTRAPPER_FAILED)
        end)

        player:removeAmmo(1)
    else
        -- Determine Zeni starting value
        local zeni = xi.znm.soultrapper.getZeniValue(target, player)

        -- Pick a skill totally at random...
        local skillIndex, skillEntry = utils.randomEntryIdx(xi.pankration.feralSkills)
        local interestData = xi.znm.soultrapper.packInterestData(target)

        -- Add plate
        local plate = player:addSoulPlate(target:getName(), interestData, zeni, skillIndex, skillEntry.fp)
        local data = plate:getSoulPlateData()

        -- if player:getDebugMode() then
        --     player:printToPlayer(string.format('mobName: %s zone: %i superID: %i SystemID: %i base zeni: %i', data.name, target:getZoneID(), target:getSuperFamily(), target:getSystem(), zeni))
        -- end

        utils.unused(plate)
        utils.unused(data)

        -- todo, message should show to all in area
        player:timer(4000, function(playerArg)
            playerArg:messageBasic(xi.msg.basic.SOULTRAPPER_SUCCESS, 0, xi.item.SOUL_PLATE)
        end)
    end
end

-----------------------------------
-- onItemUse Helpers
-----------------------------------

xi.znm.soultrapper.getZeniValue = function(target, player)
    local hpp      = target:getHPP()
    local isNM     = target:isNM()
    local distance = player:checkDistance(target)
    local isFacing = target:isFacing(player)
    local level    = target:getMainLvl()

    -- Starting value
    local zeni = 10

    -- Distance Component
    zeni = zeni * utils.clamp((1 / distance) * 8, 1, 1.5)

    -- Size Component
    zeni = zeni + (target:getHitboxSize() * 5) -- needs verification

    -- Angle/Facing Component
    if isFacing then
        zeni = zeni * xi.znm.SOULPLATE_FACING_MULT
    end

    -- HP% Component
    zeni = zeni * 1 + math.abs(hpp - 100) / 6

    if
        target:getFamily() == 512 or
        (target:getFamily() == 109 and target:getZoneID() == 33)
    then -- Dahak and Aw'euvhi
        zeni = zeni + xi.znm.SOULPLATE_UNIQUE_AMOUNT
    elseif
        target:getFamily() == 64 or
        target:getFamily() == 293
    then -- chigoe penalty
        zeni = zeni - xi.znm.SOULPLATE_UNIQUE_AMOUNT
    -- Generic NM/Rarity Component
    elseif isNM then
        if level >= 80 then
            zeni = zeni * xi.znm.SOULPLATE_HNM_MULT
        else
            zeni = zeni * xi.znm.SOULPLATE_NM_MULT
        end
    end

    -- level component. dependent on mob level, not player. need to validate level above 75 to see if the values are the same to prove/disprove
    if level < 75 then
        zeni = zeni - (75 - level)
    else
        zeni = zeni + (level - 75)
    end

    zeni = utils.clamp(zeni, xi.znm.SOULPLATE_MIN_VALUE, xi.znm.SOULPLATE_MAX_VALUE)

    -- Add a little randomness
    zeni = zeni + math.random(6)

    -- Having claim on the mob you take pictures of increases Zeni reward significantly.
    -- If another party has claim on the mob, you will only receive 1-5 Zeni for the pictures you take, even in the best possible situation.
    if not player:hasClaim(target) then
        zeni = math.max(1, zeni * 0.01)
    end

    if player:getMainLvl() <= 10 then
        zeni = zeni / 3
    end

    -- Sanitize Zeni
    zeni = math.floor(zeni) -- Remove any floating point information
    zeni = utils.clamp(zeni, xi.znm.SOULPLATE_MIN_VALUE, xi.znm.SOULPLATE_MAX_VALUE)

    return zeni
end

xi.znm.soultrapper.packInterestData = function(target)
    local data = 0

    data = setHighBits16(data, target:getZoneID())
    data = setLowBits16(data, target:getSuperFamily())

    return data
end

-----------------------------------
-- Ryo
-----------------------------------

xi.znm.ryo = xi.znm.ryo or {}

-----------------------------------
-- onTrade
-----------------------------------

xi.znm.ryo.onTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, xi.item.SOUL_PLATE) then
        -- Cache the soulplate value on the player
        local item = trade:getItem(0)
        local zeni = xi.znm.calculatePlateZeni(player, item:getSoulPlateData())
        xi.znm.ryo.setTradedPlateValue(player, zeni)

        player:startEvent(914)
    end
end

-----------------------------------
-- onTrigger
-----------------------------------

xi.znm.ryo.onTrigger = function(player, npc)
    if xi.znm.playerHasSpokenToSanrakuBefore(player) then
        player:startEvent(913)
    else
        player:showText(npc, ID.text.MASTER_FORBID)
    end
end

-----------------------------------
-- onEventUpdate
-----------------------------------

xi.znm.ryo.onEventUpdate = function(player, csid, option, npc)
    if csid == 914 then -- Get approximate value of traded soulplate
        local zeniValue = xi.znm.ryo.tradedPlateValue(player)

        xi.znm.ryo.setTradedPlateValue(player, 0)
        player:updateEvent(zeniValue)
    elseif csid == 913 then
        if option == 200 then -- 'Sanraku's subject of interest'
            local param = xi.znm.getSanrakusInterest()

            player:updateEvent(param, 0)
        elseif option == 201 then -- 'Sanraku's recommended fauna'
            local param = xi.znm.getSanrakusFauna()

            player:updateEvent(param, 0)
        elseif option == 300 then -- 'My zeni balance'
            player:updateEvent(player:getCurrency('zeni_point'), 0)
        elseif option == 401 and player:getVar('ZeniStatus') == 1 then
            player:setVar('ZeniStatus', 2)
        elseif option == 402 and player:getVar('ZeniStatus') == 2 then -- ask about gaining access to islet's
            player:setVar('ZeniStatus', 3)
        elseif option == 404 then
            local menuOptions = 175
            local zeni = player:getCurrency('zeni_point')
            if player:getVar('ZeniStatus') >= 2 then -- add 'sanrakus subject of interest' and 'recommended fauna'
                menuOptions = menuOptions - 12
            end

            if zeni ~= 0 then -- add 'whats zeni' and 'my zeni balance' and 'islet's'
                menuOptions = menuOptions - 131
                if zeni >= 1000 then
                    menuOptions = menuOptions - 32
                end
            end

            player:updateEvent(menuOptions)
        else
            player:updateEvent(0, 0)
        end
    end
end

xi.znm.ryo.onEventFinish = function(player, csid, option, npc)
end

-----------------------------------
-- Ryo General Helpers
-----------------------------------

xi.znm.ryo.tradedPlateValue = function(player)
    return player:getLocalVar('[ZNM][Ryo]SoulPlateValue')
end

xi.znm.ryo.setTradedPlateValue = function(player, zeni)
    player:setLocalVar('[ZNM][Ryo]SoulPlateValue', zeni)
end

-----------------------------------
-- Sanraku
-----------------------------------

xi.znm.sanraku = xi.znm.sanraku or {}

-----------------------------------
-- onTrade
-----------------------------------

xi.znm.sanraku.onTrade = function(player, npc, trade)
    if trade:getItemCount() == 1 then -- One soul plate or trophy at a time
        local item = trade:getItem(0)

        if trade:getItemId() == xi.item.SOUL_PLATE then
            xi.znm.sanraku.handleTradeWithPlate(player, npc, item)
        else -- Check Trophy trading (for ZNM seals)
            xi.znm.sanraku.handleTradeWithTrophy(player, npc, item)
        end
    end
end

-----------------------------------
-- onTrade Helpers
-----------------------------------

xi.znm.sanraku.handleTradeWithPlate = function(player, npc, item)
    if not player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE) then
        local tradeLimit = xi.znm.SOULPLATE_TRADE_LIMIT

        if xi.znm.sanraku.platesTradedToday(player) >= tradeLimit then
            player:showText(npc, ID.text.APPRECIATE_MORE, 1, xi.item.SOUL_PLATE, tradeLimit)
            return
        end
    else -- If you have the KI, clear out the tracking vars!
        xi.znm.resetDailyTrackingVars(player)
    end

    -- Cache the soulplate value on the player
    local zeni = xi.znm.calculatePlateZeni(player, item:getSoulPlateData())
    xi.znm.sanraku.setTradedPlateValue(player, zeni)
    xi.znm.serverPlateTrades()

    player:startEvent(910, zeni)
end

xi.znm.sanraku.platesTradedToday = function(player)
    local currentDay = VanadielUniqueDay()
    local storedDay  = xi.znm.playerTradingDay(player)

    if currentDay ~= storedDay then
        xi.znm.resetDailyTrackingVars(player)
        return 0
    end

    return xi.znm.numberOfTradedPlates(player)
end

xi.znm.sanraku.handleTradeWithTrophy = function(player, npc, item)
    local znmSeal = xi.znm.TROPHIES[item:getID()]

    if znmSeal ~= nil then
        if player:hasKeyItem(znmSeal) then
            player:showText(npc, ID.text.SINGLE_TALLY)
        else
            xi.znm.sanraku.setTradedTrophySeal(player, znmSeal)
            player:startEvent(912, 0, 0, 1, znmSeal)
        end
    end
end

-----------------------------------
-- onTrigger
-----------------------------------

xi.znm.sanraku.onTrigger = function(player, npc)
    -- ZNM and Zeni Ineractions
    if xi.znm.playerHasSpokenToSanrakuBefore(player) then
        if player:getCurrency('zeni_point') ~= 0 then
            local param = xi.znm.sanraku.menu(player)
            player:startEvent(909, param)
        else
            player:showText(npc, ID.text.HOPES_REST)
        end
    else -- First time introduction
        player:startEvent(908)
    end
end

-----------------------------------
-- onTrigger Helpers
-----------------------------------

-- Update Sanraku's ZNM menu (csid 909) based on owned seals
xi.znm.sanraku.menu = function(player)
    -- Default: Tier 1 ZNMs + 'Don't Ask'
    -- (if bit = 0: add ZNM to Sanraku's Menu)
    local param = xi.znm.DefaultMenu

    for bitmask, seal in pairs(xi.znm.MENU_BITMASKS) do
        -- Check for each key item
        if type(seal) == 'table' then -- Higher tier ZNMs require 3 seals
            if
                player:hasKeyItem(seal[1]) and
                player:hasKeyItem(seal[2]) and
                player:hasKeyItem(seal[3])
            then
                param = bit.band(param, bit.bnot(bitmask))
            end
        else
            if player:hasKeyItem(seal) then
                param = bit.band(param, bit.bnot(bitmask))
            end
        end
    end

    return param
end

-----------------------------------
-- onEventUpdate
-----------------------------------

xi.znm.sanraku.onEventUpdate = function(player, csid, option, npc)
    if csid == 909 then
        if option == 1 or option == 500 then -- adding islets menu
            local param = player:getVar('ZeniStatus') >= 3 and 1 or 0
            player:updateEvent(param)
        elseif option >= 300 and option <= 302 then -- 'Gaining access to islets'
            xi.znm.sanraku.handleGainingAccessToIslets(player, option)
        elseif option >= 100 and option <= 130 then -- Are you sure you want info on <ZNM_mob>?
            xi.znm.sanraku.handleConfirmingDesiredZNMInfo(player, option)
        elseif option >= 400 and option <= 440 then -- Yes, I want info on <ZNM_mob>
            xi.znm.sanraku.handleConfirmedZNMInfo(player, option)
        end
    end
end

-----------------------------------
-- onEventUpdate Helpers
-----------------------------------

xi.znm.sanraku.handleGainingAccessToIslets = function(player, option)
    local zeniCost = 500 -- Base cost charged by Sanraku

    if player:hasKeyItem(xi.keyItem.RHAPSODY_IN_AZURE) then -- Reduced zeni cost
        zeniCost = 50
    end

    -- Give the correct island's information + salt
    local keyItem = xi.ki.SICKLEMOON_SALT + option - 300
    if player:getCurrency('zeni_point') < zeniCost then -- Not enough zeni
        player:updateEvent(2)
    elseif player:hasKeyItem(keyItem) then -- Already have the salt
        player:showText(GetNPCByID(ID.npc.SANRAKU), ID.text.ALREADY_IN_POSSESSION)
    else
        player:addKeyItem(keyItem)
        player:delCurrency('zeni_point', zeniCost)
        player:updateEvent(1, zeniCost, 0, keyItem)
    end
end

xi.znm.sanraku.handleConfirmingDesiredZNMInfo = function(player, option)
    -- Give the correct ZNM's zeni cost
    local diff      = option - 99
    local zeniCost = xi.znm.getPopPrice(xi.znm.POP_ITEMS[diff].mob, xi.znm.POP_ITEMS[diff].tier)

    player:updateEvent(0, 0, 0, 0, 0, 0, zeniCost)
end

xi.znm.sanraku.handleConfirmedZNMInfo = function(player, option)
    -- (440 because Warden's option is offset by 10 for some reason)
    local diff     = math.min(option - 399, 31) -- Determine the desired ZNM
    local popItem  = xi.znm.POP_ITEMS[diff].item
    local znmTier  = xi.znm.POP_ITEMS[diff].tier
    local mob      = xi.znm.POP_ITEMS[diff].mob
    local zeniCost = xi.znm.getPopPrice(mob, znmTier)

    if player:getCurrency('zeni_point') < zeniCost then -- Not enough zeni
        player:updateEvent(2)
    elseif player:getFreeSlotsCount() == 0 then -- No inventory space
        player:updateEvent(4)
    elseif player:hasItem(popItem) then -- Own pop already
        player:updateEvent(4)
    else
        -- Deduct zeni from player, increase future pop-item costs
        player:delCurrency('zeni_point', zeniCost)
        xi.znm.updatePopPrice(mob, znmTier)

        -- Give the pop item and remove the corresponding seal(s), if applicable
        player:addItem(popItem)

        local seal = xi.znm.POP_ITEMS[diff].seal

        if type(seal) == 'table' then -- Three-seal ZNMs (Tinnin, etc.)
            player:delKeyItem(seal[1])
            player:delKeyItem(seal[2])
            player:delKeyItem(seal[3])
            player:updateEvent(1, zeniCost, popItem, seal[1], seal[2], seal[3])
        elseif seal == 0 then -- Tier 1s have no seal
            player:updateEvent(1, zeniCost, popItem)
        else -- One-seal ZNMs
            player:delKeyItem(seal)
            player:updateEvent(1, zeniCost, popItem, seal)
        end
    end
end

-----------------------------------
-- onEventFinish
-----------------------------------

xi.znm.sanraku.onEventFinish = function(player, csid, option, npc)
    if csid == 910 then
        xi.znm.sanraku.handleCompletedTradeWithPlate(player)
    elseif csid == 908 then
        xi.znm.setPlayerHasSpokenToSanrakuBefore(player)
    elseif csid == 912 then
        xi.znm.sanraku.handleCompletedTradeWithTrophy(player)
    end
end

-----------------------------------
-- onEventFinish Helpers
-----------------------------------

xi.znm.sanraku.handleCompletedTradeWithPlate = function(player)
    player:tradeComplete()
    xi.znm.setPlayerTradingDay(player, VanadielUniqueDay())
    xi.znm.incrementTradedPlates(player)

    local zeniValue = xi.znm.sanraku.tradedPlateValue(player)
    xi.znm.sanraku.setTradedPlateValue(player, 0)

    player:addCurrency('zeni_point', zeniValue)
end

xi.znm.sanraku.handleCompletedTradeWithTrophy = function(player)
    player:tradeComplete()
    player:addKeyItem(xi.znm.sanraku.tradedTrophySeal(player))
    xi.znm.sanraku.setTradedTrophySeal(player, 0)
end

-----------------------------------
-- Sanraku General Helpers
-----------------------------------

xi.znm.sanraku.tradedPlateValue = function(player)
    return player:getLocalVar('[ZNM][Sanraku]SoulPlateValue')
end

xi.znm.sanraku.setTradedPlateValue = function(player, zeni)
    player:setLocalVar('[ZNM][Sanraku]SoulPlateValue', zeni)
end

xi.znm.sanraku.tradedTrophySeal = function(player)
    return player:getLocalVar('[ZNM]TrophyTrade')
end

xi.znm.sanraku.setTradedTrophySeal = function(player, trophy)
    player:setLocalVar('[ZNM]TrophyTrade', trophy)
end

-----------------------------------
---- ZNM Pop-Item Prices
-----------------------------------

xi.znm.getPopPrice = function(mob, znmTier)
    local popCost = GetServerVariable('[ZNM][' .. mob .. ']PopCost')

    -- Check to make sure the pop prices have a set value
    if
        popCost == nil or
        popCost == 0
    then
        popCost = xi.znm.ZNM_POP_COSTS[znmTier].minPrice
        SetServerVariable('[ZNM][' .. mob .. ']PopCost', popCost)
    end

    return popCost
end

-- pop prices update per purchase at the mob level
xi.znm.updatePopPrice = function(mob, znmTier)
    if not xi.znm.ZNM_STATIC_POP_PRICES then
        local popCost = math.min(xi.znm.getPopPrice(mob, znmTier) + xi.znm.ZNM_POP_COSTS[znmTier].addedPrice,
            xi.znm.ZNM_POP_COSTS[znmTier].maxPrice)
        SetServerVariable('[ZNM][' .. mob .. ']PopCost', popCost)
    end
end

-- Prices decay over time (called every 2 hours)
xi.znm.ZNMPopPriceDecay = function()
    if not xi.znm.ZNM_STATIC_POP_PRICES then
        local popCost = 0
        local mob     = nil
        local znmTier = 1

        for i = 1, 31 do
            mob     = xi.znm.POP_ITEMS[i].mob
            znmTier = xi.znm.POP_ITEMS[i].tier
            popCost = math.max(xi.znm.getPopPrice(mob, znmTier) - xi.znm.ZNM_POP_COSTS[znmTier].decayPrice,
                xi.znm.ZNM_POP_COSTS[znmTier].minPrice)

            SetServerVariable('[ZNM][' .. mob .. ']PopCost', popCost)
        end
    end
end

-----------------------------------
---- General Utility Helpers
-----------------------------------

xi.znm.playerHasSpokenToSanrakuBefore = function(player)
    return player:getVar('ZeniStatus') >= 1
end

xi.znm.setPlayerHasSpokenToSanrakuBefore = function(player)
    player:setVar('ZeniStatus', 1)
end

xi.znm.playerTradingDay = function(player)
    return player:getVar('[ZNM][Sanraku]TradingDay')
end

xi.znm.setPlayerTradingDay = function(player, day)
    player:setVar('[ZNM][Sanraku]TradingDay', day)
end

xi.znm.numberOfTradedPlates = function(player)
    return player:getVar('[ZNM][Sanraku]TradedPlates')
end

xi.znm.incrementTradedPlates = function(player)
    player:incrementCharVar('[ZNM][Sanraku]TradedPlates', 1)
end

xi.znm.resetDailyTrackingVars = function(player)
    player:setVar('[ZNM][Sanraku]TradingDay', 0)
    player:setVar('[ZNM][Sanraku]TradedPlates', 0)
end
