-----------------------------------
-- CBXI Util
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("cbxi_util")

cbxi      = cbxi or {}
cbxi.util = cbxi.util or {}

local pathWithFilename = io.popen("cd"):read'*all'

cbxi.util.ensureNPC = function(zoneName, npcName)
    local filename = pathWithFilename:sub(1, -2) .. string.format("\\scripts\\zones\\%s\\npcs\\%s", zoneName, npcName) .. ".lua"
    local exists = io.open(filename,"r")
    if exists ~= nil then
        io.close(exists)
    else
        xi.module.ensureTable(string.format("xi.zones.%s.npcs.%s", zoneName, npcName))
    end
end

cbxi.util.removeNPC = function(npc)
    -- This will send the packet to ensure NPC disappears for player
    npc:setStatus(xi.status.INVISIBLE)

    npc:timer(500, function(npcArg)
        if npcArg ~= nil then
            -- This will delete DE server side on zone tick
            npcArg:setStatus(xi.status.DISAPPEAR)
        end
    end)
end

cbxi.util.createLookup = function(tbl)
    local result = {}

    for _, row in pairs(tbl) do
        result[row] = true
    end

    return result
end

cbxi.util.forAlliance = function(player, func)
    if
        player == nil or
        not player:isPC()
    then
        return
    end

    local zoneID   = player:getZoneID()
    local alliance = player:getAlliance()

    for _, member in pairs(alliance) do
        if member:getZoneID() == zoneID then
            func(member)
        end
    end
end

