-----------------------------------
-- Pirates Chart Quest (hidden)
-----------------------------------
-- !additem 1874 -- Pirates Chart
-- qm4 : !pos -168.6 4 -131.4 103
-----------------------------------
local valkID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------

xi = xi or {}
xi.piratesChart = xi.piratesChart or {}

local barnacleBuddyIDs =
{
    valkID.mob.BEACH_MONK,
    valkID.mob.HEIKE_CRAB,
    valkID.mob.HOUU_THE_SHOALWADER,
}

local function eventIsNotValid(npc)
    local spawnerID = npc:getLocalVar('pChartSpawnerID')
    local spawner = GetPlayerByID(spawnerID)

    if
        not spawner or
        not spawner:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) or
        spawner:getStatusEffect(xi.effect.LEVEL_RESTRICTION):getPower() ~= 20 or
        spawner:getPartySize() > 3 or
        spawner:checkSoloPartyAlliance() == 2 or
        spawner:getZoneID() ~= xi.zone.VALKURM_DUNES
    then
        return true
    end

    for i = 1, 3 do
        local memberID = npc:getLocalVar('pChartMemberID_' .. i)
        local member = GetPlayerByID(memberID)

        if
            member and
            memberID ~= spawnerID and
            (
                member:getZoneID() == xi.zone.VALKURM_DUNES and
                member:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) and
                member:getStatusEffect(xi.effect.LEVEL_RESTRICTION):getPower() ~= 20
            )
        then
            return true
        end
    end

    return false
end

local function removeFromConfrontation(player)
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
    local qm4        = GetNPCByID(valkID.npc.PIRATE_CHART_QM)
    local panicTaru  = GetNPCByID(valkID.npc.PIRATE_CHART_TARU)
    local shimmering = GetNPCByID(valkID.npc.SHIMMERING_POINT)

    if qm4 then
        for i = 1, 3 do
            local member = GetPlayerByID(qm4:getLocalVar('pChartMemberID_' .. i))
            removeFromConfrontation(member)
        end

        qm4:resetLocalVars()
        qm4:setStatus(xi.status.NORMAL)
    end

    if panicTaru then
        panicTaru:setStatus(xi.status.DISAPPEAR)
        panicTaru:setAnimation(xi.animation.NONE)
    end

    if shimmering then
        shimmering:setStatus(xi.status.DISAPPEAR)
    end
end

local eventTable =
{
    { time = 1000,  text = valkID.text.RIGHT_OVER_THERE_POINT + 0, emote = xi.emote.POINT, animationString = nil                             },
    { time = 20000, text = valkID.text.RIGHT_OVER_THERE_POINT + 1, emote = xi.emote.PANIC, animationString = nil                             },
    { time = 30000, text = valkID.text.RIGHT_OVER_THERE_POINT + 2, emote = xi.emote.PANIC, animationString = nil                             },
    { time = 40000, text = valkID.text.RIGHT_OVER_THERE_POINT + 3, emote = xi.emote.PANIC, animationString = nil                             },
    { time = 45000, text = valkID.text.RIGHT_OVER_THERE_POINT + 4, emote = nil,            animationString = nil                             },
    { time = 46000, text = valkID.text.RIGHT_OVER_THERE_POINT + 5, emote = nil,            animationString = xi.animationString.EFFECT_DEATH },
}

local function tryTaruEmote(elapsedTime_ms, timerTable)
    if not timerTable then
        return
    end

    local panicTaru = GetNPCByID(valkID.npc.PIRATE_CHART_TARU)
    local qm4 = GetNPCByID(valkID.npc.PIRATE_CHART_QM)
    local event = timerTable[1]

    if not (qm4 and panicTaru and event) then
        return
    end

    if elapsedTime_ms < event.time then
        return timerTable
    end

    if event.text then
        if event.text == valkID.text.RIGHT_OVER_THERE_POINT + 5 then
            panicTaru:messageText(panicTaru, event.text, false)
        else
            qm4:showText(qm4, event.text)
        end
    end

    if event.emote then
        panicTaru:sendEmote(qm4, event.emote, xi.emoteMode.MOTION)
    end

    if event.animationString then
        panicTaru:entityAnimationPacket(event.animationString)
    end

    table.remove(timerTable, 1)

    return timerTable
end

