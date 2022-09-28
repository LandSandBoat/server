require("scripts/globals/msg")

xi = xi or {}

local maxAreas =
{
    -- Temenos
    { Max = 8, Zones = { 37 } },

    -- Apollyon
    { Max = 6, Zones = { 38 } },

    -- Dynamis
    { Max = 1, Zones = { 39, 40, 41, 42, 134, 135, 185, 186, 187, 188, 29, 140 } }, -- riverneb, ghelsba
}

function onBattlefieldHandlerInitialise(zone)
    local id      = zone:getID()
    local default = 3

    for _, battlefield in pairs(maxAreas) do
        for _, zoneid in pairs(battlefield.Zones) do
            if id == zoneid then
                return battlefield.Max
             end
        end
    end

    return default
end

xi.battlefield = {}
xi.battlefield.contents = {}
xi.battlefield.contentsByZone = {}

xi.battlefield.status =
{
    OPEN     = 0,
    LOCKED   = 1,
    WON      = 2,
    LOST     = 3,
}

xi.battlefield.returnCode =
{
    WAIT              = 1,
    CUTSCENE          = 2,
    INCREMENT_REQUEST = 3,
    LOCKED            = 4,
    REQS_NOT_MET      = 5,
    BATTLEFIELD_FULL  = 6
}

xi.battlefield.leaveCode =
{
    EXIT   = 1,
    WON    = 2,
    WARPDC = 3,
    LOST   = 4
}

xi.battlefield.dropChance =
{
    EXTREMELY_LOW  = 2,
    VERY_LOW       = 10,
    LOW            = 30,
    NORMAL         = 50,
    HIGH           = 70,
    VERY_HIGH      = 100,
    EXTREMELY_HIGH = 140,
}

xi.battlefield.id =
{
    SE_APOLLYON = 1293,
}

Battlefield = setmetatable({}, { __index = Container })
Battlefield.__index = Battlefield
Battlefield.__eq = function(m1, m2)
    return m1.id == m2.id
end

function Battlefield:new(zoneId, battlefieldId, menuBit, entryNpc)
    local obj = Container:new(Battlefield.getVarPrefix(battlefieldId))
    setmetatable(obj, self)
    -- Which zone this battlefield exists within
    obj.zoneId = zoneId
    -- Battlefield ID used in the database
    obj.battlefieldId = battlefieldId
    -- The bit used to communicate with the client on which menu item this battlefield is
    obj.menuBit = menuBit
    -- Some battlefields has multiple areas (Burning Circles) while others have fixed areas (Apollyon). Set to have a fixed area.
    obj.area = nil
    -- Monster battlefield groups added with battlefield:addGroups()
    obj.groups = {}
    -- Pathing for monsters and npcs within the battlefield
    obj.paths = {}
    -- Loot spawned in the Armoury Crate(s)
    obj.loot = {}
    -- Items required to be traded to enter the battlefield
    obj.requiredItems = {}
    -- Key items required to be able to enter the battlefield - these are removed upon entry
    obj.requiredKeyItems = {}
    obj.createWornItem = true
    obj.sections = { { [zoneId] = {} } }

    -- If being called from a derived class then this should be handled there as obj wont have the metatable setup properly yet
    if entryNpc then
        obj:setEntryNpc(entryNpc)
    end

    return obj
end

function Battlefield:register()
    xi.battlefield.contents[self.battlefieldId] = self
    if utils.hasKey(self.zoneId, xi.battlefield.contentsByZone) then
        table.insert(xi.battlefield.contentsByZone[self.zoneId], self)
    else
        xi.battlefield.contentsByZone[self.zoneId] = { self }
    end
    return self
end

function Battlefield:checkRequirements(player, npc, registrant, trade)
    if npc:getName() ~= self.entryNpc then
        return false
    end

    for _, keyItem in ipairs(self.requiredKeyItems) do
        if not player:hasKeyItem(keyItem) then
            return false
        end
    end

    if trade and self.requiredItems then
        if not npcUtil.tradeHasExactly(trade, self.requiredItems) then
            return false
        end
    end

    return true
end

function Battlefield:checkSkipCutscene(player)
    return false
end

