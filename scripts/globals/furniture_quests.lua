------------------------------------
-- Furniture Quest related functions
------------------------------------
require('scripts/globals/utils')
require("scripts/globals/npc_util")
--------------------------------------------------------

xi = xi or {}
xi.furnitureQuests = xi.furnitureQuests or {}

--------------------------------------------------------------------------
-- A table for furniture quests which are not actually full fledged quests
--
-- itemID = { - ItemID of the furnishing
--    itemName        - name of the item, used for local and char variables
--    reward          - reward from the quest, cupboard and simple bed are special cased in code as one offs
--                        - galley kitchen and aurum coffer would also need special casing as the rewards are multiple
--    rewardCS        - cutscene event ID
--    rewardCsOption  - cutscene event option
--                        - there are 15 options, with 1 reused routine client side (simple and oak bed)
--    waitTime        - wait time in seconds
--                        - retail wait times were cut down to 4 mins (per siknoz captures)
--                        - to be flexible for era and repeatable items, a waitTime of -1 will represent next conquest tally
--    fameReq         - fame required to get reward
--    repeatable      - if the quest is repeatable, all repeats are once per conquest except starlight
--                        - starlight is handled in moghouse.lua right now
--                        - to merge with starlight, a repeatTime could be added
--    }
--------------------------------------------------------------------------
xi.furnitureQuests.furnitureQuestInfo =
{
    -- verified via capture for at least rewardCS, rewardCsOption, waitTime
    [xi.items.SIMPLE_BED]               = { itemName = "simple_bed", reward = xi.items.CHUNK_OF_IRON_ORE, rewardCS = 30003, rewardCsOption = 2, waitTime = 240, fameReq = 3, repeatable = false },
    [xi.items.OAK_BED]                  = { itemName = "oak_bed", reward = xi.items.ETHER, rewardCS = 30003, rewardCsOption = 1, waitTime = 240, fameReq = 1, repeatable = false }, -- unknown fame
    [xi.items.TARUTARU_DESK]            = { itemName = "tarutaru_desk", reward = xi.items.HI_POTION, rewardCS = 30003, rewardCsOption = 3, waitTime = 240, fameReq = 1, repeatable = false }, -- unknown fame
    [xi.items.BUREAU]                   = { itemName = "bureau", reward = xi.items.SCROLL_OF_PROTECTRA_IV, rewardCS = 30003, rewardCsOption = 4, waitTime = 240, fameReq = 7, repeatable = false }, -- unknown fame, matching armoire
    [xi.items.WICKER_BOX]               = { itemName = "wicker_box", reward = xi.items.HORN_QUIVER, rewardCS = 30003, rewardCsOption = 9, waitTime = 240, fameReq = 4, repeatable = false },
    [xi.items.CUPBOARD]                 = { itemName = "cupboard", reward = xi.ki.SMALL_TEACUP, rewardCS = 30003, rewardCsOption = 15, waitTime = 240, fameReq = 5, repeatable = false }, -- reward is a KI
    [xi.items.ARMOIRE]                  = { itemName = "armoire", reward = xi.items.SCROLL_OF_PROTECT_IV, rewardCS = 30003, rewardCsOption = 5, waitTime = 240, fameReq = 7, repeatable = false },
    [xi.items.WATER_CASK]               = { itemName = "water_cask", reward = xi.items.FLASK_OF_DISTILLED_WATER, rewardCS = 30003, rewardCsOption = 6, waitTime = 240, fameReq = 1, repeatable = false }, -- unknown fame
    [xi.items.WHITE_JAR]                = { itemName = "white_jar", reward = xi.items.FLASK_OF_PARALYZE_POTION, rewardCS = 30003, rewardCsOption = 8, waitTime = 240, fameReq = 4, repeatable = false },
    [xi.items.STATIONERY_SET]           = { itemName = "stationery_set", reward = xi.items.SCROLL_OF_SCOPS_OPERETTA, rewardCS = 30003, rewardCsOption = 10, waitTime = 240, fameReq = 2, repeatable = false },
    -- not verified through capture yet but obvious what CS option matches based on text
    [xi.items.BEVERAGE_BARREL]          = { itemName = "beverage_barrel", reward = xi.items.BOTTLE_OF_GRAPE_JUICE, rewardCS = 30003, rewardCsOption = 11, waitTime = -1, fameReq = 1, repeatable = true }, -- rumors that reward is based on nation not being in 3rd
    [xi.items.COPY_OF_LINES_AND_SPACE]  = { itemName = "copy_of_lines_and_space", reward = xi.items.ONYX, rewardCS = 30003, rewardCsOption = 7, waitTime = 240, fameReq = 2, repeatable = false },
    -- Unknowns
    --[xi.items.FLOWER_STAND] = { itemName = "flower_stand", reward = 4545, rewardCS = 30003, rewardCsOption = ???, waitTime = -1, fameReq = 1, repeatable = true }, -- is this real? needs capture
    --[xi.items.GALLEY_KITCHEN] = { itemName = "galley_kitchen", reward = fcn, rewardCS = 30003, rewardCsOption = 12, waitTime = -1, fameReq = 1, repeatable = true }, -- needs a function to pull reward from a set
    --[xi.items.AURUM_COFFER] = { itemName = "aurum_coffer", reward = fnc, rewardCS = ???, rewardCsOption = ???, waitTime = -1, fameReq = 1, repeatable = true }, -- needs a fnc for rewards, no idea on CS
}

