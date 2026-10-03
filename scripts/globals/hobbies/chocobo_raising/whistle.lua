-----------------------------------
-- Chocobo Raising - Chocobo Whistle
-----------------------------------
require('scripts/globals/rental_chocobo')
require('scripts/globals/hobbies/chocobo_raising/breeding')
require('scripts/globals/hobbies/chocobo_raising/constants')
require('scripts/globals/hobbies/chocobo_raising/model')
require('scripts/globals/hobbies/chocobo_raising/user_data')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}
xi.chocoboRaising.whistle = xi.chocoboRaising.whistle or {}

-----------------------------------
-- Constants
-----------------------------------
local whistle = xi.chocoboRaising.whistle

whistle.registrationPrice = 250
whistle.replacementPrice  = 20000
whistle.pricePerCharge    = 400
whistle.maxCharges        = 25

whistle.prog = xi.chocoboRaising.whistleProg

local rechargePriceVar = '[ChocoboRaising]WhistlePrice'

-- Set when the quest's whistle did not fit in the inventory.
whistle.pendingVar = '[ChocoboRaising]WhistlePending'

-----------------------------------
-- Tables
-----------------------------------
whistle.events =
{
    [xi.zone.SOUTHERN_SAN_DORIA] = { card = 844, whistle = 845 },
    [xi.zone.BASTOK_MINES]       = { card = 525, whistle = 533 },
    [xi.zone.WINDURST_WOODS]     = { card = 752, whistle = 760 },
}

---@enum xi.chocoboRaising.whistle.option
whistle.option =
{
    BUY_WHISTLE     = 221,
    RECEIVE_WHISTLE = 222,
    PAY_RECHARGE    = 220,
    USE_COUPON      = 476,
    CHOCOCARD       = 495,
    REGISTER        = 479,
}

-- A set bit hides the entry.
---@enum whistleCardMenu
local cardMenu =
{
    RECEIVE_WHISTLE = 0,
    BUY_WHISTLE     = 1,
    CHOCOCARD       = 2,
    REGISTER        = 3,
    NOTHING         = 31,
}

-----------------------------------
-- Specs
-----------------------------------
---@class ChocoboRegisteredStats
---@field strength    integer
---@field endurance   integer
---@field discernment integer
---@field receptivity integer

---@class ChocoboRide
---@field seconds integer

-----------------------------------
-- Helpers
-----------------------------------
local function tradeItem(trade, itemId)
    for slot = 0, 7 do
        local item = trade:getItem(slot)
        if item and item:getID() == itemId then
            return item
        end
    end

    return nil
end

-- Unlike npcUtil.tradeHasExactly this confirms nothing, so releasing the trade hands it all back.
local function tradeIsExactly(trade, items)
    if trade:getItemCount() ~= #items then
        return false
    end

    for _, itemId in ipairs(items) do
        if not trade:hasItemQty(itemId, 1) then
            return false
        end
    end

    return true
end

-----------------------------------
-- Private Functions
-----------------------------------
local function refill(player)
    if not player:tradeComplete() then
        return false
    end

    player:addItem({ id = xi.item.CHOCOBO_WHISTLE })

    return true
end

---@param card ExdataChocoboCard
---@return table
local function chocoboFromCard(card)
    local appearance = 0
    if card.strength and card.strength.trait then
        appearance = appearance + xi.chocoboRaising.appearance.LARGE_TALONS
    end

    if card.endurance and card.endurance.trait then
        appearance = appearance + xi.chocoboRaising.appearance.FULL_TAIL
    end

    if card.discernment and card.discernment.trait then
        appearance = appearance + xi.chocoboRaising.appearance.LARGE_BEAK
    end

    local abilities = card.abilities or {}

    return
    {
        color              = card.color or 0,
        appearance         = appearance,
        strength           = xi.chocoboRaising.cardStat(card, 'strength'),
        endurance          = xi.chocoboRaising.cardStat(card, 'endurance'),
        discernment        = xi.chocoboRaising.cardStat(card, 'discernment'),
        receptivity        = xi.chocoboRaising.cardStat(card, 'receptivity'),
        ability1           = abilities[1] or 0,
        ability2           = abilities[2] or 0,
        weather_preference = card.weather or 0,
    }
end

local function cardMenuMask(player)
    local shown = { cardMenu.CHOCOCARD, cardMenu.NOTHING }

    if xi.chocoboRaising.hasUserFlag(player, xi.chocoboRaising.userFlag.WHISTLE_QUEST_DONE) then
        table.insert(shown, cardMenu.REGISTER)
    end

    if whistle.canReceiveWhistle(player) then
        table.insert(shown, cardMenu.RECEIVE_WHISTLE)
    end

    if whistle.canBuyWhistle(player) then
        table.insert(shown, cardMenu.BUY_WHISTLE)
    end

    local mask = 0xFFFFFFFF
    for _, entry in ipairs(shown) do
        mask = bit.band(mask, bit.bnot(bit.lshift(1, entry)))
    end

    return mask
end

