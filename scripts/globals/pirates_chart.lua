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

-----------------------------------
-- Data tables
-----------------------------------
local barnacleBuddyIDs =
{
    valkID.mob.BEACH_MONK,
    valkID.mob.HEIKE_CRAB,
    valkID.mob.HOUU_THE_SHOALWADER,
}

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

local eventTable =
{
    [1] = { time = 1,  text = valkID.text.RIGHT_OVER_THERE_POINT + 0, emote = xi.emote.POINT, animationString = nil                             },
    [2] = { time = 20, text = valkID.text.RIGHT_OVER_THERE_POINT + 1, emote = xi.emote.PANIC, animationString = nil                             },
    [3] = { time = 30, text = valkID.text.RIGHT_OVER_THERE_POINT + 2, emote = xi.emote.PANIC, animationString = nil                             },
    [4] = { time = 40, text = valkID.text.RIGHT_OVER_THERE_POINT + 3, emote = xi.emote.PANIC, animationString = nil                             },
    [5] = { time = 45, text = valkID.text.RIGHT_OVER_THERE_POINT + 4, emote = nil,            animationString = nil                             },
    [6] = { time = 46, text = valkID.text.RIGHT_OVER_THERE_POINT + 5, emote = nil,            animationString = xi.animationString.EFFECT_DEATH },
}

-----------------------------------
-- Local functions
-----------------------------------

local function eventIsNotValid(npc)
    local spawnerID = npc:getLocalVar('pChartSpawnerID')
    local spawner   = GetPlayerByID(spawnerID)

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
        local member   = GetPlayerByID(memberID)

        if
            member and
            memberID ~= spawnerID and
            member:getZoneID() == xi.zone.VALKURM_DUNES and
            member:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) and
            member:getStatusEffect(xi.effect.LEVEL_RESTRICTION):getPower() ~= 20
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
    player:setLocalVar('pChartActive', 0)
end

local function resetEvent(members)
    local qm4          = GetNPCByID(valkID.npc.PIRATE_CHART_QM)
    local panicTaru    = GetNPCByID(valkID.npc.PIRATE_CHART_TARU)
    local shimmering   = GetNPCByID(valkID.npc.SHIMMERING_POINT)
    local barnacledBox = GetNPCByID(valkID.npc.BARNACLED_BOX)

    if members then
        for _, member in ipairs(members) do
            removeFromConfrontation(member)
        end
    end

    if qm4 then
        qm4:resetLocalVars()
        qm4:setStatus(xi.status.NORMAL)
    end

    if barnacledBox then
        barnacledBox:resetLocalVars()
    end

    if panicTaru then
        panicTaru:setStatus(xi.status.DISAPPEAR)
        panicTaru:setAnimation(xi.animation.NONE)
    end

    if shimmering then
        shimmering:setStatus(xi.status.DISAPPEAR)
    end
end

local function tryTaruEmote(elapsedTime, phase)
    if phase > #eventTable then
        return phase
    end

    local event = eventTable[phase]
    if elapsedTime < event.time then
        return phase
    end

    local panicTaru = GetNPCByID(valkID.npc.PIRATE_CHART_TARU)
    if not panicTaru then
        return phase
    end

    local qm4 = GetNPCByID(valkID.npc.PIRATE_CHART_QM)
    if not qm4 then
        return phase
    end

    if event.text then
        if event.text == valkID.text.RIGHT_OVER_THERE_POINT + 5 then
            panicTaru:messageText(panicTaru, event.text, false)
        else
            qm4:showText(qm4, event.text)
        end
    end

    if event.emote then
        panicTaru:sendEmote(qm4, event.emote, xi.emoteMode.MOTION, false)
    end

    if event.animationString then
        panicTaru:entityAnimationPacket(event.animationString)
    end

    return phase + 1
end

