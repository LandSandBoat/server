-----------------------------------
-- Starlight Celebrations
-----------------------------------
require("scripts/globals/utils")
require("scripts/globals/npc_util")
------------------------------------

xi = xi or {}
xi.events = xi.events or {}
xi.events.starlightCelebration = xi.events.starlightCelebration or {}

function xi.events.starlightCelebration.isStarlightEnabled()
    local option = 0
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))

    if month == 12 and day >= 16 or xi.settings.main.STARLIGHT_YEAR_ROUND == 1 then -- According to wiki Startlight Festival is December 16 - December 31.
        if xi.settings.main.STARLIGHT_2021 == 1 then
            option = 1
        end
    end

    return option
end

--------------------------------
-- For the Children Sub-Quest --
--------------------------------
function xi.events.starlightCelebration.onStarlightSmilebringersTrade(player, trade, npc)
    local ID = zones[player:getZoneID()]
    local contentEnabled = xi.events.starlightCelebration.isStarlightEnabled()
    local item = trade:getItemId()
    local npcID = tostring(npc:getID())
    local npcTrades = player:getLocalVar("[Smilebringers][" .. npcID .. "]GiftsReceived")
    local head = player:getEquipID(xi.slot.HEAD)
    ------------------
    -- 2007 Edition --
    ------------------
    if contentEnabled == 1 then
        ----------------------
        -- Presents Allowed --
        ----------------------
        local giftsTable =
        {
            1742, -- Present for Kiddies
            1743, -- Present for Kiddies
            1744, -- Present for Kiddies
            1745, -- Present for Kiddies
            4215, -- Popstar
            4216, -- Brilliant Snow
            4217, -- Sparkling Hand
            4218, -- Air Rider
            4167, -- Cracker
            4168, -- Twinkle Shower
            4169, -- Little Comet
        }

        local presentsTable =
        {
            1742,
            1743,
            1744,
            1745,
        }
        ---------------
        -- Hat Check --
        ---------------
        if head == 15179 or head == 15178 then
            if npcTrades < 14 then
                for itemInList = 1, #giftsTable do
                    if
                        item == giftsTable[itemInList] and
                        item == presentsTable[itemInList] and
                        player:getFameLevel(xi.quest.fame_area.HOLIDAY) < 9
                    then
                        player:showText(npc, ID.text.GIFT_THANK_YOU)
                        player:messageSpecial(ID.text.BARRELS_JOY_TO_CHILDREN)
                        player:addFame(xi.quest.fame_area.HOLIDAY, 128)
                        player:tradeComplete()
                        player:setLocalVar("[Smilebringers][" .. npcID .. "]GiftsReceived", npcTrades + 1)
                        return true
                    elseif
                        item == giftsTable[itemInList] and
                        player:getFameLevel(xi.quest.fame_area.HOLIDAY) < 9
                    then
                        player:showText(npc, ID.text.GIFT_THANK_YOU)
                        player:messageSpecial(ID.text.JOY_TO_CHILDREN)
                        player:addFame(xi.quest.fame_area.HOLIDAY, 32)
                        player:tradeComplete()
                        player:setLocalVar("[Smilebringers][" .. npcID .. "]GiftsReceived", npcTrades + 1)
                        return true
                    elseif
                        item == giftsTable[itemInList] and
                        player:getFameLevel(xi.quest.fame_area.HOLIDAY) >= 9
                    then
                        player:showText(npc, ID.text.ONLY_TWO_HANDS)
                        player:setLocalVar("[Smilebringers][" .. npcID .. "]GiftsReceived", npcTrades + 1)
                        return true
                    end
                end

                return false
            else
                player:showText(npc, ID.text.ONLY_TWO_HANDS)
                return true
            end
        else
            return false
        end
    end
end

--------------------------------
-- Gifts for NPCs Sub-Quest --
--------------------------------

