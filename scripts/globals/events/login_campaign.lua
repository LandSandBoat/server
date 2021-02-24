------------------------------------
-- Login Campaign
------------------------------------
require("scripts/globals/npc_util")
------------------------------------

tpz = tpz or {}
tpz.events = tpz.events or {}
tpz.events.loginCampaign = tpz.events.loginCampaign or {}

-- Change vars below to modify settings for current login campaign
loginCampaignYear = 2020
loginCampaignMonth = 12
loginCampaignDay = 10
loginCampaignDuration = 23 -- Duration is set in Earth days (Average is 23 days)

-- Checks if a Login Campaign is active.
tpz.events.loginCampaign.isCampaignActive = function()
    if ENABLE_LOGIN_CAMPAIGN == 1 then
        local local_UTC_offset = os.time() - os.time(os.date('!*t'))
        local JST_UTC_offset = 9 * 60 * 60
        local campaignStartDate = os.time({
            year = loginCampaignYear,
            month = loginCampaignMonth,
            day = loginCampaignDay,
            hour = 0,
            min = 0,
            sec = 0
        }) + local_UTC_offset + JST_UTC_offset
        local campaignEndDate = campaignStartDate + loginCampaignDuration * 24 * 60 * 60

        if os.time() < campaignEndDate and os.time() > campaignStartDate then
            return true
        end
    end
end

-- Gives Login Points once a day.
tpz.events.loginCampaign.onGameIn = function(player)
    if not tpz.events.loginCampaign.isCampaignActive()  then
        return
    end

    local zoneId      = player:getZoneID()
    local ID          = zones[zoneId]
    local loginPoints = player:getCurrency("login_points")
    local playercMonth = player:getCharVar("LoginCampaignMonth")
    local playercYear = player:getCharVar("LoginCampaignYear")
    local nextMidnight = player:getCharVar("LoginCampaignNextMidnight")
    local loginCount = player:getCharVar("LoginCampaignLoginNumber")

    -- Carry last months points if there's any
    if playercMonth ~= loginCampaignMonth or playercYear ~= loginCampaignYear then
        if loginPoints > 1500 then
            player:setCurrency("login_points", 1500)
            player:messageSpecial(ID.text.CARRIED_OVER_POINTS, 0, 1500)
        elseif loginPoints ~= 0 then
            player:messageSpecial(ID.text.CARRIED_OVER_POINTS, 0, loginPoints)
        end
        player:setCharVar("LoginCampaignMonth", loginCampaignMonth)
        player:setCharVar("LoginCampaignYear", loginCampaignYear)
        loginCount = 0
    end

    -- Show Info about campaign (month, year, login time)
    if nextMidnight ~= getMidnight() then
        player:messageSpecial(ID.text.LOGIN_CAMPAIGN_UNDERWAY, loginCampaignYear, loginCampaignMonth)

        if loginCount == 0 then
            loginCount = 1
        else
            loginCount = loginCount + 1
        end

        player:setCharVar("LoginCampaignNextMidnight", getMidnight())

        -- adds currency
        if loginCount == 1 then
            player:addCurrency("login_points", 500)
            player:messageSpecial(ID.text.LOGIN_NUMBER, 0, loginCount, 500, player:getCurrency("login_points"))
        else
            player:addCurrency("login_points", 100)
            player:messageSpecial(ID.text.LOGIN_NUMBER, 0, loginCount, 100, player:getCurrency("login_points"))
        end
        player:setCharVar("LoginCampaignLoginNumber", loginCount)
    end

end

-- Load Login Campaign Data
package.loaded["scripts/globals/events/login_campaign_data"] = nil
require("scripts/globals/events/login_campaign_data")

