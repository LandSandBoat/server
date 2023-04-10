-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ghatsad
-- Involved in quest: No Strings Attached
-- !pos 34.325 -7.804 57.511 50
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------
local entity = {}

-- Since every outcome includes a head, track number unlocked based on this.
-- This is used to calculate the cost of additional items, and provide certain
-- event parameters (numUnlockedHeads).
local automatonHeads =
{
    xi.items.VALOREDGE_HEAD,
    xi.items.SHARPSHOT_HEAD,
    xi.items.STORMWAKER_HEAD,
    xi.items.SOULSOOTHER_HEAD,
    xi.items.SPIRITREAVER_HEAD,
}

local unlockCost =
{
    [0] = { xi.items.IMPERIAL_SILVER_PIECE,  3 },
    [1] = { xi.items.IMPERIAL_MYTHRIL_PIECE, 3 },
    [2] = { xi.items.IMPERIAL_GOLD_PIECE,    1 },
    [3] = { xi.items.IMPERIAL_MYTHRIL_PIECE, 2 },
    [4] = { xi.items.IMPERIAL_MYTHRIL_PIECE, 4 },
}

-- This table is keyed by the initial attachmentStatus for each Head/Frame
-- combination that can be purchased (Valoredge, Sharpshot, Stormwaker)
local headAndFrameItems =
{
    [2] =
    {
        xi.items.BRASS_SHEET,
        xi.items.WAMOURA_COCOON,
        xi.items.CHUNK_OF_IMPERIAL_CERMET,
        xi.items.PATAS
    },

    [3] =
    {
        xi.items.ROSEWOOD_LUMBER,
        xi.items.SQUARE_OF_KARAKUL_CLOTH,
        xi.items.SQUARE_OF_KARAKUL_LEATHER,
        xi.items.HEAVY_CROSSBOW
    },

    [4] =
    {
        xi.items.GOLD_THREAD,
        xi.items.SQUARE_OF_VELVET_CLOTH,
        xi.items.SQUARE_OF_WAMOURA_CLOTH,
        xi.items.BRASS_RING
    },
}

-- Depending on item traded, a random range is provided for number of
-- Vana'diel days to wait until completed.
local turbanItems =
{
    [xi.items.WHITE_PUPPET_TURBAN] =
    {
        [xi.items.SCROLL_OF_CURE_V ] = { 2, 4 },
        [xi.items.SCROLL_OF_REGEN  ] = { 3, 4 },
        [xi.items.SCROLL_OF_CURE_II] = { 5, 5 },
    },

    [xi.items.BLACK_PUPPET_TURBAN] =
    {
        [xi.items.SCROLL_OF_STONE_IV  ] = { 2, 4 },
        [xi.items.SCROLL_OF_ABSORB_INT] = { 3, 4 },
        [xi.items.SCROLL_OF_FIRE      ] = { 5, 5 },
    },
}

local function getWaitRange(turbanType, trade)
    for k, v in pairs(turbanItems[turbanType]) do
        if trade:getItemQty(k) == 1 then
            return v
        end
    end

    return nil
end

local function getNumUnlockedHeads(player)
    local headCount = 0

    for _, v in ipairs(automatonHeads) do
        if player:hasAttachment(v) then
            headCount = headCount + 1
        end
    end

    return headCount
end

local function getHeadMask(player)
    local headMask = 0

    for k, v in ipairs(automatonHeads) do
        if player:hasAttachment(v) then
            headMask = headMask + bit.lshift(1, k)
        end
    end

    return headMask
end

local function hasRequiredMats(trade, headFrameKey)
    for _, v in ipairs(headAndFrameItems[headFrameKey]) do
        if trade:getItemQty(v) ~= 1 then
            return false
        end
    end

    return true
end

local function satisfy_attachment(player, newAttachmentStatus)
    player:tradeComplete()
    player:setCharVar("PUP_AttachmentStatus", newAttachmentStatus)
    player:setCharVar("PUP_AttachmentReady", VanadielUniqueDay() + 1)
    player:startEvent(625)
end