local function rangeChecking(npc, spawner, timeToMobSpawn, timeOfLastCheck, wasInRangeLastCheck, timeOutOfRangeLastMsg, phase)
    if eventIsNotValid(npc) then
        resetEvent(spawner:getParty())

        return false
    end

    local currentTime          = GetSystemTime()
    local timeElapsedThisCheck = currentTime - timeOfLastCheck
    local isInRange            = true
    local timeOutOfRange       = 0

    phase = tryTaruEmote(50 - timeToMobSpawn, phase)

    if spawner:checkDistance(npc) > 10 then
        isInRange      = false
        timeOutOfRange = timeOutOfRangeLastMsg - timeElapsedThisCheck
        if wasInRangeLastCheck or timeOutOfRange > 5 then
            spawner:messageSpecial(valkID.text.NO_LONGER_FEEL_CHILL)
            timeOutOfRange = 0
        end
    end

    if timeToMobSpawn > 0 then
        npc:timer(1000, function(npcArg)
            rangeChecking(npcArg, spawner, timeToMobSpawn - timeElapsedThisCheck, currentTime, isInRange, timeOutOfRange, phase)
        end)
    elseif
        spawner:checkDistance(npc) > 10 or
        not spawner:isAlive()
    then
        resetEvent(spawner:getParty())
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

-----------------------------------
-- Global functions
-----------------------------------

xi.piratesChart.onTrade = function(player, npc, trade)
    local barnacledBox = GetNPCByID(valkID.npc.BARNACLED_BOX)
    if
        barnacledBox and
        barnacledBox:getStatus() == xi.status.NORMAL
    then
        return
    end

    for _, member in ipairs(player:getParty()) do
        if member:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
            return
        end
    end

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
    if csid ~= 14 then
        return
    end

    if option ~= 0 then
        return
    end

    local barnacledBox = GetNPCByID(valkID.npc.BARNACLED_BOX)
    if not barnacledBox then
        return
    end

    local party = player:getParty()
    if #party > 3 then
        return
    end

    player:confirmTrade()
    player:setLocalVar('pChartActive', 1)
    npc:setLocalVar('pChartSpawnerID', player:getID())
    barnacledBox:setLocalVar('pChartSpawnerID', player:getID())

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
        member:addStatusEffect(xi.effect.LEVEL_RESTRICTION, { power = 20, origin = player })
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
        npc:setStatus(xi.status.DISAPPEAR)
        shimmering:setStatus(xi.status.NORMAL)

        -- Appearing packet needs time to finish before another packet can be sent successfully
        shimmering:timer(2000, function(shimmerArg)
            shimmerArg:entityAnimationPacket(xi.animationString.SHIMMER)
        end)

        -- Events will occur for the next 50 seconds according to eventTable
        -- confrontation will start when timer hits 0 and player still
        -- meets all required criteria
        rangeChecking(npc, player, 50, GetSystemTime(), true, 0, 1)
    end
end

xi.piratesChart.myBuddiesAreDead = function(mob)
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

    if xi.piratesChart.myBuddiesAreDead(mob) then
        -- Player beat all three bad guys, get treasure chest to appear on this one
        local barnacledBox = GetNPCByID(valkID.npc.BARNACLED_BOX)

        if not barnacledBox then
            return
        end

        barnacledBox:teleport(mob:getPos(), mob:getRotPos())
        barnacledBox:setStatus(xi.status.NORMAL)
        barnacledBox:setLocalVar('open', 0)
        mob:setLocalVar('spawnedChest', 1)
        barnacledBox:timer(180000, function(npcArg)
            local spawnerID = barnacledBox:getLocalVar('pChartSpawnerID')
            local spawner = GetPlayerByID(spawnerID)

            npcArg:setStatus(xi.status.DISAPPEAR)

            if spawner then
                resetEvent(spawner:getParty())
            else
                resetEvent()
            end
        end)
    end
end

xi.piratesChart.onItemCheck = function(target, item, caster)
    for _, pirateMobID in pairs(barnacleBuddyIDs) do
        if target:getID() == pirateMobID then
            return 0
        end
    end

    return xi.msg.basic.CANNOT_ON_THAT_TARG
end

xi.piratesChart.barnacledBoxOnTrigger = function(player, npc)
    local spawnerID = npc:getLocalVar('pChartSpawnerID')

    if player:getID() ~= spawnerID then
        return
    end

    resetEvent(player:getParty())

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