function xi.events.starlightCelebration.npcGiftsMoogleOnTrigger(player)
    local startedQuest = player:getLocalVar("[StarlightNPCGifts]Started")
    local hasCompleted = player:getCharVar("[StarlightNPCGifts]Completed")
    if startedQuest ~= 0 then
        local npc1 = player:getLocalVar("[StarlightNPCGifts]Npc1")
        local npc2 = player:getLocalVar("[StarlightNPCGifts]Npc2")
        local npc3 = player:getLocalVar("[StarlightNPCGifts]Npc3")
        local npc4 = player:getLocalVar("[StarlightNPCGifts]Npc4")
        local delivered = tonumber(npc4 .. npc3 .. npc2 .. npc1, 2)
        if delivered == 15 then
            player:startEvent(32702)
        else
            player:startEvent(32701, delivered)
        end
    else
        if hasCompleted == VanadielUniqueDay() then
            player:startEvent(32700)
        else
            player:startEvent(32703)
        end
    end
end

function xi.events.starlightCelebration.npcGiftsMoogleOnFinish(player, id, csid, option)
    if csid == 32703 and option == 1 then
        player:setLocalVar("[StarlightNPCGifts]Started", 1)
        player:setLocalVar("[StarlightNPCGifts]Npc1", 0)
        player:setLocalVar("[StarlightNPCGifts]Npc2", 0)
        player:setLocalVar("[StarlightNPCGifts]Npc3", 0)
        player:setLocalVar("[StarlightNPCGifts]Npc4", 0)
    elseif csid == 32702 then
        local hasToken = player:hasKeyItem(xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
        local giftTable =
        {
            5622,   -- Candy Cane
            5621,   -- Candy Ring
        }
        local fireworksTable =
        {
            4215, -- Popstar
            4216, -- Brilliant Snow
            4217, -- Sparkling Hand
            4218, -- Air Rider
            4167, -- Cracker
            4168, -- Twinkle Shower
            4169, -- Little Comet
        }
        if hasToken then
            npcUtil.giveItem(player, giftTable[math.random(1, 2)])
        else
            player:addKeyItem(xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
            player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
        end

        npcUtil.giveItem(player, { { fireworksTable[math.random(1, 7)], 10 } })
        player:setLocalVar("[StarlightNPCGifts]Started", 0)
        player:setCharVar("[StarlightNPCGifts]Completed", VanadielUniqueDay())
    end
end

local npcGiftsEvents =
{
    32693,
    32692,
    32691,
    32690,
}

function xi.events.starlightCelebration.npcGiftsNpcOnTrigger(player, eventid)
    local startedQuest = player:getLocalVar("[StarlightNPCGifts]Started")
    local npcProgress = player:getLocalVar("[StarlightNPCGifts]Npc" .. tostring(eventid))

    if startedQuest ~= 0 then
        if npcProgress ~= 1 then
            local eventTable = npcGiftsEvents
            local questUpdateStr = "[StarlightNPCGifts]Npc" .. eventid
            player:setLocalVar(questUpdateStr, 1)
            player:startEvent(eventTable[eventid])

            return true
        end
    end

    return false
end

--------------------------------
-- Token Redemption Sub-Quest --
--------------------------------

function xi.events.starlightCelebration.tokenMoogleOnTrigger(player)
    local startedTokens = player:getCharVar("[StarlightTokens]Started")
    if startedTokens ~= 0 then
        local snowToken = player:hasKeyItem(xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
        local bellToken = player:hasKeyItem(xi.keyItem.BELL_THEMED_GIFT_TOKEN)
        local starToken = player:hasKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)

        if
            snowToken and
            bellToken and
            starToken
        then
            player:startEvent(32705)
        else
            if snowToken then
                player:startEvent(32704, xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
            elseif bellToken then
                player:startEvent(32704, xi.keyItem.BELL_THEMED_GIFT_TOKEN)
            elseif starToken then
                player:startEvent(32704, xi.keyItem.STAR_THEMED_GIFT_TOKEN)
            else
                player:startEvent(32706)
            end
        end

    else
        player:startEvent(32706)
    end
end

function xi.events.starlightCelebration.tokenMoogleOnFinish(player, id, csid, option)
    if csid == 32706 then
        player:setCharVar("[StarlightTokens]Started", 1)
    elseif csid == 32704 or (csid == 32705 and option ~= 1) then -- snow, bell, star
        local invAvailable = player:getFreeSlotsCount()
        local snowToken = player:hasKeyItem(xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
        local bellToken = player:hasKeyItem(xi.keyItem.BELL_THEMED_GIFT_TOKEN)
        local starToken = player:hasKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)
        local reward = 0
        local rewardTable = {}
        local giftsTable =
            {
                SNOW_TOKEN =
                {
                    5552,   -- Black Pudding
                    18863,  -- Dream Bell
                    10382,  -- Dream Mittens
                    10383,  -- Dream Mittens +1
                    5542,   -- Gateau Aux Fraises
                    5616,   -- Lebkuchen House
                    5622,   -- Candy Cane
                    5621,   -- Candy Ring
                    177,    -- Snowman Miner
                    115,    -- Bastokan Tree
                },
                BELL_TOKEN =
                {
                    5552,   -- Black Pudding
                    5621,   -- Candy Ring
                    18863,  -- Dream Bell
                    15752,  -- Dream Boots
                    15753,  -- Dream Boots +1
                    5620,   -- Roast Turkey
                    178,    -- Snowman Mage
                    116,    -- Windurstian Tree
                },
                STAR_TOKEN =
                {
                    5550,   -- Buche au Chocolat
                    5622,   -- Candy Cane
                    5621,   -- Candy Ring
                    18863,  -- Dream Bell
                    14519,  -- Dream Robe
                    14520,  -- Dream Robe +1
                    5542,   -- Gateau Aux Fraises
                    5620,   -- Roast Turkey
                    176,    -- Snowman Knight
                    86,     -- San d'Orian Tree
                },
            }

        if invAvailable == 0 then
            player:messageSpecial(id.text.DEFAULT_CANNOT_BE_OBTAINED)
            return
        end

        if snowToken then
            player:delKeyItem(xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
            rewardTable = giftsTable.SNOW_TOKEN
        elseif bellToken then
            player:delKeyItem(xi.keyItem.BELL_THEMED_GIFT_TOKEN)
            rewardTable = giftsTable.BELL_TOKEN
        elseif starToken then
            player:delKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)
            rewardTable = giftsTable.STAR_TOKEN
        end

        local count = #rewardTable

        while count ~= 0 do
            local picked = rewardTable[math.random(1, #rewardTable)]
            if not player:hasItem(picked) then
                reward = picked
                count = 0
                npcUtil.giveItem(player, reward)
            else
                local pickedItem = GetReadOnlyItem(picked)
                local isNotRare = bit.band(pickedItem:getFlag(), xi.itemFlag.RARE) == 0
                if isNotRare then -- checks if reward is rare and thus should not attempt to give
                    reward = picked
                    count = 0
                    npcUtil.giveItem(player, reward)
                else
                    table.remove(rewardTable, picked) -- removes ra/ex items that player already has
                    count = count - 1
                end
            end
        end

    elseif csid == 32705 and option == 1 then
        local hasNQ = player:hasItem(18863)
        local hasHQ = player:hasItem(18864)
        local invAvailable = player:getFreeSlotsCount()

        if invAvailable ~= 0 then
            if hasHQ then
                npcUtil.giveItem(player, { 5620, 5621, 5622 })
            elseif hasNQ then
                npcUtil.giveItem(player, 18864)
            else
                npcUtil.giveItem(player, 18863)
            end

            player:delKeyItem(xi.keyItem.SNOW_THEMED_GIFT_TOKEN)
            player:delKeyItem(xi.keyItem.BELL_THEMED_GIFT_TOKEN)
            player:delKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)
        else
            player:messageSpecial(id.text.DEFAULT_CANNOT_BE_OBTAINED)
            return
        end
    end
end

-------------------------------------
-- Smilebringer Bootcamp Sub-Quest --
-------------------------------------

local zoneDefaultTimes =
{
    [385] = 230,
    [386] = 270,
    [387] = 240,
}

function xi.events.starlightCelebration.smileBringerSergeantOnTrigger(player, npc, zoneOption)
    local elapsedTime = (os.time() - player:getLocalVar("bootCampStarted"))
    local playerPoint = player:getLocalVar("playerBCCP")
    local completedDay = player:getCharVar("[SmileBootCamp]Completed")
    local currentDay = VanadielUniqueDay()
    local gil = player:getGil()
    local hasTree = player:hasItem(xi.items.JEUNOAN_TREE)
    local recordHolderID = npc:getLocalVar("recordHolderID")
    local recordHolderName = ""
    local recordTime = zoneDefaultTimes[zoneOption]
    local entry = 0
    local qualifyingTime = 540

    if recordHolderID ~= 0 then
        local recordID = GetPlayerByID(recordHolderID)
        if recordID ~= nil then
            recordHolderName = GetPlayerByID(recordHolderID):getName()
        else
            recordHolderName = "Smilebringer"
        end

        recordTime = npc:getLocalVar("recordTime")
    else
        recordHolderName = "Smilebringer"
    end

    if completedDay ~= currentDay then
        if gil >= 0 then
            if playerPoint ~= 0 then
                if playerPoint == 10 then
                    if elapsedTime >= 540 then
                        player:startEvent(7011, elapsedTime, 10, 0, 35, 240, 17695260, 600, 0)
                    elseif elapsedTime > recordTime and elapsedTime <= 540 then -- qualifying time
                        if hasTree then
                            player:startEvent(7005, elapsedTime, 5622, 0, 44519, -412436, 28, 1, 1)
                        else
                            player:startEvent(7005, elapsedTime, 138, 0, 44519, -412436, 28, 1, 1)
                        end
                    elseif elapsedTime < recordTime then -- new record
                        if hasTree then
                            player:startEvent(7005, elapsedTime, xi.items.CANDY_CANE, 0, 44519, -412436, 28, 1, 5)
                        else
                            player:startEvent(7005, elapsedTime, xi.items.JEUNOAN_TREE, 0, 44519, -412436, 28, 1, 5)
                        end

                        npc:setLocalVar("recordHolderID", player:getID())
                        npc:setLocalVar("recordTime", elapsedTime)
                    end
                else
                    player:startEvent(7004)
                end
            else
                player:startEventString(7001, recordHolderName, recordHolderName, recordHolderName, recordHolderName, 0, 0, 1, 0, recordTime, qualifyingTime, entry, zoneOption)
            end
        else
            player:startEventString(7001, recordHolderName, recordHolderName, recordHolderName, recordHolderName, 0, 0, 0, 0, recordTime, qualifyingTime, entry, zoneOption)
        end
    else
        player:startEventString(7001, recordHolderName, recordHolderName, recordHolderName, recordHolderName, 0, 1, 0, 0, recordTime, qualifyingTime, entry, zoneOption)
    end
end

function xi.events.starlightCelebration.smileBringerSergeantOnFinish(player, npc, id, csid, option)
    if csid == 7001 and option == 1 then
        local zoneid = player:getZoneID()
        player:showText(npc, id.text.SMILEBRINGER_START)
        player:setLocalVar("bootCampStarted", os.time())
        player:setLocalVar("playerBCCP", 1)
        xi.events.starlightCelebration.toggleSmileHelpers(zoneid)
    elseif csid == 7005 then
        local hasItem = player:hasItem(xi.items.JEUNOAN_TREE)
        local invAvailable = player:getFreeSlotsCount()

        if invAvailable ~= 0 then
            if hasItem then
                player:resetLocalVars()
                player:setCharVar("[SmileBootCamp]Completed", VanadielUniqueDay())
                npcUtil.giveItem(player, xi.items.CANDY_CANE, { silent = true })
                if not player:hasKeyItem(xi.keyItem.BELL_THEMED_GIFT_TOKEN) then
                    player:addKeyItem(xi.keyItem.BELL_THEMED_GIFT_TOKEN)
                    player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.BELL_THEMED_GIFT_TOKEN)
                end
            else
                player:resetLocalVars()
                player:setCharVar("[SmileBootCamp]Completed", VanadielUniqueDay())
                npcUtil.giveItem(player, xi.items.JEUNOAN_TREE, { silent = true })
            end
        else
            if player:hasItem(xi.items.JEUNOAN_TREE) then
                player:showText(npc, id.text.ITEM_CANNOT_BE_OBTAINED, xi.items.CANDY_CANE)
            else
                player:showText(npc, id.text.ITEM_CANNOT_BE_OBTAINED, xi.items.JEUNOAN_TREE)
            end
        end
    elseif csid == 7004 and option == 5 then
        player:resetLocalVars()

    elseif csid == 7011 then
        player:resetLocalVars()
    end
end

function xi.events.starlightCelebration.smileHelperTrigger(player, npc, id)
    local npcID = tostring(npc:getID())
    local playerTime = player:getLocalVar("bootCampStarted")
    local playerPoint = player:getLocalVar("playerBCCP")
    local npcPoint = player:getLocalVar("Checkpoint" .. npcID)
    local missedFlee = player:getLocalVar("missedFlee")
    local seconds = math.fmod(os.time() - playerTime, 60)
    local minutes = math.floor((os.time() - playerTime) / 60)

    if playerTime ~= 0 then
        if playerPoint ~= 0 then
            if npcPoint == 0 and playerPoint ~= 10 then
                player:setLocalVar("playerBCCP", playerPoint + 1)
                player:setLocalVar("Checkpoint" .. npcID, 1)
                if
                    player:getStatusEffect(xi.effect.FLEE) ~= nil or
                    playerPoint == 1 or
                    missedFlee == 1
                then
                    player:setLocalVar("missedFlee", 0)
                    player:showText(npc, id.text.SMILEHELPER_CHECKPOINT_2, 0, playerPoint, minutes, seconds)
                    player:addStatusEffect(xi.effect.FLEE, 100, 0, 30)
                else
                    local rnd = math.random(0, 5)
                    if rnd ~= 3 then
                        player:setLocalVar("missedFlee", 1)
                        player:showText(npc, id.text.SMILEHELPER_CHECKPOINT_1, 0, playerPoint, minutes, seconds)
                    else
                        player:setLocalVar("missedFlee", 0)
                        player:showText(npc, id.text.SMILEHELPER_CHECKPOINT_2, 0, playerPoint, minutes, seconds)
                        player:addStatusEffect(xi.effect.FLEE, 100, 0, 30)
                    end
                end
            elseif playerPoint == 10 and npcPoint == 0 then
                player:showText(npc, id.text.SMILEHELPER_POINTS_CLEARED)
                player:addStatusEffect(xi.effect.FLEE, 100, 0, 30)
            elseif npcPoint ~= 0 then
                player:showText(npc, id.text.SMILEHELPER_ALREADY_VISITED, 0, playerPoint, minutes, seconds)
            end
        end
    else
        player:showText(npc, id.text.SMILEHELPER_IDLE)
    end
end

----------------------------------------------------------------
-- Apply Zone Decorations, Vendors, and Additional Event NPCs --
----------------------------------------------------------------
function xi.events.starlightCelebration.applyStarlightDecorations(zoneid)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        local decoration = zones[zoneid].npc.STARLIGHT_DECORATIONS
        if decoration then
            for _, id in pairs(decoration) do
                local npc = GetNPCByID(id)
                if npc then
                    npc:setStatus(xi.status.NORMAL)
                end
            end
        end
    else
        local decoration = zones[zoneid].npc.STARLIGHT_DECORATIONS
        if decoration then
            for _, id in pairs(decoration) do
                local npc = GetNPCByID(id)
                if npc then
                    npc:setStatus(xi.status.DISAPPEAR)
                end
            end
        end
    end
end

function xi.events.starlightCelebration.toggleSmileHelpers(zoneid)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        local smileHelper = zones[zoneid].npc.SMILE_HELPERS
        if smileHelper then
            for _, id in pairs(smileHelper) do
                local npc = GetNPCByID(id)
                if npc then
                    npc:setStatus(xi.status.NORMAL)
                    npc:setLocalVar("depopTime", (os.time() + 3600))
                end
            end
        end
    end
end

function xi.events.starlightCelebration.resetSmileHelpers(zoneid)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        local smileHelper = zones[zoneid].npc.SMILE_HELPERS
        if smileHelper then
            for _, id in pairs(smileHelper) do
                local npc = GetNPCByID(id)
                if npc then
                    local depopTime = npc:getLocalVar("depopTime")
                    if depopTime < os.time() then
                        npc:setStatus(xi.status.DISAPPEAR)
                    end
                end
            end
        end
    end
end

----------------------------------
-- Goblin Merrymakers Sub-Quest --
----------------------------------

local merryMakersNPCs =
{
    Bastok_Markets =
    {
        17739830,   -- Lame Deer
        17739831,   -- Epione
        17739829,   -- Pavel
        17739833,   -- Tancredi
        17739837,   -- Red Canyon
        17739839,   -- Anguysh
    },
    Northern_SandOria =
    {
        17723550,    -- Villion
        17723468,    -- Telmoda
        17723470,    -- Rodaillece
        17723472,    -- Gilipese
        17723415,    -- Coullene
        17723520,    -- Vavegallet
    },
    Windurst_Waters =
    {
        17752170,    -- Bulolo
        17752160,    -- Pulyiki
        17752200,    -- Pia
        17752167,    -- Kobite-Mojite
        17752191,    -- Reh Hapli
        17752188     -- Kuesoso
    },
    Receive_Event_IDs =
    {
        4889,
        4887,
        4881,
        4885,
        4891,
        4883,
    },
    Send_Event_IDs =
    {
        4862,
        4859,
        4850,
        4856,
        4865,
        4853,
    }
}

function xi.events.starlightCelebration.getMerrymakerNPCIDs(zoneid)
    local npcTable = {}
    if xi.events.starlightCelebration.isStarlightEnabled ~= 0 then
        if zoneid == 231 then
            npcTable = merryMakersNPCs.Northern_SandOria
            return npcTable
        elseif zoneid == 235 then
            npcTable = merryMakersNPCs.Bastok_Markets
            return npcTable
        elseif zoneid == 238 then
            npcTable = merryMakersNPCs.Windurst_Waters
            return npcTable
        end
    end
end

function xi.events.starlightCelebration.merryMakersGoblinOnTrigger(player, npc, id)
    local questStatus = player:getCharVar("[MerryMakers]Started")
    local hasTrust = player:getCharVar("[MerryMakers]GoblinTrust")
    local hasPresent = player:getCharVar("[MerryMakers]HasPresent")

    if questStatus ~= 0 then
        if hasTrust == npc:getID() then
            local loseTrust = math.random(0, 3)

            if loseTrust ~= 0 then
                if loseTrust == 1 then
                    player:showText(npc, id.text.MERRYMAKER_FRIEND) -- Response 1
                elseif loseTrust == 2 then
                    player:showText(npc, id.text.MERRYMAKER_WAHH) -- Response 2
                elseif loseTrust == 3 then
                    if hasPresent == 0 then
                        player:startEvent(4711) -- gives present
                    else
                        player:showText(npc, id.text.MERRYMAKER_NO) -- loses trust
                    end
                end
            else
                player:setCharVar("[MerryMakers]GoblinTrust", 0)
                player:startEvent(4712)
            end
        else
            player:startEvent(4712)
        end
    else
        player:showText(npc, id.text.MERRYMAKER_DEFAULT)
    end
end

function xi.events.starlightCelebration.merryMakersGoblinOnFinish(player, csid, option, id)
    if csid == 4711 then
        local rnd = math.random(1, 3)

        if rnd == 1 then
            player:addKeyItem(xi.keyItem.RED_PRESENT)
            player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.RED_PRESENT)
        elseif rnd == 2 then
            player:addKeyItem(xi.keyItem.GREEN_PRESENT)
            player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.GREEN_PRESENT)
        else
            player:addKeyItem(xi.keyItem.BLUE_PRESENT)
            player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.BLUE_PRESENT)
        end

        player:setCharVar("[MerryMakers]GoblinTrust", 0)
        player:setCharVar("[MerryMakers]HasPresent", 1)
    end
