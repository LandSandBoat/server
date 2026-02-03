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

local function removeFromEvent(player)
    if not player then
        return
    end

    player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
    player:changeMusic(0, 0)
    player:changeMusic(1, 0)
    player:changeMusic(2, 101)
    player:changeMusic(3, 102)
end

local function resetEvent()
    local qm1        = GetNPCByID(ID.npc.BRIGAND_CHART_QM)
    local npcHume    = GetNPCByID(ID.npc.BRIGAND_CHART_HUME)
    local shimmering = GetNPCByID(ID.npc.SHIMMERING_POINT)
    local jadeEtuis  = ID.npc.JADE_ETUI_TABLE

    if qm1 then
        local player = GetPlayerByID(qm1:getLocalVar('bChartSpawnerID'))
        removeFromEvent(player)

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
    if jadeEtuis then
        for _, id in ipairs(jadeEtuis) do
            local jade = GetNPCByID(id)

            if jade then
                jade:setStatus(xi.status.DISAPPEAR)
                jade:setAnimation(xi.animation.NONE)
                jade:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
                jade:resetLocalVars()
            end
        end
    end
end

local eventTable =
{
    -- Event times taken from capture: https://www.youtube.com/watch?v=aQXSByinBn4
    { time = 60,  text = ID.text.WHAT_CAN_I_DO + 0 },
    { time = 90,  text = ID.text.WHAT_CAN_I_DO + 1 },
    { time = 120, text = ID.text.WHAT_CAN_I_DO + 2 },
    { time = 150, text = ID.text.WHAT_CAN_I_DO + 3 },
    { time = 170, text = ID.text.WHAT_CAN_I_DO + 4 },
    { time = 180, text = ID.text.WHAT_CAN_I_DO + 5 },
}

local function tryHumeText(spawner, elapsedTime, timerTable, phase)
    if
        not timerTable or
        not phase or
        phase > #timerTable
    then
        return
    end

    local npcHume = GetNPCByID(ID.npc.BRIGAND_CHART_HUME)
    local qm1 = GetNPCByID(ID.npc.BRIGAND_CHART_QM)
    local event = timerTable[phase]

    if not (qm1 and npcHume and event) then
        return
    end

    if elapsedTime < event.time then
        return phase
    end

    if event.text then
        spawner:showText(qm1, event.text)
    end

    return phase + 1
end

local function emoteChecking(npc, spawner, timeRemaining, timeOfLastCheck, endTime, timerTable, phase)
    -- Event continues if player leaves zone
    -- https://www.youtube.com/watch?v=_opqVW-HIu0
    -- https://discord.com/channels/443544205206355968/446401624102010901/650072608922009660

    local timeOfCurrentCheck = GetSystemTime()
    local timeElapsedThisCheck = timeOfCurrentCheck - timeOfLastCheck
    timeRemaining = timeRemaining - timeElapsedThisCheck
    local totalTimeElapsed = 180 - timeRemaining

    phase = tryHumeText(spawner, totalTimeElapsed, timerTable, phase)

    if timeRemaining > 0 then
        npc:timer(1000, function(npcArg)
            emoteChecking(npcArg, spawner, timeRemaining, timeOfCurrentCheck, endTime, timerTable, phase)
        end)
    else
        resetEvent()
    end
end

xi.brigandsChart.onTrade = function(player, npc, trade)
    if
        npc:getStatus() == xi.status.NORMAL and
        npcUtil.tradeHasExactly(trade, xi.item.BRIGANDS_CHART) and
        false -- disabled until quest fully complete, remove to test
    then
        player:messageSpecial(ID.text.RETURN_TO_SEA, xi.item.BRIGANDS_CHART)
        player:startEvent(902)
    end
end

xi.brigandsChart.onEventUpdate = function(player, csid, option, npc)
    if csid == 902 and option == 0 then
        player:confirmTrade()

        npc:setLocalVar('bChartSpawnerID', player:getID())

        player:changeMusic(0, 136)
        player:changeMusic(1, 136)
        player:changeMusic(2, 136)
        player:changeMusic(3, 136)
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 20, 0, 0) -- level restriction removed by event end
    end
end

xi.brigandsChart.onEventFinish = function(player, csid, option, npc)
    if csid == 902 and option == 0 then
        local npcHume = GetNPCByID(ID.npc.BRIGAND_CHART_HUME)
        if not npcHume then
            printf('[error] Brigand\'s Chart Hume npc not found')
            return
        end

        local shimmering = GetNPCByID(ID.npc.SHIMMERING_POINT)
        if not shimmering then
            printf('[error] Brigand\'s Chart shimmering point npc not found')
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
        local endTime = GetSystemTime() + 180
        emoteChecking(npc, player, 180, GetSystemTime(), endTime, eventTable, 1)
        -- TODO: add fishing hook to catch chests & monster specific to event
    end
end

xi.brigandsChart.jadeEtuiOnTrigger = function(player, npc)
    -- TODO: Distribute rewards
end