function Battlefield:setEntryNpc(entryNpc)
    local entry = {
        [entryNpc] =
        {
            onTrade = utils.bind(self.onEntryTrade, self),
            onTrigger = utils.bind(self.onEntryTrigger, self),
        },
        onEventUpdate =
        {
            [32000] = utils.bind(self.onEntryEventUpdate, self),
            [32003] = utils.bind(self.onEntryEventUpdateLeave, self),
        },
        onEventFinish =
        {
            [32000] = utils.bind(self.onEntryEventFinish, self),
            [32002] = utils.bind(self.onEntryEventFinish, self),
            [32003] = utils.bind(self.onEntryEventFinish, self),
        }
    }

    utils.append(self.sections[1][self.zoneId], entry)
    self.entryNpc = entryNpc
end

function Battlefield.getVarPrefix(battlefieldID)
    return string.format("Battlefield[%d]", battlefieldID)
end

function Battlefield:onEntryTrade(player, npc, trade, onUpdate)
    -- Check if player's party has level sync
    if xi.battlefield.rejectLevelSyncedParty(player, npc) then
        return false
    end

    -- Validate trade
    if not trade then
        return false
    end

    if not npcUtil.tradeHasExactly(trade, self.requiredItems) then
        return false
    end

    -- Check if the player is trading exactly one item but it is worn
    if #self.requiredItems == 1 and self.createWornItem and player:hasWornItem(self.requiredItems[1]) then
        player:messageBasic(xi.msg.basic.ITEM_UNABLE_TO_USE_2, 0, 0)
        return false
    end

    -- Validate battlefield status
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) and not onUpdate then
        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0)
        return false
    end

    -- Check if another party member has battlefield status effect. If so, don't allow trade.
    local alliance = player:getAlliance()
    for _, member in pairs(alliance) do
        if member:hasStatusEffect(xi.effect.BATTLEFIELD) then
            player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0)

            return false
        end
    end

    -- Open menu of valid battlefields
    local options = xi.battlefield.getBattlefieldOptions(player, npc, trade)
    if options ~= 0 then
        if not onUpdate then
            player:startEvent(32000, 0, 0, 0, options, 0, 0, 0, 0)
        end

        return true
    end

    return false
end

function Battlefield:onEntryTrigger(player, npc)
    -- Cannot enter if anyone in party is level/master sync'd
    if xi.battlefield.rejectLevelSyncedParty(player, npc) then
        return false
    end

    -- Player has battlefield status effect. That means a battlefield is open OR the player is inside a battlefield.
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        -- Player is inside battlefield. Attempting to leave.
        -- TODO(jmcmorris): We might be able to move this to its own onExitTrigger?
        if player:getBattlefield() then
            player:startOptionalCutscene(32003)
            return true
        end

        -- Player is outside battlefield. Attempting to enter.
        -- TODO(jmcmorris): Is this going to be triggered for each battlefield in the zone?
        local status = player:getStatusEffect(xi.effect.BATTLEFIELD)
        local bfid = status:getPower()
        if self.battlefieldId ~= bfid then
            return false
        end

        if not self.checkRequirements(player, npc, bfid, false) then
            return false
        end

        player:startEvent(32000, 0, 0, 0, self.menuBit, 0, 0, 0, 0)
        return true
    end

    -- Player doesn't have battlefield status effect. That means player wants to register a new battlefield OR is attempting to enter a closed one.
    -- Check if another party member has battlefield status effect. If so, that means the player is trying to enter a closed battlefield.
    local alliance = player:getAlliance()
    for _, member in pairs(alliance) do
        if member:hasStatusEffect(xi.effect.BATTLEFIELD) then
            -- player:messageSpecial() -- You are eligible but cannot enter.
            return false
        end
    end

    -- No one in party/alliance has battlefield status effect. We want to register a new battlefield.
    local options = xi.battlefield.getBattlefieldOptions(player, npc)

    -- GMs get access to all BCNMs (FLAG_GM = 0x04000000)
    if player:getGMLevel() > 0 and player:checkNameFlags(0x04000000) then
        options = 268435455
    end

    -- options = 268435455 -- uncomment to open menu with all possible battlefields
    if options == 0 then
        return false
    end

    player:startEvent(32000, 0, 0, 0, options, 0, 0, 0, 0)
    return true