-----------------------------------
-- Global Functions
-----------------------------------
---@param ranks integer
---@return integer
whistle.ridingMinutes = function(ranks)
    return math.floor(xi.chocoboRaising.ridingTimeBase + xi.chocoboRaising.ridingTimePerRank * math.min(ranks, xi.chocoboRaising.ridingTimeMaxRank))
end

---@param strength integer
---@param abilities xi.chocoboRaising.ability[]
---@param extraRanks? integer
---@return integer
whistle.ridingSpeed = function(strength, abilities, extraRanks)
    local ranks = xi.chocoboRaising.numberToRank(strength) + (extraRanks or 0)
    if
        abilities[1] == xi.chocoboRaising.ability.GALLOP or
        abilities[2] == xi.chocoboRaising.ability.GALLOP
    then
        ranks = ranks + 1
    end

    local percent = xi.chocoboRaising.ridingSpeedBase + xi.chocoboRaising.ridingSpeedPerRank * math.min(ranks, xi.chocoboRaising.ridingSpeedMaxRank)

    -- The client is sent half of this, and 0 reads as rental speed, so 2 is the slowest a chocobo can ride.
    return math.max(math.floor(xi.settings.map.MOUNT_SPEED * percent / 100), 2)
end

---@param chocobo table
---@return table
whistle.registration = function(chocobo)
    local appearance = chocobo.appearance or 0
    local abilities  = { chocobo.ability1, chocobo.ability2 }
    local speed      = whistle.ridingSpeed(chocobo.strength, abilities)

    local timeRanks = xi.chocoboRaising.numberToRank(chocobo.endurance)
    if
        abilities[1] == xi.chocoboRaising.ability.CANTER or
        abilities[2] == xi.chocoboRaising.ability.CANTER
    then
        timeRanks = timeRanks + 1
    end

    return
    {
        color       = chocobo.color,
        largeBeak   = bit.band(appearance, xi.chocoboRaising.appearance.LARGE_BEAK) ~= 0,
        fullTail    = bit.band(appearance, xi.chocoboRaising.appearance.FULL_TAIL) ~= 0,
        largeTalons = bit.band(appearance, xi.chocoboRaising.appearance.LARGE_TALONS) ~= 0,
        speed       = speed,
        minutes     = whistle.ridingMinutes(timeRanks),

        -- Purple Race Silks count as one more STR rank while they are worn.
        silksSpeedBonus = whistle.ridingSpeed(chocobo.strength, abilities, 1) - speed,

        -- Kept for digging, which reads more than the mount stores.
        ability1    = chocobo.ability1,
        ability2    = chocobo.ability2,
        strength    = chocobo.strength,
        endurance   = chocobo.endurance,
        discernment = chocobo.discernment,
        receptivity = chocobo.receptivity or 0,
        weather     = chocobo.weather_preference or 0,
    }
end

---@param player CBaseEntity
---@param chocobo table
---@return boolean
whistle.register = function(player, chocobo)
    local ID = zones[player:getZoneID()]

    if player:getGil() < whistle.registrationPrice then
        player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        return false
    end

    player:delGil(whistle.registrationPrice)
    player:registerChocobo(whistle.registration(chocobo))

    return true
end

---@param player CBaseEntity
---@return xi.chocoboRaising.ability[]
whistle.registeredAbilities = function(player)
    local data = player:getChocoboUserData()

    return { data.registeredAbility1, data.registeredAbility2 }
end

---@param player CBaseEntity
---@return ChocoboRegisteredStats
whistle.registeredStats = function(player)
    local data = player:getChocoboUserData()

    return
    {
        strength    = data.registeredStrength,
        endurance   = data.registeredEndurance,
        discernment = data.registeredDiscernment,
        receptivity = data.registeredReceptivity,
    }
end

-- Red Racing Silks add their minutes when the chocobo is called. Purple ones count only while worn.
---@param player CBaseEntity
---@return ChocoboRide?
whistle.ride = function(player)
    local chocobo = player:getFieldChocobo()
    if not chocobo then
        return nil
    end

    -- Registered before riding times were stored, so it rides as long as a rental.
    local minutes = chocobo.minutes
    if minutes == 0 then
        minutes = xi.rentalChocobo.rideMinutes
    end

    minutes = minutes + math.max(player:getMod(xi.mod.PERSONAL_CHOCOBO_TIME), 0)

    return
    {
        seconds = minutes * 60,
    }
end