local function play_event902(player, newAttachmentStatus, waitDays)
    -- Add safety if an invalid item was traded
    if waitDays == nil then
        return
    end

    player:tradeComplete()
    player:setCharVar("PUP_AttachmentStatus", newAttachmentStatus)
    player:setCharVar("PUP_AttachmentReady", VanadielUniqueDay() + waitDays)
    player:setCharVar("PUP_nextCoffeeTrade", VanadielUniqueDay() + 1)
    player:startEvent(902)
end

entity.onTrade = function(player, npc, trade)
    local attachmentStatus = player:getCharVar("PUP_AttachmentStatus")
    local numUnlockedHeads = getNumUnlockedHeads(player)
    local attachmentReadyDay = player:getCharVar("PUP_AttachmentReady")
    local attachmentReady = attachmentReadyDay ~= 0 and attachmentReadyDay <= VanadielUniqueDay()
    local tradeHasPayment = trade:getItemQty(unlockCost[numUnlockedHeads][1]) == unlockCost[numUnlockedHeads][2]

    -- Initial Trade: Has Materials + Payment, or just Materials
    if attachmentStatus >= 2 and attachmentStatus <= 4 then
        if hasRequiredMats(trade, attachmentStatus) then
            local slotCount = trade:getSlotCount()

            if slotCount == 4 then
                player:tradeComplete()
                player:setCharVar("PUP_AttachmentStatus", attachmentStatus + 3)
                player:startEvent(624, 0, 0, 0, 0, 0, unlockCost[numUnlockedHeads][1], unlockCost[numUnlockedHeads][2])
            elseif slotCount == 5 and tradeHasPayment then
                satisfy_attachment(player, attachmentStatus + 6)
            end
        end

    -- Traded Materials previously, and is now trading Payment
    elseif
        attachmentStatus >= 5 and
        attachmentStatus <= 7 and
        tradeHasPayment and
        trade:getSlotCount() == 1
    then
        satisfy_attachment(player, attachmentStatus + 3)

    -- Soulsoother or Spiritreaver Trade, requires all items up front
    elseif
        (numUnlockedHeads == 3 and attachmentStatus == 11) or
        (numUnlockedHeads == 4 and attachmentStatus == 14)
    then
        if trade:getSlotCount() == 3 then
            if tradeHasPayment then
                if
                    trade:getItemQty(xi.items.WHITE_PUPPET_TURBAN) == 1 and
                    not player:hasAttachment(xi.items.SOULSOOTHER_HEAD)
                then
                    local range = getWaitRange(xi.items.WHITE_PUPPET_TURBAN, trade)

                    play_event902(player, 12, math.random(range[1], range[2]))
                elseif
                    trade:getItemQty(xi.items.BLACK_PUPPET_TURBAN) == 1 and
                    not player:hasAttachment(xi.items.SPIRITREAVER_HEAD)
                then
                    local range = getWaitRange(xi.items.BLACK_PUPPET_TURBAN, trade)

                    play_event902(player, 13, math.random(range[1], range[2]))
                end
            end
        end

    -- Imperial Coffee Trade to reduce time remaining
    elseif
        (attachmentStatus == 12 or attachmentStatus == 13) and
        not attachmentReady and
        player:getCharVar("PUP_nextCoffeeTrade") <= VanadielUniqueDay()
    then
        if npcUtil.tradeHasExactly(trade, xi.items.CUP_OF_IMPERIAL_COFFEE) then
            player:confirmTrade()
            player:setCharVar("PUP_AttachmentReady", player:getCharVar("PUP_AttachmentReady") - 1)
            player:setCharVar("PUP_nextCoffeeTrade", VanadielUniqueDay() + 1)
            player:startEvent(904)
        end
    end
end