end

function xi.events.starlightCelebration.merryMakersGoblinOnTrade(player, npc, trade, id)
    local questStatus = player:getCharVar("[MerryMakers]Started")
    if questStatus ~= 0 then
        if npcUtil.tradeHasExactly(trade, 4495) then
            player:setCharVar("[MerryMakers]GoblinTrust", npc:getID())
            player:tradeComplete()
            player:showText(npc, id.text.MERRYMAKER_TRADE)
        else
            player:showText(npc, id.text.MERRYMAKER_BLECH)
        end
    else
        player:showText(npc, id.text.MERRYMAKER_DEFAULT)
    end
end

function xi.events.starlightCelebration.merryMakersMoogleOnTrigger(player, npc)
    local questStatus = player:getCharVar("[MerryMakers]Started")
    local sender = player:getCharVar("[MerryMakers]Sender")
    local hasPresent = player:getCharVar("[MerryMakers]HasPresent")
    local cleared = player:getCharVar("[MerryMakers]Cleared")
    local confirmed = player:getCharVar("[MerryMakers]Confirmed")
    local delivered = player:getCharVar("[MerryMakers]Delivered")
    local redPresent = player:hasKeyItem(xi.keyItem.RED_PRESENT)
    local greenPresent = player:hasKeyItem(xi.keyItem.GREEN_PRESENT)
    local bluePresent = player:hasKeyItem(xi.keyItem.BLUE_PRESENT)

    if redPresent or greenPresent or bluePresent then
        player:setCharVar("[MerryMakers]HasPresent", 1)
    end

    if questStatus ~= 0 then
        if cleared ~= 0 then
            player:startEvent(4702)
        elseif delivered ~= 0 then
            local npcName = GetNPCByID(sender):getName()
            if string.find(npcName, "%_") ~= 0 then
                npcName = string.gsub(npcName, "%_", " ")
            end

            player:startEventString(4705, npcName)
        elseif confirmed ~= 0 then
            local npcName = GetNPCByID(sender):getName()
            if string.find(npcName, "%_") ~= 0 then
                npcName = string.gsub(npcName, "%_", " ")
            end

            player:startEventString(4704, npcName)
        elseif sender == 0 and hasPresent ~= 0 then

            local npcTable = xi.events.starlightCelebration.getMerrymakerNPCIDs(npc:getZoneID())

            if redPresent or greenPresent or bluePresent then
                local rnd = math.random(1, 6)
                local giftNpcID = npcTable[rnd]
                local giftNpc = GetNPCByID(giftNpcID):getName()

                if string.find(giftNpc, "%_") ~= 0 then
                    giftNpc = string.gsub(giftNpc, "%_", " ")
                end

                player:startEventString(4701, giftNpc)
                player:setCharVar("[MerryMakers]Sender", giftNpcID)
                player:setCharVar("[MerryMakers]SenderID", rnd)
            end
        else
            if sender ~= 0 then
                local giftNpc = player:getCharVar("[MerryMakers]Sender")
                local npcName = GetNPCByID(giftNpc)

                if string.find(giftNpc, "%_") ~= 0 then
                    giftNpc = string.gsub(giftNpc, "%_", " ")
                end

                player:startEventString(4704, npcName)
            else
                player:startEvent(4703, 2)
            end
        end
    else
        player:startEvent(4700)
        player:setCharVar("[MerryMakers]Started", 1)
    end
