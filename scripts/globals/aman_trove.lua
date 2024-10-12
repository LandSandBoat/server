-----------------------------------
-- A.M.A.N. Trove
--
-- TODO: Make sure there's no funny business across multiple battle areas
-- TODO: Make sure there's no funny business across multiple party members in different areas or BCs
-- TODO: Make sure party members in the same BC all count towards the same BC
-- TODO: Make sure nothing can be packet inspected or injected to guess outcomes
-- TODO: Make sure there's a sanity routine to make sure a BC can't be _too_ valuable
-- TODO: Make sure there's logging of BC state at setup, and how successful the player was (% of loot obtained, possible value)
-----------------------------------
xi = xi or {}
xi.amanTrove = xi.amanTrove or {}
local lowerJeunoID = zones[xi.zone.LOWER_JEUNO]

-- Balgas Dias
-- 7702 : You hear a loud thud, as if a large amount of spoils spontaneously appeared.
-- 7703 : You hear a thud, as if a large amount of spoils spontaneously appeared.
-- 7704 : You hear a noise, as if a large amount of spoils spontaneously appeared.
-- 7705 : You receive # gil as a bonus reward!
-- 7706 : You hear a belligerent bang from one of the remaining treasure chests.

-----------------------------------
-- General
-----------------------------------
xi.amanTrove.numChests = 10

xi.amanTrove.chestType =
{
    SMALL_LOOT  = 0, -- Noise
    MEDIUM_LOOT = 1, -- Thud
    LARGE_LOOT  = 2, -- Loud Thud
    RAINBOW     = 3, -- Guaranteed Loud Thud (Large)
    GOLD        = 4, -- Guaranteed Thud (Medium)
    MIMIC       = 5,
}

-----------------------------------
-- Mars
-----------------------------------
xi.amanTrove.marsChanceOfPerfectRun = 2.5 -- % chance of being able to get through all chests without a mimic
xi.amanTrove.marsMimicChance = (1.0 - math.pow(xi.amanTrove.marsChanceOfPerfectRun / 100, 1 / xi.amanTrove.numChests)) * 100
-- Works out to: 30.84% chance of a mimic on any chest

-- This is the percentage of the remainder of the roll after the mimic check is done
xi.amanTrove.marsLootChances =
{
    -- Percent chance of each kind of loot.
    -- Must add up to 100!
    SMALL  = 80,
    MEDIUM = 15,
    LARGE  = 5,
}

xi.amanTrove.marsLootLimits =
{
    MEDIUM = 3,
    LARGE  = 2,
}

xi.amanTrove.marsGuaranteedLoot =
{
    MEDIUM = 0,
    LARGE  = 0,
}

-----------------------------------
-- Venus
-----------------------------------
xi.amanTrove.venusChanceOfPerfectRun = 0.5 -- % chance of being able to get through all chests without a mimic
xi.amanTrove.venusMimicChance = (1.0 - math.pow(xi.amanTrove.venusChanceOfPerfectRun / 100, 1 / xi.amanTrove.numChests)) * 100
-- Works out to: 41.13% chance of a mimic on any chest

-- This is the percentage of the remainder of the roll after the mimic check is done
xi.amanTrove.venusLootChances =
{
    -- Percent chance of each kind of loot.
    -- Must add up to 100!
    SMALL  = 70,
    MEDIUM = 22,
    LARGE  = 8,
}

xi.amanTrove.venusLootLimits =
{
    MEDIUM = 4,
    LARGE  = 3,
}

xi.amanTrove.venusGuaranteedLoot =
{
    MEDIUM = 1,
    LARGE  = 1,
}

-----------------------------------
-- Local Functions
-----------------------------------

local addSmallLoot = function(battlefield)
    battlefield:setLocalVar('SmallLoot', battlefield:getLocalVar('SmallLoot') + 1)
end

local addMediumLoot = function(battlefield)
    battlefield:setLocalVar('MediumLoot', battlefield:getLocalVar('MediumLoot') + 1)
end

local addLargeLoot = function(battlefield)
    battlefield:setLocalVar('LargeLoot', battlefield:getLocalVar('LargeLoot') + 1)
end

