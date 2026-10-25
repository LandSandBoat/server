-----------------------------------
-- A.M.A.N. Trove
-- Greyson (Lower Jeuno).
-----------------------------------
xi = xi or {}
xi.amanTrove = xi.amanTrove or {}

local exploringTheTrove = 1447

local greysonEvent =
{
    NOT_ELIGIBLE = 20082,
    INTRO        = 20083,
    MENU         = 20084,
    DEPOSIT      = 20085,
}

-- Prices and limits are read by event 20084 from its own bytecode.
local voucherPrice      = 100000
local monthlyVouchers   = 5
local maxStoredVouchers = 9999

-- Observed on retail: a 45-day wait for new characters.
local minAgeDays = 45

-- Orbs sold by Greyson, indexed by event 20084 option.
local orbsForSale =
{
    [1] = { itemId = xi.item.MARS_ORB,  cost =  6 },
    [2] = { itemId = xi.item.VENUS_ORB, cost = 10 },
}

-- Vouchers bought at once, indexed by event 20084 option. The monthly limit caps option 4.
local vouchersForSale =
{
    [3] = 1,
    [4] = monthlyVouchers,
}

-- Vouchers bought this month.
-- TODO: Capture needed. The JP wiki says both "per Earth month" and "per monthly version update", so JST months stand in.
local function getVouchersBought(player)
    if player:getCharVar('[AMAN]VoucherMonth') ~= JstYear() * 100 + JstMonth() then
        return 0
    end

    return player:getCharVar('[AMAN]VouchersBought')
end

-- Turns the player away and returns true when they can't use Greyson's services yet.
local function turnAwayIneligible(player)
    if xi.settings.main.ENABLE_AMAN_TROVE ~= 1 then
        player:startEvent(greysonEvent.NOT_ELIGIBLE)
        return true
    end

    -- Observed on retail: a young character gets this message and no event.
    local ageDays = (GetSystemTime() - player:getTimeCreated()) / 86400
    if ageDays < minAgeDays then
        player:messageSpecial(zones[xi.zone.LOWER_JEUNO].text.YOU_MUST_WAIT_ANOTHER_N_DAYS, math.ceil(minAgeDays - ageDays))
        return true
    end

    -- TODO: Capture needed. The JP wiki and BG say main job 99, and 20082 asks for a deeper understanding of Records of Eminence.
    if
        player:getMainLvl() < 99 or
        not player:getEminenceCompleted(exploringTheTrove) and not player:getEminenceProgress(exploringTheTrove)
    then
        player:startEvent(greysonEvent.NOT_ELIGIBLE)
        return true
    end

    return false
end

xi.amanTrove.onGreysonTrade = function(player, npc, trade)
    if turnAwayIneligible(player) then
        return
    end

    local ID = zones[xi.zone.LOWER_JEUNO]

    -- TODO: Capture needed. This isn't in any event, so when it fires is a guess.
    if not player:getEminenceCompleted(exploringTheTrove) then
        player:messageSpecial(ID.text.NO_NEED_TO_HURRY)
        return
    end

    -- The vouchers are taken and stored when the deposit event finishes.
    local vouchers = trade:getItemQty(xi.item.SILVER_AMAN_VOUCHER)
    if vouchers > 0 then
        local newTotal = player:getCurrency('silver_aman_voucher') + vouchers
        if newTotal > maxStoredVouchers then
            player:messageSpecial(ID.text.CANT_CARRY_ANY_MORE)
            return
        end

        if npcUtil.tradeMatches(trade, { { xi.item.SILVER_AMAN_VOUCHER, vouchers } }) then
            player:setLocalVar('[AMAN]Deposit', vouchers)
            player:startEvent(greysonEvent.DEPOSIT, newTotal)
        end

        return
    end

    for _, orbId in ipairs({ xi.item.MARS_ORB, xi.item.VENUS_ORB }) do
        if npcUtil.tradeMatches(trade, { { orbId, 1 } }) then
            if player:getWornUses(orbId) == 0 then
                player:messageSpecial(ID.text.ORB_NOT_USED_YET)
                return
            end

            -- TODO: Capture needed. BG estimates 5% a fresh orb, 25% a key or copper voucher and 70% juice.
            -- The Moglification is only said to lower the juice chance a little.
            local juiceChance = player:hasKeyItem(xi.keyItem.MOGLIFICATION_AMAN_TROVE) and 65 or 70
            local roll        = math.randomInt(1, 100)
            local reward      = utils.randomEntry({ xi.item.BOTTLE_OF_ORANGE_JUICE, xi.item.BOTTLE_OF_APPLE_JUICE })
            if roll <= 5 then
                reward = orbId
            elseif roll <= 100 - juiceChance then
                reward = utils.randomEntry({ xi.item.SPECIAL_GOBBIEDIAL_KEY, xi.item.COPPER_AMAN_VOUCHER })
            end

            -- npcUtil.giveItem would refuse a fresh orb while the used one is still in the trade, so check space first.
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward)
                return
            end

            player:tradeComplete()
            if reward == orbId then
                player:messageSpecial(ID.text.ORB_FRESHLY_CHARGED, reward)
            else
                player:messageSpecial(ID.text.ORB_FREEBIE, reward)
            end

            npcUtil.giveItem(player, reward)

            return
        end
    end
end

xi.amanTrove.onGreysonTrigger = function(player, npc)
    if turnAwayIneligible(player) then
        return
    end

    if not player:getEminenceCompleted(exploringTheTrove) then
        player:startEvent(greysonEvent.INTRO)
        return
    end

    -- A.M.A.N. Trove (M). Observed on retail: it completes on the click, before the menu opens.
    xi.roe.onRecordTrigger(player, 3768)

    player:startEvent(greysonEvent.MENU, player:getCurrency('silver_aman_voucher'), getVouchersBought(player), player:getGil())
end

-- The client checks costs and limits before it returns an option, so everything is checked again here.
xi.amanTrove.onGreysonEventFinish = function(player, csid, option, npc)
    if csid == greysonEvent.INTRO then
        -- TODO: Capture needed. The wikis say talking to Greyson completes the record, but the event never touches it.
        xi.roe.onRecordTrigger(player, exploringTheTrove)
        return
    end

    local stored = player:getCurrency('silver_aman_voucher')

    if csid == greysonEvent.DEPOSIT then
        local vouchers = player:getLocalVar('[AMAN]Deposit')
        player:setLocalVar('[AMAN]Deposit', 0)

        if
            vouchers > 0 and
            stored + vouchers <= maxStoredVouchers and
            player:tradeComplete()
        then
            player:addCurrency('silver_aman_voucher', vouchers)
        end

        return
    end

    if csid ~= greysonEvent.MENU then
        return
    end

    local orb = orbsForSale[option]
    if orb then
        if
            stored >= orb.cost and
            npcUtil.giveItem(player, orb.itemId)
        then
            player:delCurrency('silver_aman_voucher', orb.cost)
        end

        return
    end

    local vouchers = vouchersForSale[option]
    if not vouchers then
        return
    end

    local bought = getVouchersBought(player)
    local amount = math.min(vouchers, monthlyVouchers - bought)
    local cost   = amount * voucherPrice

    if
        amount > 0 and
        player:getGil() >= cost and
        stored + amount <= maxStoredVouchers
    then
        player:delGil(cost)
        player:addCurrency('silver_aman_voucher', amount)
        player:setCharVar('[AMAN]VoucherMonth', JstYear() * 100 + JstMonth())
        player:setCharVar('[AMAN]VouchersBought', bought + amount)
    end
end