-- Returns true when the trade was a whistle or a registration card.
---@param player CBaseEntity
---@param npc CBaseEntity
---@param trade CTradeContainer
---@return boolean
whistle.onTrade = function(player, npc, trade)
    local events = whistle.events[player:getZoneID()]
    if not events then
        return false
    end

    if
        tradeIsExactly(trade, { xi.item.CHOCOBO_WHISTLE }) or
        tradeIsExactly(trade, { xi.item.CHOCOBO_WHISTLE, xi.item.WHISTLE_COUPON })
    then
        local used  = whistle.maxCharges - tradeItem(trade, xi.item.CHOCOBO_WHISTLE):getCurrentCharges()
        local price = used * whistle.pricePerCharge

        -- A price of 0 tells the event the coupon paid. A full whistle keeps its coupon.
        if
            used > 0 and
            tradeItem(trade, xi.item.WHISTLE_COUPON)
        then
            price = 0

            if not refill(player) then
                return true
            end
        end

        player:setLocalVar(rechargePriceVar, price)
        player:startEvent(events.whistle, used, price)

        return true
    end

    if tradeIsExactly(trade, { xi.item.VCS_REGISTRATION_CARD }) then
        local name = tradeItem(trade, xi.item.VCS_REGISTRATION_CARD):getExData().name or ''
        player:startEventString(events.card, name, name, name, name, cardMenuMask(player))

        return true
    end

    return false
end

---@param player CBaseEntity
---@param csid integer
---@param option integer
---@return boolean
whistle.onEventUpdate = function(player, csid, option)
    local events = whistle.events[player:getZoneID()]
    if not events then
        return false
    end

    if csid == events.whistle and option == whistle.option.USE_COUPON then
        player:updateEvent(0xFFFFFFFF, whistle.option.USE_COUPON, 0, 0, 0, 0, 0, 0)
        return true
    end

    return false
end

---@param player CBaseEntity
---@return boolean
whistle.canReceiveWhistle = function(player)
    return player:getCharVar(whistle.pendingVar) == 1
end

---@param player CBaseEntity
---@return boolean
whistle.canBuyWhistle = function(player)
    return xi.chocoboRaising.hasUserFlag(player, xi.chocoboRaising.userFlag.WHISTLE_QUEST_DONE) and
        not whistle.canReceiveWhistle(player) and
        not player:hasItem(xi.item.CHOCOBO_WHISTLE)
end

-- The quest's reward: kept for "Receive your whistle" when the inventory is full.
---@param player CBaseEntity
---@return boolean
whistle.giveQuestWhistle = function(player)
    if npcUtil.giveItem(player, xi.item.CHOCOBO_WHISTLE) then
        player:setCharVar(whistle.pendingVar, 0)
        return true
    end

    player:setCharVar(whistle.pendingVar, 1)

    return false
end

---@param player CBaseEntity
---@return boolean
whistle.receiveWhistle = function(player)
    if not whistle.canReceiveWhistle(player) then
        return false
    end

    return whistle.giveQuestWhistle(player)
end

---@param player CBaseEntity
---@return boolean
whistle.buyWhistle = function(player)
    if not whistle.canBuyWhistle(player) then
        return false
    end

    local ID = zones[player:getZoneID()]

    if player:getGil() < whistle.replacementPrice then
        player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        return false
    end

    if player:getFreeSlotsCount() == 0 then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.CHOCOBO_WHISTLE)
        return false
    end

    player:delGil(whistle.replacementPrice)
    player:addItem({ id = xi.item.CHOCOBO_WHISTLE })
    player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.CHOCOBO_WHISTLE)

    return true
end

---@param player CBaseEntity
---@param csid integer
---@param option integer
---@return boolean
whistle.onEventFinish = function(player, csid, option)
    local events = whistle.events[player:getZoneID()]
    if not events then
        return false
    end

    if csid == events.whistle then
        local price = player:getLocalVar(rechargePriceVar)
        player:setLocalVar(rechargePriceVar, 0)

        if
            option == whistle.option.PAY_RECHARGE and
            price > 0 and
            player:getGil() >= price
        then
            if refill(player) then
                player:delGil(price)
            end
        elseif player:getTrade():getItemCount() > 0 then
            -- With nothing confirmed, confirming takes nothing and releases the trade.
            player:confirmTrade()
        end

        return true
    end

    if csid == events.card then
        local card = tradeItem(player:getTrade(), xi.item.VCS_REGISTRATION_CARD)

        if option == whistle.option.CHOCOCARD and card then
            local ID     = zones[player:getZoneID()]
            local exdata = card:getExData()
            local cardID = exdata.gender == xi.chocoboRaising.gender.FEMALE and xi.item.CHOCOCARD_F or xi.item.CHOCOCARD_M

            if player:getGil() < xi.chocoboRaising.chococardPrice then
                player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
            elseif player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, cardID)
            else
                player:delGil(xi.chocoboRaising.chococardPrice)
                player:addItem({ id = cardID, exdata = exdata })
                player:messageSpecial(ID.text.ITEM_OBTAINED, cardID)
            end
        elseif
            option == whistle.option.REGISTER and
            card and
            xi.chocoboRaising.hasUserFlag(player, xi.chocoboRaising.userFlag.WHISTLE_QUEST_DONE)
        then
            whistle.register(player, chocoboFromCard(card:getExData()))
        elseif option == whistle.option.BUY_WHISTLE then
            whistle.buyWhistle(player)
        elseif option == whistle.option.RECEIVE_WHISTLE then
            whistle.receiveWhistle(player)
        end

        -- The card is shown, never taken: with nothing confirmed, confirming releases the trade.
        if card then
            player:confirmTrade()
        end

        return true
    end

    return false
end