-- Returns random number from a range excluding a specified number
-- eg. cbxi.util.randomNoRepeat(5, 3) randomly returns 1,2,4,5
cbxi.util.randomNoRepeat = function(size, exclude)
    local range = {}

    for i = 1, size do
        if i ~= exclude then
            table.insert(range, i)
        end
    end

    return range[math.random(1, #range)]
end

-- Returns random number from a bitmask excluding bits which are already set
-- Assumes 1-32 for simplicity with 1-indexed arrays in lua
cbxi.util.randomBitNoRepeat = function(bits, num)
    local range = {}

    for i = 1, 32 do
        if not utils.mask.getBit(bits, i - 1) then
            table.insert(range, i)
        end
    end

    if num == nil or num == 1 then
        return range[math.random(1, #range)]
    else
        local result = {}

        for i = 1, num do
            table.insert(result, range[math.random(1, #range)])
        end

        return result
    end
end

cbxi.util.setMusic = function(player, id)
    if type(id) == "table" then
        player:changeMusic(0, id[1])
        player:changeMusic(1, id[2])
        player:changeMusic(2, id[3])
        player:changeMusic(3, id[4])
    else
        player:changeMusic(0, id)
        player:changeMusic(1, id)
        player:changeMusic(2, id)
        player:changeMusic(3, id)
    end
end

cbxi.util.helperScroll = function(player, qty)
    if
        not npcUtil.giveItem(player, { { xi.item.DRAGON_CHRONICLES, qty or 1 } } ) and
        (player:isCrystalWarrior() or player:isClassicMode())
    then
        player:incrementCharVar("[HELPER]EXP_SCROLLS", qty or 1)
        player:fmt("The dragon chronicles was stored at Perrin.")
    end
end

cbxi.util.printList = function(tbl)
    local result = tbl[1]

    if #tbl == 1 then
        return result
    end

    for index, item in pairs(tbl) do
        if index == #tbl then
            result = fmt("{} and {}", result, item)
        elseif index > 1 then
            result = fmt("{}, {}", result, item)
        end
    end

    return result
end

cbxi.util.tradeContainsOnly = function(trade, list)
    for i = 0, trade:getSlotCount() - 1 do
        local itemID = trade:getItemId(i)

        if list[itemID] == nil then
            return false
        end
    end

    return true
end

cbxi.util.tradeHasExactly = function(trade, items)
    -- create table of traded items, with key/val of itemId/itemQty
    local tradedItems = {}
    local itemId
    local itemQty

    for i = 0, trade:getSlotCount() - 1 do
        itemId = trade:getItemId(i)
        itemQty = trade:getItemQty(itemId)
        tradedItems[itemId] = itemQty
    end

    -- create table of needed items, with key/val of itemId/itemQty
    local neededItems = {}
    if type(items) == 'number' then
        neededItems[items] = 1
    elseif type(items) == 'table' then
        local itemIdNeeded
        local itemQtyNeeded
        for _, v in pairs(items) do
            if type(v) == 'number' then
                itemIdNeeded = v
                itemQtyNeeded = 1
            elseif
                type(v) == 'table' and
                #v == 2 and
                type(v[1]) == 'number' and
                type(v[2]) == 'number'
            then
                itemIdNeeded = v[1]
                itemQtyNeeded = v[2]
            elseif
                type(v) == 'table' and
                #v == 2 and
                type(v[1]) == 'string' and
                type(v[2]) == 'number' and
                string.lower(v[1]) == 'gil'
            then
                itemIdNeeded = 65535
                itemQtyNeeded = v[2]
            else
                print('ERROR: invalid value contained within items parameter given to npcUtil.tradeHas.')
                itemIdNeeded = nil
            end

            if itemIdNeeded ~= nil then
                neededItems[itemIdNeeded] = (neededItems[itemIdNeeded] == nil) and itemQtyNeeded or neededItems[itemIdNeeded] + itemQtyNeeded
            end
        end
    else
        print('ERROR: invalid items parameter given to npcUtil.tradeHas.')
        return false
    end

    -- determine whether all needed items have been traded. return false if not.
    for k, v in pairs(neededItems) do
        local tradedQty = (tradedItems[k] == nil) and 0 or tradedItems[k]
        if v > tradedQty then
            return false
        else
            tradedItems[k] = tradedQty - v
        end
    end

    -- if an exact trade was requested, check if any excess items were traded. if so, return false.
    for k, v in pairs(tradedItems) do
        if v > 0 then
            return false
        end
    end

    return true
end

cbxi.util.giveItem = function(player, items, params)
    params = params or {}
    local ID = zones[player:getZoneID()]

    -- create table of items, with key/val of itemId/itemQty
    local givenItems = {}
    if type(items) == 'number' then
        table.insert(givenItems, { items, 1 })
    elseif type(items) == 'table' then
        for _, v in pairs(items) do
            if type(v) == 'number' then
                table.insert(givenItems, { v, 1 })
            elseif
                type(v) == 'table' and
                #v == 2 and
                type(v[1]) == 'number' and
                type(v[2]) == 'number'
            then
                table.insert(givenItems, { v[1], v[2] })
            else
                print(string.format('ERROR: invalid items parameter given to npcUtil.giveItem in zone %s.', player:getZoneName()))
                return false
            end
        end
    end

    -- does player have enough inventory space?
    if player:getFreeSlotsCount() < #givenItems then
        if not params.silent then
            local messageId = params.fromTrade and (ID.text.ITEM_CANNOT_BE_OBTAINED + 4) or ID.text.ITEM_CANNOT_BE_OBTAINED
            player:messageSpecial(messageId, givenItems[1][1])
        end

        return false
    end

    -- give items to player
    local messagedItems = {}
    for _, v in pairs(givenItems) do
        if player:addItem(v[1], v[2], true) then
            if not params.silent and not messagedItems[v[1]] then
                if
                    v[2] > 1 or
                    params.multiple
                then
                    player:messageSpecial(ID.text.ITEM_OBTAINED + 9, v[1], v[2])
                else
                    player:messageSpecial(ID.text.ITEM_OBTAINED, v[1])
                end
            end

            messagedItems[v[1]] = true
        elseif #givenItems == 1 then
            if not params.silent then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, givenItems[1][1])
            end

            return false
        end
    end

    return true
end

local function removeLevelRestriction(mob, player)
    local zoneID  = mob:getZoneID()

    -- If player reference is valid, remove effect from party
    if player ~= nil then
        local party = player:getParty()

        for _, member in pairs(party) do
            if member:getZoneID() == zoneID then
                member:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            end
        end

        return
    end

    -- Infer player from stored ID
    local spawner = mob:getLocalVar("SPAWNER_ID")
    local player  = GetPlayerByID(spawner)

    if
        player ~= nil and
        player:getZoneID() == zoneID
    then
        local party = player:getParty()

        for _, member in pairs(party) do
            if member:getZoneID() == zoneID then
                member:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            end
        end
    end
end

cbxi.util.spawnEncounter = function(player, npc, info)
    local zone     = player:getZone()
    local zoneID   = player:getZoneID()
    local alliance = player:getAlliance()

    for _, member in pairs(alliance) do
        if member:getZoneID() == zoneID then
            member:addStatusEffectEx(
                xi.effect.LEVEL_RESTRICTION,
                xi.effect.LEVEL_RESTRICTION,
                info.capped or 75,
                0,
                0,
                0,
                0,
                0,
                xi.effectFlag.ON_ZONE + xi.effectFlag.CONFRONTATION
            )
        end
    end

    npc:setStatus(xi.status.INVISIBLE)

    if info.mobs ~= nil then
        for _, mobInfo in pairs(info.mobs) do

            local mobTable =
            {
                objtype     = xi.objType.MOB,
                name        = mobInfo.name,
                look        = mobInfo.look,
                x           = mobInfo.pos[1],
                y           = mobInfo.pos[2],
                z           = mobInfo.pos[3],
                rotation    = mobInfo.pos[4],
                groupId     = mobInfo.groupId,
                groupZoneId = mobInfo.groupZoneId,
                releaseIdOnDisappear = true,
            }

            mobTable.onMobRoam = function(mob)
                npc:setStatus(xi.status.NORMAL)

                for _, otherMob in pairs(info.mobs) do
                    local others = zone:queryEntitiesByName("DE_" .. otherMob.name)

                    if others ~= nil then
                        for _, other in pairs(others) do
                            if other == nil or not other:isAlive() then
                                print(fmt("DEBUG: {}", other))
                            else
                                other:setHP(0)
                            end
                        end
                    end
                end

                removeLevelRestriction(mob)
            end

            mobTable.onMobDeath = function(mob, player, optParams)
                if
                    mobInfo.drops ~= nil and
                    player ~= nil
                then
                    for _, itemInfo in pairs(mobInfo.drops) do
                        player:addTreasure(itemInfo[2], mob, itemInfo[1])
                    end
                end

                if info.after == nil then
                    return
                end

                -- Check if any mobs are still alive
                for _, otherMob in pairs(info.mobs) do
                    local other = zone:queryEntitiesByName("DE_" .. otherMob.name)

                    if
                        other ~= nil and
                        other[1] ~= nil and
                        other[1]:isAlive()
                    then
                        return
                    end
                end

                npc:setStatus(xi.status.NORMAL)

                removeLevelRestriction(mob, player)

                info.after(mob, player)
            end

            local mob = zone:insertDynamicEntity(mobTable)

            mob:setSpawn(mobInfo.pos[1], mobInfo.pos[2], mobInfo.pos[3], mobInfo.pos[4])

            if mobInfo.dropID then
                mob:setDropID(mobInfo.dropID)
            else
                mob:setDropID(0)
            end

            if mobInfo.special ~= nil then
                g_mixins.job_special(mob)
            end

            mob:spawn()
            mob:setMobLevel(mobInfo.level)
            mob:updateClaim(player)
            mob:setLocalVar("NO_CASKET", 1)
            mob:setLocalVar("SPAWNER_ID", player:getID())

            mob:setRespawnTime(0)
            DisallowRespawn(mob:getID(), true)

            mob:addStatusEffectEx(
                xi.effect.LEVEL_RESTRICTION,
                xi.effect.LEVEL_RESTRICTION,
                info.capped or 75,
                0,
                0,
                0,
                0,
                0,
                xi.effectFlag.ON_ZONE + xi.effectFlag.CONFRONTATION
            )

            if mobInfo.mods ~= nil then
                for mod, value in pairs(mobInfo.mods) do
                    mob:setMod(mod, value)
                end
            end

            if mobInfo.effects ~= nil then
                for effectID, effectTable in pairs(mobInfo.effects) do
                    mob:addStatusEffect(effectID, unpack(effectTable))
                end
            end

            if mobInfo.hp ~= nil then
                mob:setHP(mobInfo.hp)
            end

            if info.drawIn ~= nil then
                mob:setMobMod(xi.mobMod.DRAW_IN, 2)
            end
        end
    end
end

-----------------------------------
-- Battlefields/Encounters
-----------------------------------
local function setEncounter(entity, params)
    local flags = xi.effectFlag.DEATH + xi.effectFlag.ON_ZONE + xi.effectFlag.CONFRONTATION

    if params.retainOnDeath then
        flags = xi.effectFlag.ON_ZONE + xi.effectFlag.CONFRONTATION
    end

    local level = 75

    if params.level ~= nil then
        level = params.level
    end

    entity:addStatusEffectEx(
        xi.effect.LEVEL_RESTRICTION,
        xi.effect.LEVEL_RESTRICTION,
        level,
        0,
        0,
        0,
        0,
        0,
        flags
    )
end

cbxi.util.mobEncounter = function(mob, params)
    setEncounter(mob, params)
end

cbxi.util.allianceEncounter = function(player, params)
    local zoneID   = player:getZoneID()
    local alliance = player:getAlliance()

    for i = 1, #alliance do
        if alliance[i]:getZoneID() == zoneID then
            setEncounter(alliance[i], params)

            local pet = alliance[i]:getPet()

            if pet ~= nil then
                setEncounter(pet, params)
            end
        end
    end
end

cbxi.util.leaveEncounter = function(player)
    player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)

    local pet = player:getPet()

    if pet ~= nil then
        pet:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
    end
end

cbxi.util.finishEncounter = function(player)
    local zoneID   = player:getZoneID()
    local alliance = player:getAlliance()

    for _, member in pairs(alliance) do
        if member:getZoneID() == zoneID then
            member:delStatusEffect(xi.effect.LEVEL_RESTRICTION)

            local pet = member:getPet()

            if pet ~= nil then
                pet:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            end
        end
    end
end

cbxi.util.scaledEncounter = function(player, mob, bonus)
    local zoneID   = player:getZoneID()
    local alliance = player:getAlliance()
    local total    = 0

    setEncounter(mob)

    for _, member in pairs(alliance) do
        if member:getZoneID() == zoneID then
            setEncounter(member)

            if member:isPC() then
                total = total + 1
            end

            local pet = member:getPet()

            if pet ~= nil then
                setEncounter(pet)
            end
        end
    end

    -- Exclude the first player
    total = total - 1

    -- Assign this a safe value just incase
    total = utils.clamp(total, 0, 17)

    mob:setMod(xi.mod.HPP, math.ceil((bonus or 5) * total))
    mob:updateHealth()
    mob:setHP(mob:getMaxHP())
end

-----------------------------------
-- Dynamic Battlefields
-----------------------------------
cbxi.util.addDynamicMob = function(zone, mobInfo)
    local dynamicEntity =
    {
        name        = mobInfo.name,
        objtype     = xi.objType.MOB,
        groupId     = mobInfo.groupId,
        groupZoneId = mobInfo.groupZoneId,
        look        = mobInfo.look,
        x           = mobInfo.x,
        y           = mobInfo.y,
        z           = mobInfo.z,
        rotation    = mobInfo.rotation,
        level       = mobInfo.level,
        respawn     = mobInfo.respawn,
        widescan    = 1,
    }

    dynamicEntity.onMobInitialize = function(mob)
        mob:setMobMod(xi.mobMod.DETECTION, 0x08)
        mob:setMobMod(xi.mobMod.CHARMABLE,    0)

        if mobInfo.notorious then
            mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
        end
    end

    dynamicEntity.onMobSpawn = function(mob)
        if type(mobInfo.level) == "table" then -- Roll level if table (random range)
            mob:setMobLevel(math.random(mobInfo.level[1], mobInfo.level[2]))
        else
            mob:setMobLevel(mobInfo.level)
        end

        if mobInfo.mobMods ~= nil then
            for mod, value in pairs(mobInfo.mobMods) do
                mob:setMobMod(mod, value)
            end
        end

        if mobInfo.mods ~= nil then
            for mod, value in pairs(mobInfo.mods) do
                mob:setMod(mod, value)
            end
        end

        mob:setHP(mob:getMaxHP())
        mob:setMP(mob:getMaxMP())
        mob:updateHealth()
    end

    dynamicEntity.onMobDeath = function(mob, player, optParams)
        if type(mobInfo.respawn) == "table" then -- Roll next respawn if table (random range)
            mob:setRespawnTime(math.random(mobInfo.respawn[1], mobInfo.respawn[2]))
        end

        if
            mobInfo.drops ~= nil and -- If mob has table defined drops, roll them
            player ~= nil           -- Check the player reference so we don't crash
        then
            for _, v in ipairs(mobInfo.drops) do
                player:addTreasure(v[2], mob, v[1])
            end
        end

        if mobInfo.onMobDeath ~= nil then
            mobInfo.onMobDeath(mob, player, optParams)
        end
    end

    local entity = zone:insertDynamicEntity(dynamicEntity)

    entity:setSpawn(mobInfo.x, mobInfo.y, mobInfo.z, mobInfo.rotation)

    if mobInfo.flags ~= nil then
        entity:setMobFlags(mobInfo.flags)
    end

    if type(mobInfo.respawn) == "table" then
        entity:setRespawnTime(math.random(mobInfo.respawn[1], mobInfo.respawn[2]))
    else
        entity:setRespawnTime(mobInfo.respawn)
    end

    if mobInfo == nil and mobInfo.dropID then
        entity:setDropID(mobInfo.dropID)
    else
        entity:setDropID(0)
    end

    entity:spawn()
end

-----------------------------------
-- String Utils
-----------------------------------
cbxi.util.capitalize = function(str)
    return string.upper(string.sub(str, 1, 1)) .. string.lower(string.sub(str, 2))
end

cbxi.util.numWithCommas = function(n)
    local str = tostring(math.floor(n))
    local p1  = string.gsub(string.reverse(str), "(%d%d%d)","%1,")
    local p2  = string.reverse(string.gsub(p1, ",(%-?)$","%1"))

    return p2
end

-- Return the number of (Earth) seconds until next Firesday
cbxi.util.nextVanaWeek = function()
    local daysRemaining    = (7 - VanadielDayOfTheWeek()) * 1440
    local minsRemaining    =  ((24 - VanadielHour()) * 60) + (60 - VanadielMinute())
    local secondsRemaining = ((daysRemaining + minsRemaining) * 60) / 25
    return os.time() + secondsRemaining
end

-----------------------------------
-- Menu Utils
-----------------------------------
local function delaySendMenu(player, menu)
    player:timer(100, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

cbxi.util.simpleMenu = function(player, npc, tbl, func, title, currentPage, param)
    local options  = {}
    local max      = 1
    local lastPage = math.floor((#tbl - 1) / 4)
    local page     = currentPage

    if currentPage == nil then
        page = 0
    end

    if
        page > 0 or
        (param ~= nil and param.cycle)
    then
        local gotoPage = page - 1

        if
            param ~= nil and
            param.cycle and
            page == 0
        then
            gotoPage = lastPage
        end

        table.insert(options, {
            "(Prev)",
            function(player)
                cbxi.util.simpleMenu(player, npc, tbl, func, title, gotoPage, param)
            end,
        })
    end

    for i = 1, 4 do
        local item  = tbl[page * 4 + i]

        if item ~= nil then
            local label = ""

            if
                param ~= nil and
                param.skill ~= nil
            then
                label = string.format("(%u) %s", item.skill, item.name)
            else
                label = item[1]
            end

            table.insert(options, {
                label,
                function(playerArg)
                    func(player, npc, item, param)
                end
            })

            max = page * 4 + i
        end
    end

    if
        max < #tbl or
        (param ~= nil and param.cycle)
    then
        local gotoPage = page + 1

        if
            param ~= nil and
            param.cycle and
            page == lastPage
        then
            gotoPage = 0
        end

        table.insert(options, {
            "(Next)",
            function(player)
                cbxi.util.simpleMenu(player, npc, tbl, func, title, gotoPage, param)
            end,
        })
    end

    delaySendMenu(player, {
        title   = title,
        options = options,
    })
end

cbxi.util.simpleShop = function(player, npc, tbl, func, title, currentPage, param)
    local options  = {}
    local max      = 1
    local lastPage = math.floor((#tbl - 1) / 4)
    local page     = currentPage

    if currentPage == nil then
        page = 0
    end

    if page > 0 then
        table.insert(options, {
            "(Prev)",
            function(player)
                cbxi.util.simpleShop(player, npc, tbl, func, title, page - 1, param)
            end,
        })
    end

    for i = 1, 4 do
        local item  = tbl[page * 4 + i]
        local block = false

        if
            param ~= nil and
            param.milestone ~= nil
        then
            local milestoneVal = player:getCharVar(param.milestone)

            if utils.mask.getBit(milestoneVal, page * 4 + i) then
                block = true
            end
        end

        if item ~= nil then
            local itemName = item[1]
            local itemCost = item[3]
            local label    = itemName

            if itemCost > 0 then
                if block then
                    label = string.format("-Claimed- (%u)", itemCost)
                else
                    label = string.format("%s (%u)", label, itemCost)
                end
            end

            table.insert(options, {
                label,
                function(playerArg)
                    if not block then
                        func(player, npc, item, param)
                    end
                end
            })

            max = page * 4 + i
        end
    end

    if max < #tbl then
        table.insert(options, {
            "(Next)",
            function(player)
                cbxi.util.simpleShop(player, npc, tbl, func, title, page + 1, param)
            end,
        })
    end

    delaySendMenu(player, {
        title   = title,
        options = options,
    })
end

cbxi.util.categoryMenu = function(player, npc, tbl, func, title)
    local options = {}

    for _, category in pairs(tbl) do
        table.insert(options, {
            category[1],
            function()
                if type(category[2]) == "table" then
                    cbxi.util.simpleShop(player, npc, category[2], func, title)
                else
                    category[2](player, npc)
                end
            end,
        })
    end

    delaySendMenu(player, {
        title   = title,
        options = options,
    })
end

cbxi.util.skillMenu = function(player, npc, tbl, func, title)
    local options = {}

    for _, category in pairs(tbl) do
        table.insert(options, {
            category[1],
            function()
                if type(category[2]) == "table" then
                    cbxi.util.simpleMenu(player, npc, category[2], func, title, 0, { skill = true })
                else
                    category[2](player, npc)
                end
            end,
        })
    end

    delaySendMenu(player, {
        title   = title,
        options = options,
    })
end

-----------------------------------
-- Loot Rolls
-----------------------------------
-- { { rate, item } }, modifier
cbxi.util.pickItem = function(items, mod)
    -- sum weights
    local sum = 0
    for i = 1, #items do
        if
            mod ~= nil and
            type(items[i][1]) == "table"
        then
            sum = sum + items[i][1][mod]
        else
            sum = sum + items[i][1]
        end
    end

    -- pick weighted result
    local item = items[1]
    local pick = math.random(1, sum)
    sum = 0

    for i = 1, #items do
        if
            mod ~= nil and
            type(items[i][1]) == "table"
        then
            sum = sum + items[i][1][mod]
        else
            sum = sum + items[i][1]
        end

        if sum >= pick then
            item = items[i]
            break
        end
    end

    return item
end

cbxi.util.treasurePool = function(player, pools, source) -- source optional
    for _, pool in pairs(pools) do
        local result = cbxi.util.pickItem(pool)
        player:addTreasure(result[2], source)
    end
end

cbxi.util.openChest = function(npc)
    if npc:getLocalVar("OPENED") > 0 then
        return false
    end

    npc:setLocalVar("OPENED", 1)
    npc:entityAnimationPacket("open")
    npc:timer(5000, function(npcArg)
        npcArg:entityAnimationPacket("close")

        npcArg:timer(5000, function(npcArg2)
            npcArg2:setStatus(xi.status.DISAPPEAR)

            npcArg2:timer(5000, function(npcArg3)
                npcArg3:setLocalVar("OPENED", 0)
            end)
        end)
    end)

    return true
end

-----------------------------------
-- Dynamic Entity Looks
-----------------------------------
cbxi.util.decToLE = function(num)
    local hex = string.format("%04x", num)
    return string.sub(hex, 3, 4) .. string.sub(hex, 1, 2)
end

local modelSlot = { "head", "body", "hand", "legs", "feet", "main", "offh" }

cbxi.util.look = function(tbl)
    local str = "00"  -- NPC or Mob

    if tbl.face then
        str = str .. string.format("%02x", tbl.face)
    else
        str = str .. "01"
    end

    if tbl.race then
        str = str .. string.format("%02x", tbl.race)
    else
        str = str .. "01"
    end

    for k, v in pairs(modelSlot) do
        if tbl[v] then
            str = str .. cbxi.util.decToLE(tbl[v])
        else
            str = str .. "0000"
        end
    end

    str = str .. "0000" -- Ranged slot

    return "0x01" .. string.upper(str)
end

-----------------------------------
-- Dialog Tables
-----------------------------------
local processLine = function(player, prefix, row, param)
    local str = row

    if param then
        str = string.format(row, param[1], param[2], param[3], param[4], param[5])
    end

    player:printToPlayer(prefix .. str, xi.msg.channel.NS_SAY)
end

local processString = function(player, prefix, row, delay, param)
    local str = row

    if param then
        str = string.format(row, param[1], param[2], param[3], param[4], param[5])
    end

    if str:sub(1, 1) == " " then
        -- Paragraph continue
        player:timer(delay, function(playerArg)
            playerArg:printToPlayer(str, xi.msg.channel.NS_SAY)
        end)
    else
        -- New paragraph
        player:timer(delay, function(playerArg)
            playerArg:printToPlayer(prefix .. str, xi.msg.channel.NS_SAY)
        end)
    end
end

local applyEntities = function(player, entityList, func)
    local zone = player:getZone()

    for i = 1, #entityList do
        local entityName = entityList[i]
        local deEntity   = string.gsub(entityName, "_", " ")
        local result     = zone:queryEntitiesByName("DE_" .. deEntity)

        for j = 1, #result do
            func(result[j], player)
        end
    end
end

local getEntity = function(player, entityName)
    local zone     = player:getZone()
    local deEntity = string.gsub(entityName, "_", " ")
    local result   = zone:queryEntitiesByName("DE_" .. deEntity)
    return result[1]
end

local scriptedEvent = function(player, entities, events)
    local ents = {}
    for i = 1, #entities do
        ents[i] = getEntity(player, entities[i])
        ents[i]:ceSpawn(player)
    end

    for i = 1, #events do
        local event = events[i]
        local delay = 5000 + i * 1000

        player:timer(delay, function()
            ents[event[1]]:entityAnimationPacket(event[2])
        end)
    end

    return 6000 + #events * 1000
end

local processTable = function(player, prefix, row, delay, param)
    -- Face
    -- Turn entity to face target
    if row.face ~= nil then
        if row.entity == nil then
            if
                param ~= nil and
                param.npc ~= nil
            then
                param.npc:ceFace(player)
            end
        else
            local entity = getEntity(player, row.entity)
            if entity == nil then
                return
            end

            if row.face == "player" then
                entity:ceFace(player)
            elseif type(row.face) == "number" then
                entity:ceTurn(player, row.face)
            else
                local otherEntity = getEntity(player, row.face)
                if otherEntity then
                    entity:ceFaceNpc(player, otherEntity)
                end
            end
        end

    elseif row.removeEffect ~= nil then
        if player:hasStatusEffect(row.removeEffect) then
            player:delStatusEffect(row.removeEffect)
        end

    elseif row.charvar ~= nil then
        player:setCharVar(row.charvar, row.value)

    elseif row.costume ~= nil then
        player:setCostume(row.costume)

    elseif row.message ~= nil then
        if type(row.message) == "table" then
            if row.after ~= nil then
                player:timer(row.after, function()
                    for _, message in pairs(row.message) do
                        player:sys(message)
                    end
                end)
            else
                for _, message in pairs(row.message) do
                    player:sys(message)
                end
            end
        else
            player:printToPlayer(row.message, xi.msg.channel.SYSTEM_3)
        end

    elseif row.say ~= nil then
        player:printToPlayer(row.say, xi.msg.channel.NS_SAY)

    elseif row.emotion ~= nil then
        player:printToPlayer(row.emotion, 8, row.name)

    elseif row.special ~= nil then
        player:messageSpecial(row.special)

    elseif row.music ~= nil then
        player:changeMusic(0, row.music)
        player:changeMusic(1, row.music)

    elseif row.pos ~= nil then
        player:setPos(unpack(row.pos))

    elseif
        row.scripted_event ~= nil and
        row.scripted_event.events ~= nil and
        row.scripted_event.entities ~= nil
    then
        return scriptedEvent(player, row.scripted_event.entities, row.scripted_event.events)

    -- NPC Animation Packet
    -- Send an animation packet for the NPC
    elseif
        row.entity ~= nil and
        row.packet ~= nil
    then
        local entity = getEntity(player, row.entity)

        if row.target == nil then
            entity:ceAnimationPacket(player, row.packet, entity)
        else
            local target = getEntity(player, row.entity)
            entity:ceAnimationPacket(player, row.packet, target)
        end

    -- NPC Independent Animation Packet
    -- Send an independent animation packet for the NPC
    elseif
        row.animate ~= nil
    then
        if row.entity ~= nil then
            local entity = getEntity(player, row.entity)

            if row.target == "player" then
                entity:ceAnimate(player, player, row.animate, row.mode or 0)
            else
                entity:ceAnimate(player, entity, row.animate, row.mode or 0)
            end
        else
            player:ceAnimate(player, player, row.animate, row.mode or 0)
        end

    -- Emote NPC
    -- Sends an emote from the source NPC onto the target NPC or player
    elseif row.emote  ~= nil then
        if row.entity == "player" then
            player:selfEmote(player, row.emote, xi.emoteMode.MOTION)

        elseif row.entity ~= nil then
            local entity = getEntity(player, row.entity)
            entity:ceEmote(player, row.emote, xi.emoteMode.MOTION)

        elseif
            param ~= nil and
            param.npc ~= nil
        then
            param.npc:ceEmote(player, row.emote, xi.emoteMode.MOTION)
        end

    -- Animation
    -- Set an animation on the target
    elseif row.animation ~= nil then
        if row.target and row.target == "player" then
            local anim = player:getAnimation()

            player:setAnimation(row.animation)

            player:timer(row.duration, function(player)
                player:setAnimation(anim)
            end)

            return row.duration
        end

    -- Move Dynamic Entity
    -- TODO: Doesn't seem to work (yet)
    elseif
        row.move   ~= nil and
        row.entity ~= nil
    then
        local entity = getEntity(player, row.entity)

        for i = 1, #row.move do
            entity:timer(200, function(npcArg)
                entity:ceMove(player, row.move[i][1], row.move[i][2], row.move[i][3])
            end)
        end

    -- Spawn Dynamic Entities
    elseif row.spawn ~= nil then
        applyEntities(player, row.spawn, function(entity, playerArg)
            entity:ceSpawn(playerArg)
        end)

    -- Despawn Dynamic Entities
    elseif row.despawn ~= nil then
        applyEntities(player, row.despawn, function(entity, playerArg)
            entity:ceDespawn(playerArg)
        end)

    -- Glimpse
    -- Temporarily spawn NPCs then despawn after a short interval
    elseif row.glimpse ~= nil then
        applyEntities(player, row.glimpse[2], function(entity, playerArg)
            entity:ceSpawn(playerArg)
            entity:timer(row.glimpse[1], function(npcArg)
                entity:ceDespawn(playerArg)
            end)
        end)
    end
end

-- Returns the total delay from a dialogTable
cbxi.util.dialogDelay = function(tbl)
    if not tbl or #tbl == 0 then
        print(string.format("[CU] Dialog table for %s missing or empty.", npcName))
        return
    end

    local total = 0

    for i = 1, #tbl do
        local row = tbl[i]
        local nextDelay = 1500

        if row.delay ~= nil then
            nextDelay = row.delay

        elseif row.duration ~= nil then
            nextDelay = row.duration

        elseif row.move ~= nil then
            nextDelay = 200 * #row.move

        elseif row.scripted_event then
            nextDelay = 5000 + 1000 * #row.scripted_event.events

        elseif type(row) == "table" then
            nextDelay = 0
        end

        total = total + nextDelay
    end

    return total
end

cbxi.util.dialog = function(player, tbl, npcName, param)
    if
        type(tbl) ~= "table" and
        type(tbl) ~= "function"
    then
        print("[CU] Dialog must be a table or a function.")
        return
    end

    if player:getLocalVar("[CU]BLOCKING") == 1 then
        return
    end

    if type(tbl) == "function" then
        tbl(player)

        return
    end

    -- `tbl` is definitely a table and the player is available for npc interaction at this point
    local prefix = ""
    if npcName and string.len(npcName) > 0 then
        prefix = string.format("%s : ", npcName)
    end

    -- Utilize the variable above in the (likely rare) case that npcName isn't sent
    if not tbl or #tbl == 0 then
        print(string.format("[CU] Dialog table for (%s) missing or empty.", prefix))
        return
    end

    -- Handle the dialog table as defined
    if param and param.npc then
        if tbl[1].noturn == nil then
            param.npc:ceFace(player)
        end

        player:setLocalVar("[CU]BLOCKING", 1)
    end

    if #tbl == 1 then
        if type(tbl[1]) == "table" then
            processTable(player, prefix, tbl[1], 0, param)
        else
            processLine(player, prefix, tbl[1], param)
        end

        -- Reset NPC position after single line dialog
        if param and param.npc then
            player:timer(3000, function(playerArg)
                param.npc:ceReset(player)
                player:setLocalVar("[CU]BLOCKING", 0)
            end)
        end

        return
    end

    local delay = 0

    for i = 1, #tbl do
        local row = tbl[i]
        local nextDelay = 1500

        if type(row) == "function" then
            -- Delayed function
            player:timer(delay, tbl[i])

        elseif type(row) == "string" then
            processString(player, prefix, row, delay, param)

        -- Process tables
        else
            player:timer(delay, function(playerArg)
                processTable(player, prefix, row, delay, param)
            end)

            if row.delay ~= nil then
                nextDelay = row.delay

            elseif row.duration ~= nil then
                nextDelay = row.duration

            -- TODO: Get this working
            elseif row.move ~= nil then
                nextDelay = 200 * #row.move

            elseif row.scripted_event ~= nil then
                nextDelay = 5000 + 1000 * #row.scripted_event.events

            else
                nextDelay = 0
            end
        end

        delay = delay + nextDelay
    end

    if param and param.npc then
        player:timer(delay + 3000, function(playerArg)
            param.npc:ceReset(player)
            player:setLocalVar("[CU]BLOCKING", 0)
        end)
    end
end

-----------------------------------
-- Override Utils
-----------------------------------
cbxi.util.overrideDuplicate = function(entity, event, func)
    if not entity then
        return
    end

    local origEvent = event .. "Orig"

    if entity[origEvent] == nil then
        if entity[event] then
            entity[origEvent] = entity[event]
        else
            entity[origEvent] = function()
                -- Do nothing
            end
        end
    end

    local thisenv = getfenv(entity[event])
    local env = { super = entity[origEvent] }

    setmetatable(env, { __index = thisenv })
    setfenv(func, env)

    entity[event] = func
end

local function entitySetup(de, entity)
    if entity.objtype == xi.objType.NPC then
        de.onTrigger = entity.onTrigger
        de.onTrade   = entity.onTrade

    elseif entity.objtype == xi.objType.MOB then
        de.onMobSpawn      = entity.onMobSpawn
        de.onMobDespawn    = entity.onMobDespawn
        de.onMobDeath      = entity.onMobDeath
        de.onMobDeathEx    = entity.onMobDeathEx
        de.onMobFight      = entity.onMobFight
        de.onMobDisengage  = entity.onMobDisengage
        de.onMobInitialize = entity.onMobInitialize
    end
end

local function entityRefresh(de, entity, zone)
    local result = zone:queryEntitiesByName("DE_" .. entity.name)

    if result ~= nil then
        for _, de in pairs(result) do
            if entity.pos ~= nil then
                de:setPos(entity.pos[1], entity.pos[2], entity.pos[3], entity.pos[4])
            else
                de:setPos(entity.x, entity.y, entity.z, entity.rotation)
            end

            if entity.hideName then
                de:hideName(true)
            end

            if entity.untargetable then
                de:setUntargetable(true)
            end
        end
    end
end

cbxi.util.liveReload = function(mod, tbl)
    for zoneName, entityList in pairs(tbl) do
        if entityList == nil then
            print("[CU] Attempted entity liveReload with empty list")
            return
        end

        for _, entity in pairs(entityList) do
            mod:addOverride(string.format("xi.zones.%s.Zone.onInitialize", zoneName), function(zone)
                super(zone)

                if entity.objtype == nil then
                    entity.objtype = xi.objType.NPC
                end

                if entity.pos ~= nil then
                    entity.x        = entity.pos[1]
                    entity.y        = entity.pos[2]
                    entity.z        = entity.pos[3]
                    entity.rotation = entity.pos[4]
                end

                local result = zone:insertDynamicEntity(entity)

                if entity.hidden then
                    result:setStatus(xi.status.DISAPPEAR)
                end

                if entity.hideName then
                    result:hideName(true)
                end

                if entity.untargetable then
                    result:setUntargetable(true)
                end

                if entity.anim ~= nil then
                    result:setAnimation(entity.anim)
                end
            end)

            if
                xi ~= nil and
                xi.zones ~= nil and
                xi.zones[zoneName] ~= nil and
                xi.zones[zoneName].npcs ~= nil
            then
                local de = xi.zones[zoneName].npcs["DE_" .. entity.name]

                if de ~= nil then
                    printf("[CU] Attempting liveReload of DE_%s (%s)", entity.name, zoneName)
                    entitySetup(de, entity)

                    local zone = GetZone(cbxi.zone[zoneName])

                    if zone ~= nil then
                        entityRefresh(de, entity, zone)
                    end
                end
            end
        end
    end
end

cbxi.util.reloadOverride = function(mod, str, func)
    mod:addOverride(str, func)

    local path = utils.splitStr(str, ".")

    if
        xi ~= nil and
        xi.zones ~= nil and
        xi.zones[path[3]] ~= nil and                -- Zone_Name
        xi.zones[path[3]][path[4]] ~= nil and       -- Zone_Name.npcs
        xi.zones[path[3]][path[4]][path[5]] ~= nil  -- Zone_Name.npcs.Entity
    then
        xi.zones[path[3]][path[4]][path[5]][path[6]] = func
    end
end

cbxi.util.npcSpawner = function(tbl, npc, spawner, keepSpawner)
    local result = {}
    local before = {}
    local after  = {}

    local npcs = npc

    if type(npc) ~= "table" then
        npcs = { npc }
    end

    if keepSpawner then
        before =
        {
            { noturn  = true },
            { spawn   = npcs },
            { delay   = 500 },
            { entity  = npcs[1], face = "player" },
            { delay   = 500 },
        }

        after =
        {
            { delay   = 500 },
            { despawn = npcs },
        }
    else
        before =
        {
            { despawn = { spawner } },
            { spawn   = npcs },
            { delay   = 500 },
            { entity  = npcs[1], face = "player" },
            { delay   = 500 },
        }

        after =
        {
            { delay   = 500 },
            { despawn = npcs },
            { spawn   = { spawner } },
        }
    end

    for _, line in pairs(before) do
        table.insert(result, line)
    end

    for _, line in pairs(tbl) do
        table.insert(result, line)
    end

    for _, line in pairs(after) do
        table.insert(result, line)
    end

    return result
end

cbxi.util.addSkillEffect = function(mod, skillName, mobName, effect)
    mod:addOverride(fmt("xi.actions.mobskills.{}.onMobWeaponSkill", skillName), function(target, mob, skill)
        local mobName = mob:getPacketName()

        if mobName == mobName then
            if target ~= nil then
                target:addStatusEffect(unpack(effect))
            end
        end

        super(target, mob, skill)
    end)
end

-----------------------------------
-- Ensure Utils
-----------------------------------
local pathWithFilename = io.popen("cd"):read'*all'

cbxi.util.ensureMob = function(zoneName, mobName)
    local filename = pathWithFilename:sub(1, -2) .. string.format("\\scripts\\zones\\%s\\mobs\\%s", zoneName, mobName) .. ".lua"
    local exists = io.open(filename,"r")
    if exists ~= nil then
        io.close(exists)
    else
        xi.module.ensureTable(string.format("xi.zones.%s.mobs.%s", zoneName, mobName))
    end
end

return m