end

function xi.events.starlightCelebration.merryMakersMoogleOnFinish(player, id, csid, option)
    if csid == 4702 then
        local dreamPants = player:hasItem(11967)
        local dreamTrousers = player:hasItem(11965)
        local dreamPantsHQ = player:hasItem(11968)
        local dreamTrousersHQ = player:hasItem(11966)
        local starToken = player:hasKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)

        local gender = player:getGender()

        if gender == 0 then
            if not dreamPants then
                npcUtil.giveItem(player, 11967)
            elseif dreamPants and not dreamPantsHQ then
                npcUtil.giveItem(player, 11968)
            elseif dreamPantsHQ and starToken then
                npcUtil.giveItem(player, 5622)
            else
                player:addKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)
                player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.STAR_THEMED_GIFT_TOKEN)
            end
        else
            if not dreamTrousers then
                npcUtil.giveItem(player, 11965)
            elseif dreamTrousers and not dreamTrousersHQ then
                npcUtil.giveItem(player, 11966)
            elseif dreamTrousersHQ and starToken then
                npcUtil.giveItem(player, 5621)
            else
                player:addKeyItem(xi.keyItem.STAR_THEMED_GIFT_TOKEN)
                player:messageSpecial(id.text.KEYITEM_OBTAINED, xi.keyItem.STAR_THEMED_GIFT_TOKEN)
            end
        end

        player:setCharVar("[MerryMakers]Cleared", 0)
    end