end

function Battlefield:onEntryEventUpdate(player, csid, option, extras)
    if option == 0 or option == 255 then
        -- todo: check if battlefields full, check party member requiremenst
        return false
    end

    local battlefieldIndex = bit.rshift(option, 4)
    if battlefieldIndex ~= self.menuBit then
        return false
    end

    local clearTime = 1
    local name      = "Meme"
    local partySize = 1

    local area = self.area or (player:getLocalVar("[battlefield]area") + 1)
    if self.area ~= 0 then
        area = self.area
    end

    local result = player:registerBattlefield(self.battlefieldId, area)
    local status = xi.battlefield.status.OPEN

    if result ~= xi.battlefield.returnCode.CUTSCENE then
        if result == xi.battlefield.returnCode.INCREMENT_REQUEST then
            if area < 3 then
                player:setLocalVar("[battlefield]area", area)
            else
                result = xi.battlefield.returnCode.WAIT
                player:updateEvent(result)
            end
        end

        return false
    end

    -- Only allow entrance if battlefield is open and player has battlefield effect, witch can be lost mid battlefield selection.
    if
        not player:getBattlefield() and
        player:hasStatusEffect(xi.effect.BATTLEFIELD)
        -- and id:getStatus() == xi.battlefield.status.OPEN -- TODO: Uncomment only once that can-of-worms is dealt with.
    then
        player:enterBattlefield()
    end

    -- Handle record
    local initiatorId = 0
    local battlefield = player:getBattlefield()

    if battlefield then
        battlefield:setLocalVar("[cs]bit", battlefieldIndex)
        name, clearTime, partySize = battlefield:getRecord()
        initiatorId, _ = battlefield:getInitiator()
    end

    -- Register party members
    if initiatorId == player:getID() then
        local effect = player:getStatusEffect(xi.effect.BATTLEFIELD)
        local zone   = player:getZoneID()

        -- Handle traded items
        if self.requiredItems then
            if self.createWornItem and player:hasItem(self.requiredItems[1]) then
                player:createWornItem(self.requiredItems[1])
            else
                player:tradeComplete()
            end
        end

        -- Handle party/alliance members
        local alliance = player:getAlliance()
        for _, member in pairs(alliance) do
            if
                member:getZoneID() == zone and
                not member:hasStatusEffect(xi.effect.BATTLEFIELD) and
                not member:getBattlefield()
            then
                member:addStatusEffect(effect)
                member:registerBattlefield(self.battlefieldId, area, player:getID())
            end
        end
    end

    player:updateEvent(result, self.menuBit, 0, clearTime, partySize, self:checkSkipCutscene(player))
    player:updateEventString(name)
    return status < xi.battlefield.status.LOCKED and result < xi.battlefield.returnCode.LOCKED
end

function Battlefield:onEntryEventUpdateLeave(player, csid, option, extras)
    if option == 2 then
        player:updateEvent(3)
        return true
    elseif option == 3 then
        player:updateEvent(0)
        return true
    end
    return false
end

function Battlefield:onEntryEventFinish(player, csid, option)
    player:setLocalVar("[battlefield]area", 0)

    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        if csid == 32003 and option == 4 then
            if player:getBattlefield() then
                player:leaveBattlefield(1)
            end
        end

        return true
    end

    return false
end

function Battlefield:onBattlefieldInitialise(battlefield)
    battlefield:setLocalVar("loot", 1)
end

function Battlefield:onBattlefieldTick(battlefield, tick)
    print("Battlefield:onBattlefieldTick")
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

function Battlefield:onBattlefieldRegister(player, battlefield)
end

function Battlefield:onBattlefieldEnter(player, battlefield)
end

function Battlefield:onBattlefieldDestroy(battlefield)
end

function Battlefield:onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function xi.battlefield.getBattlefieldOptions(player, npc, trade)
    local result = 0
    local contents = xi.battlefield.contentsByZone[player:getZoneID()]

    if contents == nil then
        return result
    end

    for _, content in ipairs(contents) do
        if content:checkRequirements(player, npc, true, trade) and not player:battlefieldAtCapacity(content.battlefieldId) then
            result = utils.mask.setBit(result, content.menuBit, true)
        end
    end

    return result