local getLoot = function(battlefield)
    return {
        smallLoot  = battlefield:getLocalVar('SmallLoot'),
        mediumLoot = battlefield:getLocalVar('MediumLoot'),
        largeLoot  = battlefield:getLocalVar('LargeLoot'),
    }
end

-----------------------------------
-- Global Functions
-----------------------------------
xi.amanTrove.setupBattlefield = function(battlefield)
    local zone = GetZone(battlefield:getZoneID())
    local ID   = zones[zone:getID()]

    -- Setup Terminal Coffer
    local battleArea     = battlefield:getArea()
    local terminalCoffer = GetNPCByID(ID.npc.TERMINAL_COFFER + (battleArea - 1) * 11)

    -- NPC
    terminalCoffer:setStatus(xi.status.NORMAL)
    terminalCoffer:setUntargetable(false)

    -- Setup Chests (mobs)
    -- We pre-allocate everything rather than rolling on things at trigger-time.
    local mimicChest = math.random(0, 9)

    for i = 0, 9 do
        local chest = GetMobByID(ID.mob.CHEST_O_PLENTY + i + (battleArea - 1) * 11)

        chest:setStatus(xi.status.NORMAL) -- Make mob triggerable
        chest:setUntargetable(false)

        if i == mimicChest then
            chest:setLocalVar('Mimic', 1)
        end
    end
end

xi.amanTrove.chestOPlentyOnTrigger = function(player, npc)
    print('xi.amanTrove.chestOPlentyOnTrigger')

    -- Debouncing (just in case)
    if npc:getLocalVar('Triggered') == 1 then
        return
    end

    npc:setLocalVar('Triggered', 1)

    if npc:getLocalVar('Mimic') == 1 then
        xi.amanTrove.prepareMimic(player, npc)
        return
    end

    local zone = player:getZone()
    local ID   = zones[zone:getID()]

    player:messageSpecial(ID.text.LOUD_THUD)
    addSmallLoot(player:getBattlefield())

    npc:setAnimationSub(1)
    npc:setUntargetable(true)

    -- TODO: Thuds etc.
end

xi.amanTrove.terminalCofferOnTrigger = function(player, npc)
    print('xi.amanTrove.terminalCofferOnTrigger')
    -- Debouncing (just in case)
    if npc:getLocalVar('Triggered') == 1 then
        return
    end

    npc:setLocalVar('Triggered', 1)

    npc:setAnimationSub(1)
    npc:setUntargetable(true)

    -- TODO: Count up thuds, etc. generate loot
    -- local loot = getLoot(player:getBattlefield())

    -- TODO: We're going to predetermine how many thuds etc. there are
    --     : available at the start of the BC. If somehow we get to this point
    --     : and there are more than we allocated - then the player has managed
    --     : to cheat and we should report it and make sure they don't get any
    --     : loot!
end

xi.amanTrove.prepareMimic = function(player, npc)
    print('xi.amanTrove.prepareMimic')

    local battlefield = player:getBattlefield()
    local battleArea  = battlefield:getArea()
    local ID = zones[player:getZoneID()]

    -- Hide all non-mimic entities
    local entitiesToHide = {}
    for i = 0, 9 do
        local chest = GetMobByID(ID.mob.CHEST_O_PLENTY + i + (battleArea - 1) * 11)
        if
            chest:getLocalVar('Mimic') ~= 1 and
            chest:getLocalVar('Triggered') ~= 1 -- Triggered chests stay visible
        then
            table.insert(entitiesToHide, chest)
        end
    end

    local terminalCoffer = GetNPCByID(ID.npc.TERMINAL_COFFER + (battleArea - 1) * 11)
    table.insert(entitiesToHide, terminalCoffer)

    for _, entity in ipairs(entitiesToHide) do
        entity:setStatus(xi.status.DISAPPEAR)
        entity:setUntargetable(true)
    end

    -- TODO: Making the mimic essentially unbeatable for now
    --     : until there's more evidence of how powerful it is.

    npc:setStatus(xi.status.UPDATE)
    npc:setModelId(258)
    npc:setAnimationSub(1) -- Mouth open
    npc:setHP(1500000)
    npc:addEnmity(player, 1, 0)