local function rangeChecking(npc, spawner, timeToMobSpawn, timeOfLastCheck, wasInRangeLastCheck, timeOutOfRangeLastMsg, timerTable)
    if eventIsNotValid(npc) then
        resetEvent()

        return false
    end

    local timeOfCurrentCheck = GetSystemTime()
    local timeElapsedThisCheck = (timeOfCurrentCheck - timeOfLastCheck) * 1000
    local totalTimeElapsed = 50000 - timeToMobSpawn
    local isInRange = true
    local timeOutOfRange = 0

    timerTable = tryTaruEmote(totalTimeElapsed, timerTable)

    if spawner:checkDistance(npc) > 10 then
        isInRange = false
        timeOutOfRange = timeOutOfRangeLastMsg - timeElapsedThisCheck
        if wasInRangeLastCheck or (timeOutOfRange > 5000) then
            spawner:messageSpecial(valkID.text.NO_LONGER_FEEL_CHILL)
            timeOutOfRange = 0
        end
    end

    if timeToMobSpawn > 1000 then
        npc:timer(1000, function(npcArg)
            rangeChecking(npcArg, spawner, timeToMobSpawn - timeElapsedThisCheck, timeOfCurrentCheck, isInRange, timeOutOfRange, timerTable)
        end)
    elseif
        spawner:checkDistance(npc) > 10 or
        not spawner:isAlive()
    then
        resetEvent()
    else
        local panicTaru  = GetNPCByID(valkID.npc.PIRATE_CHART_TARU)
        local shimmering = GetNPCByID(valkID.npc.SHIMMERING_POINT)

        if panicTaru and shimmering then
            panicTaru:setStatus(xi.status.DISAPPEAR)
            panicTaru:setAnimation(xi.animation.NONE)
            shimmering:setStatus(xi.status.DISAPPEAR)
        end

        local params =
        {
            timeLimit = 600, -- 10 minutes

            onLose = function(member)
                removeFromConfrontation(member)
            end,

            playerList = {},
        }

        for i = 1, 3 do
            local member = GetPlayerByID(npc:getLocalVar('pChartMemberID_' .. i))

            if
                member and
                member:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) and
                member:getStatusEffect(xi.effect.LEVEL_RESTRICTION):getPower() == 20 and
                member:getZoneID() == xi.zone.VALKURM_DUNES
            then
                table.insert(params.playerList, member)
            end
        end

        xi.confrontation.start(spawner, npc, barnacleBuddyIDs, params)
    end
end

xi.piratesChart.onTrade = function(player, npc, trade)
    if player:getPartySize() > 3 then
        player:messageSpecial(valkID.text.TOO_MANY_IN_PARTY, 3)
    elseif player:checkSoloPartyAlliance() == 2 then
        player:messageSpecial(valkID.text.ALLIANCE_NOT_ALLOWED)
    elseif
        npc:getStatus() == xi.status.NORMAL and
        npcUtil.tradeHasExactly(trade, xi.item.PIRATES_CHART)
    then
        player:messageSpecial(valkID.text.RETURN_TO_SEA, xi.item.PIRATES_CHART)
        player:startEvent(14, 0, 0, 0, 3)
    end
end

xi.piratesChart.onEventUpdate = function(player, csid, option, npc)
    if csid == 14 and option == 0 then
        player:confirmTrade()

        local party = player:getParty()

        if #party > 3 then
            return
        end

        npc:setLocalVar('pChartSpawnerID', player:getID())

        -- Change music for party and remove buffs/temp items
        for idx, member in ipairs(party) do
            local memberID = member:getID()

            npc:setLocalVar('pChartMemberID_' .. idx, memberID)

            member:changeMusic(0, 136)
            member:changeMusic(1, 136)
            member:changeMusic(2, 136)
            member:changeMusic(3, 136)
            member:delStatusEffectsByFlag(xi.effectFlag.DISPELABLE)
            member:delStatusEffect(xi.effect.RERAISE)
            member:delContainerItems(xi.inv.TEMPITEMS)
            member:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 20, 0, 0, 0, 0)
        end
    end
end

xi.piratesChart.onEventFinish = function(player, csid, option, npc)
    if csid == 14 and option == 0 then
        local panicTaru  = GetNPCByID(valkID.npc.PIRATE_CHART_TARU)
        local shimmering = GetNPCByID(valkID.npc.SHIMMERING_POINT)

        if
            not panicTaru or
            not shimmering
        then
            return
        end

        -- Setup starting conditions
        panicTaru:setStatus(xi.status.NORMAL)
        panicTaru:setAnimation(xi.animation.NONE)
        shimmering:setStatus(xi.status.NORMAL)
        npc:setStatus(xi.status.DISAPPEAR)

        -- Events will occur for the next 50 seconds according to eventTable
        -- confrontation will start when timer hits 0 and player still
        -- meets all required criteria
        rangeChecking(npc, player, 50000, GetSystemTime(), true, 0, eventTable)
    end
end

local function myBuddiesAreDead(mob)
    local mobID = mob:getID()
    for _, buddyID in ipairs(barnacleBuddyIDs) do
        local buddy = GetMobByID(buddyID)
        if
            mobID ~= buddyID and
            buddy and
            buddy:isAlive()
        then
            return false
        end
    end

    return true
end

xi.piratesChart.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 60)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 100)
end