entity.onTrigger = function(player, npc)
    --cs 620 - new frame - param 6: itemid payment param 7: number of payment param 8: bitpack choices (bit 0 no thanks, bit 1 VE, bit 2 SS, bit 3 SW)
    --cs 621 - new frame (if canceled previous)
    --cs 622 - bring me mats
    --cs 624 - all mats, just need payment
    --cs 625 - thanks, have everything, come back later
    --cs 626 - come back later
    --cs 627 - automaton frame done (param 2: frame)
    --cs 628 - you can customise automaton by changing frame
    --cs 629 - you can alter automatons abilities and character by equipping attachments (what are these last 2 for?)
    --cs 900 - start soulsoother/spiritreaver
    --cs 901 - start second head
    --cs 902 - start work on chosen head
    --cs 903 - head almost done
    --cs 904 - give coffee
    --cs 905 - head complete

    local automatonName = player:getAutomatonName()
    local numUnlockedHeads = getNumUnlockedHeads(player)
    local attachmentStatus = player:getCharVar("PUP_AttachmentStatus")
    local unlockedAttachments = getHeadMask(player)
    local attachmentReadyDay = player:getCharVar("PUP_AttachmentReady")
    local attachmentReady = attachmentReadyDay ~= 0 and attachmentReadyDay <= VanadielUniqueDay()
    local attachmentDaysRemaining = attachmentReadyDay - VanadielUniqueDay()

    --[[
        attachment status:
        0 - none
        1 - declined a new frame
        2 - accepted valoredge
        3 - accepted sharphot
        4 - accepted stormwaker
        5 - paid mats for valoredge
        6 - paid mats for sharpshot
        7 - paid mats for stormwaker
        8 - paid mats + coins for valoredge
        9 - paid mats + coins for sharpshot
        10 - paid mats + coins for stormwaker
        11 - asked about soulsoother/spiritreaver
        12 - paid for soulsoother
        13 - paid for spiritreaver
        14 - asked about soulsoother/spiritreaver (after obtaining the first)
    ]]

    if
        player:hasCompletedQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED) and
        player:getMainJob() == xi.job.PUP
    then
        local requiredLevel = (numUnlockedHeads + 1) * 10

        -- Has not Accepted or Declined a new Head (or Head/Frame combination)
        if attachmentStatus == 0 and player:getMainLvl() >= requiredLevel then
            if numUnlockedHeads < 3 then
                player:startEventString(620, automatonName, automatonName, automatonName, automatonName, numUnlockedHeads, 0, 0, 0, 0, unlockCost[numUnlockedHeads][1], unlockCost[numUnlockedHeads][2], unlockedAttachments)
            elseif numUnlockedHeads == 3 then
                player:startEventString(900, automatonName, automatonName, automatonName, automatonName, 0, 0, 0, 0, 0, unlockCost[numUnlockedHeads][1], unlockCost[numUnlockedHeads][2])
            elseif numUnlockedHeads == 4 then
                if unlockedAttachments == 30 then
                    player:startEventString(901, automatonName, automatonName, automatonName, automatonName, 1, 0, 0, 0, 0, unlockCost[numUnlockedHeads][1], unlockCost[numUnlockedHeads][2])
                elseif unlockedAttachments == 46 then
                    player:startEventString(901, automatonName, automatonName, automatonName, automatonName, 0, 0, 0, 0, 0, unlockCost[numUnlockedHeads][1], unlockCost[numUnlockedHeads][2])
                end
            end

        -- Declined a new Head or Head/Frame combination
        elseif attachmentStatus == 1 then
            player:startEvent(621, 0, 0, 0, 0, 0, unlockCost[numUnlockedHeads][1], unlockCost[numUnlockedHeads][2], unlockedAttachments)

        -- Paid in Full (Mats & Currency) for Head/Frame Combination
        elseif attachmentStatus >= 8 and attachmentStatus <= 10 then
            if not attachmentReady then
                player:startEvent(626)
            else
                local param6 = attachmentStatus - 7

                player:startEventString(627, automatonName, automatonName, automatonName, automatonName, 0, param6)
            end

        -- Accepted a Head/Frame Combination, but has not provided any payment
        elseif attachmentStatus >= 2 and attachmentStatus <= 4 then
            player:startEvent(622, 0, 1, 0, 0, 0, unlockCost[numUnlockedHeads][1], unlockCost[numUnlockedHeads][2])

        -- Paid Mats for Head/Frame Combination, but needs to provide Currency
        elseif attachmentStatus >= 5 and attachmentStatus <= 7 then
            player:startEvent(624, 0, 0, 0, 0, 0, unlockCost[numUnlockedHeads][1], unlockCost[numUnlockedHeads][2])

        -- Asked about Soulsoother/Spiritreaver Head
        elseif attachmentStatus == 11 and numUnlockedHeads == 3 then
            player:startEventString(900, automatonName, automatonName, automatonName, automatonName, 0, 0, 1, 0, 0, unlockCost[numUnlockedHeads][1], unlockCost[numUnlockedHeads][2])

        -- Paid for Soulsoother/Spiritreaver Head
        elseif attachmentStatus == 12 or attachmentStatus == 13 then
            if not attachmentReady then
                player:startEvent(903, attachmentDaysRemaining, 1)
            else
                if attachmentDaysRemaining > 0 then
                    player:startEvent(903, attachmentDaysRemaining, 0)
                else
                    player:startEvent(905, attachmentStatus - 12)
                end
            end

        -- Ask about other head, after obtaining one already (Spiritreaver or Soulsoother)
        elseif attachmentStatus == 14 then
            if unlockedAttachments == 30 then
                player:startEventString(901, automatonName, automatonName, automatonName, automatonName, 1, 0, 1, 0, 0, unlockCost[numUnlockedHeads][1], unlockCost[numUnlockedHeads][2])
            elseif unlockedAttachments == 46 then
                player:startEventString(901, automatonName, automatonName, automatonName, automatonName, 0, 0, 1, 0, 0, unlockCost[numUnlockedHeads][1], unlockCost[numUnlockedHeads][2])
            end

            -- Default PUP actions after first Unlock
            elseif numUnlockedHeads > 0 then
                local rand = math.random(1, 2)
                if rand == 1 then
                    player:startEvent(628)
                else
                    player:startEventString(629, automatonName, automatonName, automatonName, automatonName)
                end
        end
    -- Default Action
    else
        player:startEvent(256)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 620 or csid == 621 then
        player:setCharVar("PUP_AttachmentStatus", option + 1)
    elseif csid == 627 then
        local attachmentStatus = player:getCharVar("PUP_AttachmentStatus")

        if attachmentStatus == 8 then
            player:unlockAttachment(xi.items.VALOREDGE_FRAME)
            player:unlockAttachment(xi.items.VALOREDGE_HEAD)
            player:messageSpecial(ID.text.AUTOMATON_VALOREDGE_UNLOCK)
        elseif attachmentStatus == 9 then
            player:unlockAttachment(xi.items.SHARPSHOT_FRAME)
            player:unlockAttachment(xi.items.SHARPSHOT_HEAD)
            player:messageSpecial(ID.text.AUTOMATON_SHARPSHOT_UNLOCK)
        elseif attachmentStatus == 10 then
            player:unlockAttachment(xi.items.STORMWAKER_FRAME)
            player:unlockAttachment(xi.items.STORMWAKER_HEAD)
            player:messageSpecial(ID.text.AUTOMATON_STORMWAKER_UNLOCK)
        end

        player:setCharVar("PUP_AttachmentStatus", 0)
        player:setCharVar("PUP_AttachmentReady", 0)
    elseif csid == 900 then
        player:setCharVar("PUP_AttachmentStatus", 11)
    elseif csid == 901 then
        player:setCharVar("PUP_AttachmentStatus", 14)
    elseif csid == 905 then
        local attachmentStatus = player:getCharVar("PUP_AttachmentStatus")

        if attachmentStatus == 12 then
            player:unlockAttachment(xi.items.SOULSOOTHER_HEAD)
            player:messageSpecial(ID.text.AUTOMATON_SOULSOOTHER_UNLOCK)
        elseif attachmentStatus == 13 then
            player:unlockAttachment(xi.items.SPIRITREAVER_HEAD)
            player:messageSpecial(ID.text.AUTOMATON_SPIRITREAVER_UNLOCK)
        end

        player:setCharVar("PUP_AttachmentStatus", 0)
        player:setCharVar("PUP_AttachmentReady", 0)
        player:setCharVar("PUP_nextCoffeeTrade", 0)
    end
end

return entity