-- Beginning of CS with Greeter Moogle.
-- Handles showing the correct list of prices and hiding the options that are not available
tpz.events.loginCampaign.onTrigger = function(player, csid)
    if not tpz.events.loginCampaign.isCampaignActive()  then
        return
    end

    local loginPoints = player:getCurrency("login_points")
    local cYear = loginCampaignYear
    local cMonth = loginCampaignMonth
    local cDate = bit.bor(cYear, bit.lshift(loginCampaignMonth, 28))
    local currentLoginCampaign = tpz.events.loginCampaign.prizes[cYear][cMonth]
    local price = {}
    local priceShift = {}
    local hideOptions = 0

    -- Makes a table of prices
    for k, v in pairs(currentLoginCampaign) do
        price[k] = currentLoginCampaign[k]["price"]
    end

    -- Bit shifts values of prices (Defaults to 0 if price not in table)
    priceShift[1] = price[1] or 0
    priceShift[2] = bit.lshift(price[5] or 0, 16)
    priceShift[3] = price[9] or 0
    priceShift[4] = bit.lshift(price[13] or 0, 16)
    priceShift[5] = price[17] or 0
    priceShift[6] = bit.lshift(price[21] or 0, 16)
    priceShift[7] = price[25] or 0
    priceShift[8] = bit.lshift(price[29] or 0, 16)

    -- Combines two 16bit values to a single 32bit that will be passed as a CS param
    local priceBit1 = bit.bor(priceShift[1], priceShift[2])
    local priceBit2 = bit.bor(priceShift[3], priceShift[4])
    local priceBit3 = bit.bor(priceShift[5], priceShift[6])
    local priceBit4 = bit.bor(priceShift[7], priceShift[8])

    -- Turning on bits in hideOptions will make choices disappear
    for i=1, #priceShift do
        if priceShift[i] == 0 then
            hideOptions = bit.bor(hideOptions, bit.lshift(1, i - 1))
        end
    end

    -- Eight param is not used/unkown
    player:startEvent(csid, cDate, loginPoints, priceBit1, priceBit2, priceBit3, priceBit4, hideOptions)
end

-- Shows list of items depending on option selected.
-- It also is in charge of purchasing selected item.
tpz.events.loginCampaign.onEventUpdate = function(player, csid, option)
    if not tpz.events.loginCampaign.isCampaignActive() then
        return
    end

    local showItems = bit.band(option, 31) -- first 32 bits are for showing correct item list
    local itemSelected = bit.band(bit.rshift(option, 5), 31)
    local itemQuantity = bit.band(bit.rshift(option, 11), 511)
    local cYear = loginCampaignYear
    local cMonth = loginCampaignMonth
    local currentLoginCampaign = tpz.events.loginCampaign.prizes[cYear][cMonth]
    local loginPoints = player:getCurrency("login_points")

    if
        showItems == 1 or
        showItems == 5 or
        showItems == 9 or
        showItems == 13 or
        showItems == 17 or
        showItems == 21 or
        showItems == 25 or
        showItems == 29
    then
        local items = {}
        for i = 1, 20 do
            if currentLoginCampaign[showItems]["items"][i] ~= nil then
                table.insert(items, currentLoginCampaign[showItems]["items"][i])
            else
                table.insert(items, 0)
            end
        end

        player:updateEvent(
            bit.bor(items[1], bit.lshift(items[2], 16)),
            bit.bor(items[3], bit.lshift(items[4], 16)),
            bit.bor(items[5], bit.lshift(items[6], 16)),
            bit.bor(items[7], bit.lshift(items[8], 16)),
            bit.bor(items[9], bit.lshift(items[10], 16)),
            bit.bor(items[11], bit.lshift(items[12], 16)),
            bit.bor(items[13], bit.lshift(items[14], 16)),
            bit.bor(items[15], bit.lshift(items[16], 16))
        )

    elseif
        showItems == 2 or
        showItems == 6 or
        showItems == 10 or
        showItems == 14 or
        showItems == 18 or
        showItems == 22 or
        showItems == 26 or
        showItems == 30
    then
        local price = currentLoginCampaign[showItems - 1]["price"]
        local totalItemsMask = (2 ^ 20 - 1) - (2 ^ #currentLoginCampaign[showItems - 1]["items"] - 1)  -- Uses 20 bits and sets to 1 for items not used.
        local items = {}

        for i = 1, 20 do
            if currentLoginCampaign[showItems - 1]["items"][i] ~= nil then
                table.insert(items, currentLoginCampaign[showItems - 1]["items"][i])
            else
                table.insert(items, 0)
            end
        end

        player:updateEvent(
            bit.bor(items[17], bit.lshift(items[18], 16)),
            bit.bor(items[19], bit.lshift(items[20], 16)),
            totalItemsMask,
            price,
            loginPoints
        )

    else
        if npcUtil.giveItem(player, { {currentLoginCampaign[showItems - 2]["items"][itemSelected + 1], itemQuantity} }) then
            player:delCurrency("login_points", currentLoginCampaign[showItems - 2]["price"] * itemQuantity)
            player:updateEvent(
                currentLoginCampaign[showItems - 2]["items"][itemSelected + 1],
                player:getCurrency("login_points"),  -- Login Points after purchase
                0, -- Unknown (most likely totalItemMask)
                currentLoginCampaign[showItems - 2]["price"],
                loginPoints -- Login points before purchase
            )
        end
    end
end