end

-----------------------------------
-- Greyson
-----------------------------------
local exploringTheTrove = 1447

xi.amanTrove.greysonReturnRoll = function(player, tradedOrbType)
    local roll = math.random(1, 100)

    local rechargeChance = 1 -- 1% chance of recharge
    if player:hasKeyItem(xi.ki.MOGLIFICATION_AMAN_TROVE) then
        rechargeChance = rechargeChance + 5 -- Total: 6% chance of recharge
    end

    if roll <= rechargeChance then
        return tradedOrbType
    elseif roll <= rechargeChance + 10 then -- The next 10%
        return xi.item.SP_DIAL_KEY
    elseif roll <= rechargeChance + 20 then -- The next 10%
        return xi.item.COPPER_AMAN_VOUCHER
    end

    -- Otherwise:
    return utils.randomEntry({ xi.item.BOTTLE_OF_ORANGE_JUICE, xi.item.BOTTLE_OF_APPLE_JUICE })
end

xi.amanTrove.onGreysonTrade = function(player, npc, trade)
    local playerAgeDays         = (os.time() - player:getTimeCreated()) / 86400
    local playerOldEnough       = playerAgeDays >= 45 -- TODO: Extract into setting
    local playerLevelHighEnough = player:getMainLvl() >= 99
    local eminenceCompleted     = player:getEminenceCompleted(exploringTheTrove)

    -- TODO: If you trade junk + a valid item, he'll respond to the valid item
    -- TODO: If the trade contains a valid item, you'll get a message. If not, you won't.
    -- local validItems = { xi.item.SILVER_VOUCHER, xi.item.MARS_ORB, xi.item.VENUS_ORB }
    if
        not playerOldEnough or
        not playerLevelHighEnough or not eminenceCompleted
    then
        player:messageSpecial(lowerJeunoID.text.NO_NEED_TO_HURRY)
        return
    end

    if npcUtil.tradeHas(trade, xi.item.SILVER_AMAN_VOUCHER) then
        local numVouchers = trade:getItemQty(xi.item.SILVER_AMAN_VOUCHER)
        local silverVouchersStored = player:getCurrency('silver_aman_voucher')
        if silverVouchersStored + numVouchers > 255 then
            player:messageSpecial(lowerJeunoID.text.CANT_CARRY_ANY_MORE)
            return
        end

        -- TODO: Confirm all silver vouchers in trade so they're removed during confirm
        -- CS amounts are correct, currency amounts are correct, the trade removed amount is incorrect

        player:addCurrency('silver_aman_voucher', numVouchers)
        silverVouchersStored = player:getCurrency('silver_aman_voucher')

        player:startEvent(20085, silverVouchersStored)
        player:confirmTrade()
    elseif npcUtil.tradeHasExactly(trade, xi.item.MARS_ORB) then
        local item = trade:getItem()
        if item:getWornUses() > 0 then
            local loot = xi.amanTrove.greysonReturnRoll(player, xi.item.MARS_ORB)
            if loot == xi.item.MARS_ORB then
                player:messageSpecial(lowerJeunoID.text.ALREADY_BEEN_USED_ORB, loot)
            else
                player:messageSpecial(lowerJeunoID.text.ALREADY_BEEN_USED_ITEM, loot)
            end

            -- If you have a full inventory and trade in an old orb, you'll still get the new item
            player:confirmTrade()
            player:addItem(loot)
        else
            player:messageSpecial(lowerJeunoID.text.THIS_ONE_HASNT_BEEN_USED)
        end
    elseif npcUtil.tradeHasExactly(trade, xi.item.VENUS_ORB) then
        local item = trade:getItem()
        if item:getWornUses() > 0 then
            local loot = xi.amanTrove.greysonReturnRoll(player, xi.item.VENUS_ORB)
            if loot == xi.item.VENUS_ORB then
                player:messageSpecial(lowerJeunoID.text.ALREADY_BEEN_USED_ORB, loot)
            else
                player:messageSpecial(lowerJeunoID.text.ALREADY_BEEN_USED_ITEM, loot)
            end

            -- If you have a full inventory and trade in an old orb, you'll still get the new item
            player:confirmTrade()
            player:addItem(loot)
        else
            player:messageSpecial(lowerJeunoID.text.THIS_ONE_HASNT_BEEN_USED)
        end
    end