xi.piratesChart.onMobFight = function(mob, target)
    if
        mob:getHPP() < 50 and
        mob:getLocalVar('usedTwoHour') == 0
    then
        mob:useMobAbility(xi.mobSkill.HUNDRED_FISTS_1)
        mob:setLocalVar('usedTwoHour', 1)
    end

    if GetSystemTime() > mob:getLocalVar('snareTimeLimit') then
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 100)
    end
end

xi.piratesChart.onMobDeath = function(mob, player, optParams)
    if mob:getLocalVar('spawnedChest') == 1 then
        return
    end

    if myBuddiesAreDead(mob) then
        -- Player beat all three bad guys, get treasure chest to appear on this one
        local barnacledBox = GetNPCByID(valkID.npc.BARNACLED_BOX)

        if not barnacledBox then
            return
        end

        barnacledBox:teleport(mob:getPos(), mob:getRotPos())
        barnacledBox:setStatus(xi.status.NORMAL)
        barnacledBox:setLocalVar('open', 0)
        mob:setLocalVar('spawnedChest', 1)
    end
end

xi.piratesChart.onItemCheck = function(target, item, param, caster)
    local targetID = target:getID()

    for _, pirateMobID in ipairs(barnacleBuddyIDs) do
        if targetID == pirateMobID then
            return 0
        end
    end

    return xi.msg.basic.CANNOT_ON_THAT_TARG
end

local pChartLoot =
{
    {
        { itemId = xi.item.CORAL_FRAGMENT,           weight = xi.loot.weight.VERY_LOW  }, --  4.3%
        { itemId = xi.item.DRILL_CALAMARY,           weight = xi.loot.weight.NORMAL    }, -- 21.7%
        { itemId = xi.item.DWARF_PUGIL,              weight = xi.loot.weight.LOW       }, -- 13.0%
        { itemId = xi.item.HIGH_QUALITY_PUGIL_SCALE, weight = xi.loot.weight.VERY_LOW  }, --  4.3%
        { itemId = xi.item.ONZ_OF_SALINATOR,         weight = xi.loot.weight.LOW       }, -- 13.0%
        { itemId = xi.item.SHALL_SHELL,              weight = xi.loot.weight.VERY_HIGH }, -- 43.5%
        { itemId = xi.item.ZEBRA_EEL,                weight = xi.loot.weight.LOW       }, -- 13.0%
    },

    {
        { itemId = xi.item.ARROWWOOD_LOG,   weight = xi.loot.weight.HIGH     }, -- 21.2%
        { itemId = xi.item.CORAL_BUTTERFLY, weight = xi.loot.weight.NORMAL   }, -- 15.2%
        { itemId = xi.item.CORAL_FRAGMENT,  weight = xi.loot.weight.VERY_LOW }, --  3.0%
        { itemId = xi.item.DRILL_CALAMARY,  weight = xi.loot.weight.NORMAL   }, -- 15.2%
        { itemId = xi.item.DWARF_PUGIL,     weight = xi.loot.weight.NORMAL   }, -- 15.2%
        { itemId = xi.item.NEBIMONITE,      weight = xi.loot.weight.LOW      }, --  9.1%
        { itemId = xi.item.SHALL_SHELL,     weight = xi.loot.weight.HIGH     }, -- 21.2%
    },

    {
        { itemId = xi.item.FUSCINA,          weight = xi.loot.weight.NORMAL        }, -- 80.6%
        { itemId = xi.item.MERCURIAL_KRIS,   weight = xi.loot.weight.EXTREMELY_LOW }, --  3.2%
        { itemId = xi.item.PIECE_OF_OXBLOOD, weight = xi.loot.weight.VERY_LOW      }, -- 16.1%
    },

    {
        { itemId = xi.item.ALBATROSS_RING, weight = 1000 }, -- 100%
    },
}

xi.piratesChart.barnacledBoxOnTrigger = function(player, npc)
    local qm4 = GetNPCByID(valkID.npc.PIRATE_CHART_QM)

    if qm4 then
        local spawnerID = qm4:getLocalVar('pChartSpawnerID')

        if player:getID() ~= spawnerID then
            return
        end
    end

    resetEvent()

    -- Distribute rewards
    if npc:getLocalVar(xi.animationString.OPEN_CRATE_GLOW) == 0 then
        npc:entityAnimationPacket(xi.animationString.OPEN_CRATE_GLOW)
        npc:setLocalVar(xi.animationString.OPEN_CRATE_GLOW, 1)

        local rewards = utils.selectFromLootGroups(player, pChartLoot)
        for _, entry in ipairs(rewards) do
            player:addTreasure(entry.itemId, npc)
        end

        npc:timer(15000, function(npcArg)
            npcArg:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
        end)

        npc:timer(16000, function(npcArg)
            npcArg:setStatus(xi.status.DISAPPEAR)
        end)
    end
end
