-----------------------------------
-- Brigand's Chart Quest (hidden)
-----------------------------------
-- !additem 1873 -- Brigand's Chart
-- qm1 : !pos -87.5 20 -330.9 118
-----------------------------------
local ID = zones[xi.zone.BUBURIMU_PENINSULA]
-----------------------------------

xi = xi or {}
xi.brigandsChart = xi.brigandsChart or {}

local function removeChest(npc)
    npc:setAnimationSub(0, false)
    npc:setStatus(xi.status.DISAPPEAR)
    npc:resetLocalVars()
end

local function clearChests()
    for _, chestId in pairs(ID.npc.JADE_ETUI_TABLE) do
        local chest = GetNPCByID(chestId)
        if chest then
            removeChest(chest)
        end
    end
end

local function resetEvent()
    local qm1        = GetNPCByID(ID.npc.BRIGAND_CHART_QM)
    local npcHume    = GetNPCByID(ID.npc.BRIGAND_CHART_HUME)
    local shimmering = GetNPCByID(ID.npc.SHIMMERING_POINT)

    if qm1 then
        local player = GetPlayerByID(qm1:getLocalVar('bChartSpawnerID'))
        if player and player:getLocalVar('bChartActive') == 1 then
            player:setLocalVar('bChartActive', 0)
            player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            player:changeMusic(0, 0)
            player:changeMusic(1, 0)
            player:changeMusic(2, 101)
            player:changeMusic(3, 102)
        end

        qm1:resetLocalVars()
        qm1:setStatus(xi.status.NORMAL)
    end

    if npcHume then
        npcHume:setStatus(xi.status.DISAPPEAR)
        npcHume:setAnimation(xi.animation.NONE)
    end

    if shimmering then
        shimmering:setStatus(xi.status.DISAPPEAR)
        shimmering:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
    end

    -- Disappear Jade Etuis
    clearChests()
end

local eventTable =
{
    -- Event times taken from capture: https://www.youtube.com/watch?v=aQXSByinBn4
    [1] = { time = 60,  text = ID.text.WHAT_CAN_I_DO + 0 },
    [2] = { time = 90,  text = ID.text.WHAT_CAN_I_DO + 1 },
    [3] = { time = 120, text = ID.text.WHAT_CAN_I_DO + 2 },
    [4] = { time = 150, text = ID.text.WHAT_CAN_I_DO + 3 },
    [5] = { time = 170, text = ID.text.WHAT_CAN_I_DO + 4 },
    [6] = { time = 180, text = ID.text.WHAT_CAN_I_DO + 5 },
}

local function emoteChecking(npc, timeRemaining, timeOfLastCheck, phase)
    -- Event continues if player leaves zone
    -- https://www.youtube.com/watch?v=_opqVW-HIu0
    -- https://discord.com/channels/443544205206355968/446401624102010901/650072608922009660

    local currentTime      = GetSystemTime()
    local newTimeRemaining = timeRemaining - (currentTime - timeOfLastCheck)
    local totalTimeElapsed = 180 - newTimeRemaining

    -- Check time. Show text and move phase if enough time has passed.
    if totalTimeElapsed > eventTable[phase].time then
        local spawner = GetPlayerByID(npc:getLocalVar('bChartSpawnerID'))
        if spawner then
            spawner:showText(npc, eventTable[phase].text)
        end

        phase = phase + 1
    end

    if newTimeRemaining > 0 then
        npc:timer(1000, function(npcArg)
            emoteChecking(npcArg, newTimeRemaining, currentTime, phase)
        end)
    else
        resetEvent()
    end
end

xi.brigandsChart.onTrade = function(player, npc, trade)
    if
        npc:getStatus() == xi.status.NORMAL and
        npc:getLocalVar('bChartSpawnerID') == 0 and
        npcUtil.tradeHasExactly(trade, xi.item.BRIGANDS_CHART)
    then
        player:messageSpecial(ID.text.RETURN_TO_SEA, xi.item.BRIGANDS_CHART)
        player:startEvent(902)
    end
end

xi.brigandsChart.onEventUpdate = function(player, csid, option, npc)
    if csid == 902 and option == 0 then
        player:confirmTrade()

        clearChests()
        npc:setLocalVar('bChartSpawnerID', player:getID())

        player:setLocalVar('bChartActive', 1)
        player:changeMusic(0, 136)
        player:changeMusic(1, 136)
        player:changeMusic(2, 136)
        player:changeMusic(3, 136)
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, { power = 20, origin = player }) -- level restriction removed by event end
    end
end