-----------------------------------------------------------------
-- Handles furniture placement event by setting player variables
-----------------------------------------------------------------
xi.furnitureQuests.onFurniturePlaced = function(player, item)
    local itemLookup = xi.furnitureQuests.furnitureQuestInfo[item:getID()]
    if itemLookup == nil then
        -- quit if we are being given an unknown item
        return
    end

    -- Dont allow more than one reward from an item per player if not repeatable
    if
        itemLookup.repeatable and
        player:getCharVar(string.format("[%s]%s", itemLookup.itemName, "received")) ~= 0
    then
        return
    end

    -- All furniture quests captured so far require zoning
    player:setLocalVar(string.format("[%s]%s", itemLookup.itemName, "mustZone"), 1)
    -- waitTime of -1 = conquestTally, otherwise its in seconds
    if itemLookup.waitTime > 0 then
        player:setCharVar(string.format("[%s]%s", itemLookup.itemName, "rewardTime"), os.time() + itemLookup.waitTime)
    else
        player:setCharVar(string.format("[%s]%s", itemLookup.itemName, "rewardTime"), getConquestTally())
    end
end

-----------------------------------------------------------------
-- Handles furniture removal event by removing player variables
-----------------------------------------------------------------
xi.furnitureQuests.onFurnitureRemoved = function(player, item)
    local itemLookup = xi.furnitureQuests.furnitureQuestInfo[item:getID()]
    if itemLookup == nil then
        -- quit if we are being given an unknown item
        return
    end

    player:setLocalVar(string.format("[%s]%s", itemLookup.itemName, "mustZone"), 0)
    player:setCharVar(string.format("[%s]%s", itemLookup.itemName, "rewardTime"), 0)
end

--------------------------------------------------------------------------
-- Checks for valid furniture quests and returns true if a CS is triggered
--------------------------------------------------------------------------
xi.furnitureQuests.checkForFurnitureQuest = function(player)
    local triggeredQuestItem = 0
    for itemID, fqInfo in pairs(xi.furnitureQuests.furnitureQuestInfo) do
        local rewardTime = player:getCharVar(string.format("[%s]%s", fqInfo.itemName, "rewardTime"))
        if
            rewardTime > 0 and -- player waiting to get reward
            player:getLocalVar(string.format("[%s]%s", fqInfo.itemName, "mustZone")) == 0 and -- player already zoned
            rewardTime < os.time() and -- reward is due
            player:getFameLevel(player:getNation()) >= fqInfo.fameReq -- meets fame required
        then
            triggeredQuestItem = itemID
            break
        end
    end

    -- note: BG wiki says that you can only get one reward per conquest and the ordering is unknown as to what items take priority
    -- During captures in 2023 there was no limit, however the wait time was only 4 mins.  BG Wiki may be referencing era behavior
    -- If we wish to adhere to the mentioned behavior on bg wiki - once the first valid quest is found we should push all remaining active quests to the next rewardTime.
    -- Ordering will be random unless the table is sorted and given priority.
    local itemLookup = xi.furnitureQuests.furnitureQuestInfo[triggeredQuestItem]
    if itemLookup ~= nil then
        player:startEvent(itemLookup.rewardCS, 0, 0, itemLookup.rewardCsOption, triggeredQuestItem, itemLookup.reward)
        return true
    end

    return false
end

------------------------------------------------------------------------------
-- Handles event finish - interestingly you cannot cancel these CS via Esc
------------------------------------------------------------------------------
xi.furnitureQuests.furnitureQuestsEventFinish = function(player, csid, option)
    -- look up the item by option
    local triggeredQuestItem = 0
    for itemID, fqInfo in pairs(xi.furnitureQuests.furnitureQuestInfo) do
        if fqInfo.rewardCsOption == option then
            triggeredQuestItem = itemID
            break
        end
    end

    -- get the item
    local itemLookup = xi.furnitureQuests.furnitureQuestInfo[triggeredQuestItem]
    if itemLookup ~= nil then
        if triggeredQuestItem == xi.items.CUPBOARD then -- KeyItem Reward
            npcUtil.giveKeyItem(player, itemLookup.reward)
            player:setCharVar(string.format("[%s]%s", itemLookup.itemName, "rewardTime"), 0)
            player:setCharVar(string.format("[%s]%s", itemLookup.itemName, "received"), 1)
        else -- Item Reward
            local quantity = 1
            if triggeredQuestItem == xi.items.SIMPLE_BED then -- this is the only one which gives multiples
                quantity = 4
            end

            if npcUtil.giveItem(player, { { itemLookup.reward, quantity } }) then
                if not itemLookup.repeatable then
                    player:setCharVar(string.format("[%s]%s", itemLookup.itemName, "received"), 1)
                    player:setCharVar(string.format("[%s]%s", itemLookup.itemName, "rewardTime"), 0)
                else
                    player:setCharVar(string.format("[%s]%s", itemLookup.itemName, "rewardTime"), getConquestTally())
                    player:setLocalVar(string.format("[%s]%s", itemLookup.itemName, "mustZone"), 1)
                end
            end
        end
    end
end