end

function xi.events.starlightCelebration.merryMakersNPCDeliverOnTrigger(player, npc, id)
    local npcID = npc:getID()
    local sender = player:getCharVar("[MerryMakers]Sender")
    local questStatus = player:getCharVar("[MerryMakers]Started")
    local confirmed = player:getCharVar("[MerryMakers]Confirmed")
    local delivered = player:getCharVar("[MerryMakers]Delivered")

    if questStatus ~= 0 then
        if delivered ~= 0 then
            player:setCharVar("[MerryMakers]Sender", 0)
            player:setCharVar("[MerryMakers]Confirmed", 0)
            player:setCharVar("[MerryMakers]Delivered", 0)
            player:setCharVar("[MerryMakers]Cleared", 1)
            player:showText(npc, id.text.MERRYMAKER_NPC_RETURNED)
        elseif confirmed ~= 0 then
            local npcName = GetNPCByID(sender):getName()
            local eventPpos = player:getCharVar("[MerryMakers]ConfirmedID")
            local eventTable = merryMakersNPCs.Receive_Event_IDs[eventPpos]
            local redPresent = player:hasKeyItem(xi.keyItem.RED_PRESENT)
            local greenPresent = player:hasKeyItem(xi.keyItem.GREEN_PRESENT)
            local bluePresent = player:hasKeyItem(xi.keyItem.BLUE_PRESENT)
            local currentNpc = npc:getID()

            if currentNpc ~= sender then
                if string.find(npcName, "%_") ~= 0 then
                    npcName = string.gsub(npcName, "%_", " ")
                end

                player:startEventString(eventTable, npcName)
                player:setCharVar("[MerryMakers]Confirmed", 0)
                player:setCharVar("[MerryMakers]Delivered", npc:getID())

                if redPresent then
                    player:delKeyItem(xi.keyItem.RED_PRESENT)
                    player:messageSpecial(id.text.KEYITEM_LOST, xi.keyItem.RED_PRESENT)
                elseif greenPresent then
                    player:delKeyItem(xi.keyItem.GREEN_PRESENT)
                    player:messageSpecial(id.text.KEYITEM_LOST, xi.keyItem.GREEN_PRESENT)
                elseif bluePresent then
                    player:delKeyItem(xi.keyItem.BLUE_PRESENT)
                    player:messageSpecial(id.text.KEYITEM_LOST, xi.keyItem.BLUE_PRESENT)
                end

                player:setCharVar("[MerryMakers]HasPresent", 0)
            elseif currentNpc == sender then
                local eventID = player:getCharVar("[MerryMakers]SenderID")
                local targetTable = merryMakersNPCs.Send_Event_IDs
                local targetID = player:getCharVar("[MerryMakers]Confirmed")

                local targetName = GetNPCByID(targetID):getName()

                player:startEvent(targetTable[eventID], targetName)
            end
        else
            if player:getCharVar("[MerryMakers]Sender") == npcID then
                local eventID = player:getCharVar("[MerryMakers]SenderID")
                local npcTable = xi.events.starlightCelebration.getMerrymakerNPCIDs(npc:getZoneID())
                local eventTable = merryMakersNPCs.Send_Event_IDs
                local receiver = 0
                local receiveID = 0
                local count = #npcTable
                while count ~= 0 do
                    local rnd = math.random(1, #npcTable)
                    local picked = npcTable[rnd]
                    if picked ~= npcID then
                        receiver = picked
                        count = 0
                        receiveID = rnd
                    else
                        table.remove(npcTable, picked) -- removes this NPC's ID from table
                        count = count - 1
                    end
                end

                local npcName = GetNPCByID(receiver):getName()

                if string.find(npcName, "%_") ~= 0 then
                    npcName = string.gsub(npcName, "%_", " ")
                end

                player:startEvent(eventTable[eventID], npcName)
                player:setCharVar("[MerryMakers]Confirmed", receiver)
                player:setCharVar("[MerryMakers]ConfirmedID", receiveID)
            else
                return
            end
        end
    else
        return
    end
end

return xi.events.starlightCelebration