end

xi.amanTrove.onGreysonTrigger = function(player, npc)
    local playerGil             = player:getGil()
    local playerAgeDays         = (os.time() - player:getTimeCreated()) / 86400
    local playerOldEnough       = playerAgeDays >= 45 -- TODO: Extract into setting
    local playerLevelHighEnough = player:getMainLvl() >= 99
    local eminenceProgress      = player:getEminenceProgress(exploringTheTrove) -- nil: not flagged, 0: flagged and not completed, 1: flagged and completed
    local eminenceCompleted     = player:getEminenceCompleted(exploringTheTrove)
    local silverVouchersStored  = player:getCurrency('silver_aman_voucher')

    -- TODO: This will have to reset once a month, or whenever, a setting?
    local silverVouchersBought = player:getCharVar('[AMAN]SilverVouchersBought')

    -- NOTE: Is the cost of vouchers hard coded into the CS? Yes
    -- NOTE: Is the cost of orbs hard coded into the CS? Yes
    -- NOTE: Is the number of buyable vouchers hard coded into the CS? Yes

    if
        playerOldEnough and
        playerLevelHighEnough and
        eminenceProgress == 0 and
        not eminenceCompleted
    then
        -- Intro text
        player:startEvent(20083)
        return
    end

    if eminenceCompleted then
        -- Main menu
        -- TODO: Are there other menu options to hide 'buy single', and 'buy multiple' when those options aren't available?
        player:startEvent(20084, silverVouchersStored, silverVouchersBought, playerGil)
        return
    end

    -- Fall through to default rejection text
    player:startEvent(20082)
end

xi.amanTrove.onGreysonEventUpdate = function(player, csid, option, npc)
    -- NOTE: Seemingly unused?
end

-- NOTE: Make sure to validate gil amounts/voucher levels before giving things in case of injection
xi.amanTrove.onGreysonEventFinish = function(player, csid, option, npc)
    if csid == 20083 then -- Intro CS
        if player:getEminenceProgress(exploringTheTrove) == 0 then
            xi.roe.onRecordTrigger(player, exploringTheTrove)
        end
    elseif csid == 20084 then -- Menu
        local playerGil               = player:getGil()
        local silverVouchersStored    = player:getCurrency('silver_aman_voucher')
        local silverVouchersBought    = player:getCharVar('[AMAN]SilverVouchersBought')
        local silverVouchersAvailable = 5 - silverVouchersBought
        local voucherCost             = 100000
        local vouchersTotalCost       = silverVouchersAvailable * voucherCost

        if option == 1 then -- Bought Mars Orb
            if silverVouchersStored >= 6 and npcUtil.giveItem(player, xi.item.MARS_ORB) then
                -- TODO: This handles the rejection logic if you already have the orb, but looks ugly. Needs retail capture.
                player:delCurrency('silver_aman_voucher', 6)
            end
        elseif option == 2 then -- Bought Venus Orb
            if
                silverVouchersStored >= 10 and
                npcUtil.giveItem(player, xi.item.VENUS_ORB)
            then
                -- TODO: This handles the rejection logic if you already have the orb, but looks ugly. Needs retail capture.
                player:delCurrency('silver_aman_voucher', 10)
            end
        elseif option == 3 then -- Bought single voucher
            if silverVouchersAvailable > 0 and playerGil >= voucherCost then
                player:addCurrency('silver_aman_voucher', 1)
                player:setCharVar('[AMAN]SilverVouchersBought', silverVouchersBought + 1)
                player:delGil(voucherCost)
            end
        elseif option == 4 then -- Bought maximum vouchers
            if silverVouchersAvailable > 0 and playerGil >= vouchersTotalCost then
                player:addCurrency('silver_aman_voucher', silverVouchersAvailable)
                player:setCharVar('[AMAN]SilverVouchersBought', silverVouchersBought + silverVouchersAvailable)
                player:delGil(vouchersTotalCost)
            end
        end
    end
end