end

xi.battlefield.rejectLevelSyncedParty = function(player, npc)
    for _, member in pairs(player:getAlliance()) do
        if member:isLevelSync() then
            local zoneId = player:getZoneID()
            local ID = zones[zoneId]
            -- Your party is unable to participate because certain members' levels are restricted
            player:messageText(npc, ID.text.MEMBERS_LEVELS_ARE_RESTRICTED, false)
            return true
        end
    end
    return false
end

function xi.battlefield.onBattlefieldTick(battlefield, timeinside)
    local killedallmobs = true
    local leavecode     = -1
    local canLeave      = 0

    local mobs          = battlefield:getMobs(true, false)
    local status        = battlefield:getStatus()
    local players       = battlefield:getPlayers()
    local cutsceneTimer = battlefield:getLocalVar("cutsceneTimer")
    local phaseChange   = battlefield:getLocalVar("phaseChange")

    if status == xi.battlefield.status.LOST then
        leavecode = 4
    elseif status == xi.battlefield.status.WON then
        leavecode = 2
    end

    if leavecode ~= -1 then
        -- Artificially inflate the time we remain inside the battlefield.
        battlefield:setLocalVar("cutsceneTimer", cutsceneTimer + 1)

        canLeave = battlefield:getLocalVar("loot") == 0

        if status == xi.battlefield.status.WON and not canLeave then
            if battlefield:getLocalVar("lootSpawned") == 0 and battlefield:spawnLoot() then
                canLeave = false
            elseif battlefield:getLocalVar("lootSeen") == 1 then
                canLeave = true
            end
        end
    end

    -- Remove battlefield effect for players in alliance not inside battlefield once the battlefield gets locked. Do this only once.
    if status == xi.battlefield.status.LOCKED and battlefield:getLocalVar("statusRemoval") == 0 then
        battlefield:setLocalVar("statusRemoval", 1)

        for _, player in pairs(players) do
            local alliance = player:getAlliance()
            for _, member in pairs(alliance) do
                if member:hasStatusEffect(xi.effect.BATTLEFIELD) and not member:getBattlefield() then
                    member:delStatusEffect(xi.effect.BATTLEFIELD)
                end
            end
        end
    end

    -- Check that players haven't all died or that their dead time is over.
    xi.battlefield.HandleWipe(battlefield, players)

    -- Cleanup battlefield.
    if
        not xi.battlefield.SendTimePrompts(battlefield, players) or -- If we cant send anymore time prompts, they are out of time.
        (canLeave and cutsceneTimer >= 15)                          -- Players won and artificial time inflation is over.
    then
        battlefield:cleanup(true)
    elseif status == xi.battlefield.status.LOST then -- Players lost.
        for _, player in pairs(players) do
            player:messageSpecial(zones[player:getZoneID()].text.PARTY_MEMBERS_HAVE_FALLEN)
        end

        battlefield:cleanup(true)
    end

    -- Check if theres at least 1 mob alive.
    for _, mob in pairs(mobs) do
        if mob:isAlive() then
            killedallmobs = false
            break
        end
    end

    -- Set win status.
    if killedallmobs and phaseChange == 0 then
        battlefield:setStatus(xi.battlefield.status.WON)
    end
end

-- returns false if out of time
function xi.battlefield.SendTimePrompts(battlefield, players)
    -- local tick = battlefield:getTimeInside()
    -- local status = battlefield:getStatus()
    local remainingTime  = battlefield:getRemainingTime()
    local message        = 0
    local lastTimeUpdate = battlefield:getLastTimeUpdate()

    players = players or battlefield:getPlayers()

    if lastTimeUpdate == 0 and remainingTime < 600 then
        message = 600
    elseif lastTimeUpdate == 600 and remainingTime < 300 then
        message = 300
    elseif lastTimeUpdate == 300 and remainingTime < 60 then
        message = 60
    elseif lastTimeUpdate == 60 and remainingTime < 30 then
        message = 30
    elseif lastTimeUpdate == 30 and remainingTime < 10 then
        message = 10
    end

    if message ~= 0 then
        for i, player in pairs(players) do
            player:messageBasic(xi.msg.basic.TIME_LEFT, remainingTime)
        end

        battlefield:setLastTimeUpdate(message)
    end

    return remainingTime >= 0