xi.brigandsChart.onEventFinish = function(player, csid, option, npc)
    if csid == 902 and option == 0 then
        local npcHume = GetNPCByID(ID.npc.BRIGAND_CHART_HUME)
        if not npcHume then
            return
        end

        local shimmering = GetNPCByID(ID.npc.SHIMMERING_POINT)
        if not shimmering then
            return
        end

        -- Setup starting conditions
        npcHume:setStatus(xi.status.NORMAL)
        npcHume:setAnimation(xi.animation.NONE)
        npc:setStatus(xi.status.DISAPPEAR)
        shimmering:setStatus(xi.status.NORMAL)

        -- Appearing packet needs time to finish before another packet can be sent successfully
        shimmering:timer(2000, function(shimmerArg)
            shimmerArg:entityAnimationPacket(xi.animationString.SHIMMER)
        end)

        player:showText(npc, ID.text.MY_ITEM, xi.item.PENGUIN_RING)

        -- Events will occur for the next 180 seconds according to eventTable
        emoteChecking(npc, 180, GetSystemTime(), 1)
    end
end

xi.brigandsChart.rewards =
{
    common =
    {
        {
            { itemId = xi.item.BEASTCOIN,               weight = xi.loot.weight.NORMAL   },
            { itemId = xi.item.BLUE_PITCHER,            weight = xi.loot.weight.NORMAL   },
            { itemId = xi.item.COPY_OF_LINES_AND_SPACE, weight = xi.loot.weight.VERY_LOW },
            { itemId = xi.item.DWARF_PUGIL,             weight = xi.loot.weight.NORMAL   },
            { itemId = xi.item.GOLD_BEASTCOIN,          weight = xi.loot.weight.LOW      },
            { itemId = xi.item.MYTHRIL_BEASTCOIN,       weight = xi.loot.weight.LOW      },
            { itemId = xi.item.MYTHRIL_SWORD,           weight = xi.loot.weight.LOW      },
            { itemId = xi.item.ORDELLE_BRONZEPIECE,     weight = xi.loot.weight.LOW      },
            { itemId = xi.item.ONE_BYNE_BILL,           weight = xi.loot.weight.VERY_LOW },
            { itemId = xi.item.PLATINUM_BEASTCOIN,      weight = xi.loot.weight.VERY_LOW },
            { itemId = xi.item.RUSTY_CAP,               weight = xi.loot.weight.LOW      },
            { itemId = xi.item.RUSTY_LEGGINGS,          weight = xi.loot.weight.NORMAL   },
            { itemId = xi.item.SILVER_BEASTCOIN,        weight = xi.loot.weight.NORMAL   },
            { itemId = xi.item.SKY_POT,                 weight = xi.loot.weight.LOW      },
            { itemId = xi.item.WOODEN_FLOWERPOT,        weight = xi.loot.weight.VERY_LOW },
        },
    },

    special =
    {
        {
            { itemId = xi.item.NONE,         weight = xi.loot.weight.NORMAL },
            { itemId = xi.item.PENGUIN_RING, weight = xi.loot.weight.NORMAL },
        },
    },
}

xi.brigandsChart.jadeEtuiOnTrigger = function(player, npc)
    local qm1 = GetNPCByID(ID.npc.BRIGAND_CHART_QM)
    if not qm1 then
        return
    end

    local spawnerID = qm1:getLocalVar('bChartSpawnerID')
    if spawnerID == 0 then
        -- Event has been reset since this chest spawned, remove it
        removeChest(npc)
        return
    end

    if
        player:getID() ~= spawnerID or
        npc:getLocalVar(xi.animationString.OPEN_CRATE_GLOW) ~= 0
    then
        return
    end

    npc:entityAnimationPacket(xi.animationString.OPEN_CRATE_GLOW)
    npc:setLocalVar(xi.animationString.OPEN_CRATE_GLOW, 1)

    local chestNumber = player:getLocalVar('bChartChestNum')
    local rewardTable = {}
    local penguinFound = false

    -- Fourth or fifth chest, chance to give penguin ring
    if chestNumber >= 3 then
        local specialReward = utils.selectFromLootGroups(player, xi.brigandsChart.rewards.special)[1]
        if
            specialReward and
            specialReward.itemId == xi.item.PENGUIN_RING
        then
            table.insert(rewardTable, specialReward.itemId)
            table.insert(rewardTable, xi.item.YELLOW_GLOBE)
            table.insert(rewardTable, xi.item.YELLOW_GLOBE)
            table.insert(rewardTable, xi.item.YELLOW_GLOBE)
            penguinFound = true
        end
    end

    if #rewardTable == 0 then
        local commonReward = utils.selectFromLootGroups(player, xi.brigandsChart.rewards.common)[1]
        table.insert(rewardTable, commonReward.itemId)
    end

    for _, reward in pairs(rewardTable) do
        if reward ~= nil then
            player:addTreasure(reward, npc)
        end
    end

    if
        penguinFound or
        chestNumber > 4
    then
        -- Event automatically ends once the ring has been found
        resetEvent()
    else
        player:setLocalVar('bChartChestNum', chestNumber + 1)

        npc:timer(15000, function(npcArg)
            npcArg:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
        end)

        npc:timer(16000, function(npcArg)
            removeChest(npcArg)
        end)
    end
end