end

function xi.battlefield.HandleWipe(battlefield, players)
    local rekt     = true
    local wipeTime = battlefield:getWipeTime()
    local elapsed  = battlefield:getTimeInside()

    players = players or battlefield:getPlayers()

    -- If party has not yet wiped.
    if wipeTime <= 0 then
        -- Check if party has wiped.
        for _, player in pairs(players) do
            if player:getHP() ~= 0 then
                rekt = false
                break
            end
        end

        -- Party has wiped. Save and send time remaining before being booted.
        -- TODO: Add LUA Binding to check for BCNM flag - RULES_REMOVE_3MIN = 0x04,
        if rekt then
            if battlefield:getLocalVar("instantKick") == 0 then
                for _, player in pairs(players) do
                    player:messageSpecial(zones[player:getZoneID()].text.THE_PARTY_WILL_BE_REMOVED, 0, 0, 0, 3)
                end

                battlefield:setWipeTime(elapsed)
            else
                battlefield:setStatus(xi.battlefield.status.LOST)
            end
        end

    -- Party has already wiped.
    else
        -- Time is over.
        if (elapsed - wipeTime) > 180 then -- It will take aproximately 20 extra seconds to actually get kicked, but we have already lost.
            battlefield:setStatus(xi.battlefield.status.LOST)

        -- Check for comeback.
        else
            for _, player in pairs(players) do
                if player:getHP() ~= 0 then
                    battlefield:setWipeTime(0)
                    rekt = false
                    break
                end
            end
        end
    end
end

function xi.battlefield.onBattlefieldStatusChange(battlefield, players, status)
end

function xi.battlefield.HandleLootRolls(battlefield, lootTable, players, npc)
    players = players or battlefield:getPlayers()
    if battlefield:getStatus() == xi.battlefield.status.WON and battlefield:getLocalVar("lootSeen") == 0 then
        if npc then
            npc:setAnimation(90)
        end

        for i = 1, #lootTable, 1 do
            local lootGroup = lootTable[i]

            if lootGroup then
                local max = 0

                for _, entry in pairs(lootGroup) do
                    max = max + entry.droprate
                end

                local roll = math.random(max)

                for _, entry in pairs(lootGroup) do
                    max = max - entry.droprate

                    if roll > max then
                        if entry.itemid ~= 0 then
                            if entry.itemid == 65535 then
                                local gil = entry.amount/#players

                                for j = 1, #players, 1 do
                                    players[j]:addGil(gil)
                                    players[j]:messageSpecial(zones[players[1]:getZoneID()].text.GIL_OBTAINED, gil)
                                end

                                break
                            end

                            players[1]:addTreasure(entry.itemid, npc)
                        end

                        break
                    end
                end
            end
        end

        battlefield:setLocalVar("cutsceneTimer", 10)
        battlefield:setLocalVar("lootSeen", 1)
    end
end

function xi.battlefield.ExtendTimeLimit(battlefield, minutes, message, param, players)
    local timeLimit = battlefield:getTimeLimit()
    local extension = minutes * 60
    battlefield:setTimeLimit(timeLimit + extension)

    if message then
        players = players or battlefield:getPlayers()
        for _, player in pairs(players) do
            player:messageBasic(message, param or minutes)
        end
    end
end

function xi.battlefield.HealPlayers(battlefield, players)
    players = players or battlefield:getPlayers()
    for _, player in pairs(players) do
        local recoverHP = player:getMaxHP() - player:getHP()
        local recoverMP = player:getMaxMP() - player:getMP()
        player:addHP(recoverHP)
        player:addMP(recoverMP)
        player:resetRecasts()
        player:messageBasic(xi.msg.basic.RECOVERS_HP_AND_MP, recoverHP, recoverMP)
        player:messageBasic(xi.msg.basic.ALL_ABILITIES_RECHARGED)
    end
end
