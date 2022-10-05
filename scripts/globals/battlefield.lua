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
    FLAMES_FOR_THE_DEAD = 640,
    BROTHERS = 643,
    HOLY_COW = 644,
    SHADOW_LORD_BATTLE = 160,
    WHERE_TWO_PATHS_CONVERGE = 161,
    SE_APOLLYON = 1293,
}

Battlefield = setmetatable({}, { __index = Container })
Battlefield.__index = Battlefield
Battlefield.__eq = function(m1, m2)
    return m1.id == m2.id
end

-- Creates a new Battlefield interaction
-- Data takes the following keys:
--  - zoneId: Which zone this battlefield exists within (required)
--  - battlefieldId: Battlefield ID used in the database (required)
--  - maxPlayers: Maximum number of players allowed to enter (required)
--  - timeLimit: Time in seconds alotted to complete the battlefield before being ejected. (required)
--  - index: The index of the battlefield within the zone. This is used to communicate with the client on which menu item this battlefield is. (required)
--  - levelCap: Level cap imposed upon the battlefield. Defaults to 0 - no level cap. (optional)
--  - area: Some battlefields has multiple areas (Burning Circles) while others have fixed areas (Apollyon). Set to have a fixed area. (optional)
--  - entryNpc: The name of the NPC used for entering (required)
--  - exitNpc: The name of the NPC used for exiting
--  - allowSubjob: Determines if character subjobs are enabled or disabled upon entry. Defaults to true. (optional)
--  - hasWipeGrace: Grants players a 3 minute grace period on a full wipe before ejecting them. Defaults to true. (optional)
--  - canLoseExp: Determines if a character loses experience points upon death while inside the battlefield. Defaults to true. (optional)
--  - delayToExit: Amount of time to wait before exiting the battlefield. Defaults to 5 seconds. (optional)
--  - requiredItems: Items required to be traded to enter the battlefield.
--                   Needs to be in the format of { itemid, quantity, useMessage = ID.text.*, wearMessage = ID.text.*, wornMessage = ID.text.* }. (optional)
--  - requiredKeyItems: Key items required to be able to enter the battlefield - these are removed upon entry (optional)
--  - title: Title given to players upon victory (optional)
--  - grantXP: Amount of XP to grant upon victory (optional)
--  - lossEventParams: Parameters given to the loss event (32002). Defaults to none. (optional)
function Battlefield:new(data)
    local obj = Container:new(Battlefield.getVarPrefix(data.battlefieldId))
    setmetatable(obj, self)
    obj.zoneId = data.zoneId
    obj.battlefieldId = data.battlefieldId
    obj.maxPlayers = data.maxPlayers
    obj.timeLimit = data.timeLimit
    obj.index = data.index
    obj.entryNpc = data.entryNpc

    obj.area = data.area
    obj.exitNpc = data.exitNpc
    obj.title = data.title
    obj.grantXP = data.grantXP
    obj.levelCap = data.levelCap or 0
    obj.allowSubjob = (data.allowSubjob == nil or data.allowSubjob) or false
    obj.hasWipeGrace = (data.hasWipeGrace == nil or data.hasWipeGrace) or false
    obj.canLoseExp = (data.canLoseExp == nil or data.canLoseExp) or false
    obj.delayToExit = data.delayToExit or 5
    obj.requiredItems = data.requiredItems or {}
    obj.requiredKeyItems = data.requiredKeyItems or {}
    obj.lossEventParams = data.lossEventParams or {}

    obj.sections = { { [obj.zoneId] = {} } }
    obj.groups = {}
    obj.paths = {}
    obj.loot = {}

    return obj
end

function Battlefield.getVarPrefix(battlefieldID)
    return string.format("Battlefield[%d]", battlefieldID)
end

function Battlefield:register()
    -- Only hookup the entry and exit listeners if there aren't any other battlefields already registered for that entrance
    local setupEvents = true
    local setupEntryNpc = true
    local setupExitNpc = true
    if utils.hasKey(self.zoneId, xi.battlefield.contentsByZone) then
        local contents = xi.battlefield.contentsByZone[self.zoneId]
        for _, content in ipairs(contents) do
            -- Always setup listeners if we're reloading a battlefield
            if self.battlefieldId == content.battlefieldId and content.hasListeners then
                setupEvents = true
                setupEntryNpc = true
                setupExitNpc = true
                break
            end

            -- Do not setup events if there are any other battlefields
            setupEvents = false

            -- Do not setup npcs if there is another battlefield using the same entry npc
            if self.entryNpc == content.entryNpc then
                setupEntryNpc = false
            end
            if self.exitNpc == content.exitNpc then
                setupExitNpc = false
            end
        end
    end

    local zoneSection = self.sections[1][self.zoneId]
    if setupEvents then
        utils.append(zoneSection, {
            onEventUpdate =
            {
                [32000] = Battlefield.redirectEventUpdate,
                [32003] = utils.bind(Battlefield.redirectEventCall, "onExitEventUpdate"),
            },

            onEventFinish =
            {
                [32000] = utils.bind(Battlefield.redirectEventCall, "onEventFinishEnter"),
                [32001] = utils.bind(Battlefield.redirectEventCall, "onEventFinishWin"),
                [32002] = utils.bind(Battlefield.redirectEventCall, "onEventFinishLeave"),
                [32003] = utils.bind(Battlefield.redirectEventCall, "onEventFinishExit"),
                [32004] = utils.bind(Battlefield.redirectEventCall, "onEventFinishBattlefield"),
            }
        })
        self.hasListeners = true
    end

    if setupEntryNpc and self.entryNpc then
        utils.append(zoneSection, {
            [self.entryNpc] =
            {
                onTrade = Battlefield.onEntryTrade,
                onTrigger = Battlefield.onEntryTrigger,
            }
        })
    end

    if setupExitNpc and self.exitNpc then
        utils.append(zoneSection, {
            [self.exitNpc] =
            {
                onTrigger = Battlefield.onExitTrigger,
            }
        })
    end

    xi.battlefield.contents[self.battlefieldId] = self
    if utils.hasKey(self.zoneId, xi.battlefield.contentsByZone) then
        table.insert(xi.battlefield.contentsByZone[self.zoneId], self)
    else
        xi.battlefield.contentsByZone[self.zoneId] = { self }
    end
    return self
end

function Battlefield:checkRequirements(player, npc, registrant, trade)
    if self.entryNpc ~= npc:getName() then
        return false
    end

    for _, keyItem in ipairs(self.requiredKeyItems) do
        if not player:hasKeyItem(keyItem) then
            return false
        end
    end

    if trade and #self.requiredItems > 0 then
        if not npcUtil.tradeHasExactly(trade, self.requiredItems) then
            return false
        end
    end

    return true
end

function Battlefield:checkSkipCutscene(player)
    return false
end

function Battlefield.onEntryTrade(player, npc, trade, onUpdate)
    -- Check if player's party has level sync
    if xi.battlefield.rejectLevelSyncedParty(player, npc) then
        return false
    end

    -- Validate trade
    if not trade then
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

    local zoneId = player:getZoneID()

    -- Determine which battlefields are available given the traded items
    local options = xi.battlefield.getBattlefieldOptions(player, npc, trade)
    if options == 0 then
        local noEntryMessage = zones[zoneId].text.NO_BATTLEFIELD_ENTRY
        if noEntryMessage then
            player:messageSpecial(noEntryMessage)
        end
        return false
    end

    -- Ensure that the traded item(s) are not worn out
    local contents = xi.battlefield.contentsByZone[zoneId]
    for _, content in ipairs(contents) do
        if
            #content.requiredItems > 0 and
            content.requiredItems[1].wornMessage and
            player:hasWornItem(content.requiredItems[1])
        then
            player:messageBasic(content.requiredItems[1].wornMessage)
            return false
        end
    end

    if not onUpdate then
        -- Open menu of valid battlefields
        player:startEvent(32000, 0, 0, 0, options, 0, 0, 0, 0)
    end

    return true
end

function Battlefield.onEntryTrigger(player, npc)
    -- Cannot enter if anyone in party is level/master sync'd
    if xi.battlefield.rejectLevelSyncedParty(player, npc) then
        return false
    end

    -- Player has battlefield status effect. That means a battlefield is open OR the player is inside a battlefield.
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        -- Player is outside battlefield. Attempting to enter.
        local status = player:getStatusEffect(xi.effect.BATTLEFIELD)
        local id = status:getPower()

        local content = xi.battlefield.contents[id]
        if not content then
            return false
        end

        if not content:checkRequirements(player, npc, content.id, false) then
            return false
        end

        player:startEvent(32000, 0, 0, 0, content.index, 0, 0, 0, 0)
        return true
    end

    -- Player doesn't have battlefield status effect. That means player wants to register a new battlefield OR is attempting to enter a closed one.
    -- Check if another party member has battlefield status effect. If so, that means the player is trying to enter a closed battlefield.
    local alliance = player:getAlliance()
    for _, member in pairs(alliance) do
        if member:hasStatusEffect(xi.effect.BATTLEFIELD) then
            player:messageSpecial(zones[player:getZoneID()].text.PARTY_MEMBERS_ARE_ENGAGED)
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
        local noEntryMessage = zones[player:getZoneID()].text.NO_BATTLEFIELD_ENTRY
        if noEntryMessage then
            player:messageSpecial(noEntryMessage)
        end
        return false
    end

    player:startEvent(32000, 0, 0, 0, options, 0, 0, 0, 0)
    return true
end

-- Static function to lookup the correct battlefield to handle this event update
function Battlefield.redirectEventUpdate(player, csid, option, extras)
    if option == 0 or option == 255 then
        return false
    end

    local contents = xi.battlefield.contentsByZone[player:getZoneID()]
    local value = bit.rshift(option, 4)
    for _, content in pairs(contents) do
        if value == content.index then
            content:onEntryEventUpdate(player, csid, option, extras)
            break
        end
    end
end

function Battlefield:onEntryEventUpdate(player, csid, option, extras)
    local clearTime = 1
    local name      = "Meme"
    local partySize = 1

    local area = self.area or (player:getLocalVar("[battlefield]area") + 1)
    if self.area then
        area = self.area
    end

    local result = player:registerBattlefield(self.battlefieldId, area, player:getID(), self)
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
        name, clearTime, partySize = battlefield:getRecord()
        initiatorId, _ = battlefield:getInitiator()
    end

    -- Register party members
    if initiatorId == player:getID() then
        local effect = player:getStatusEffect(xi.effect.BATTLEFIELD)
        local zone   = player:getZoneID()

        -- Handle traded items
        for _, item in ipairs(self.requiredItems) do
            if item.wearMessage and player:hasItem(item[1]) then
                player:createWornItem(item[1])
                player:messageSpecial(item.wearMessage, item[1])
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
                member:registerBattlefield(self.battlefieldId, area, player:getID(), self)
            end
        end
    end

    player:updateEvent(result, self.index, 0, clearTime, partySize, self:checkSkipCutscene(player))
    player:updateEventString(name)
    return status < xi.battlefield.status.LOCKED and result < xi.battlefield.returnCode.LOCKED
end

function Battlefield.redirectEventCall(eventName, player, csid, option)
    local battlefield = player:getBattlefield()
    if not battlefield then
        return
    end

    local content = xi.battlefield.contents[battlefield:getID()]
    content[eventName](content, player, csid, option)
end

function Battlefield:onEventFinishEnter(player, csid, option)
    player:setLocalVar("[battlefield]area", 0)
end

function Battlefield:onEventFinishWin(player, csid, option)
    if self.title then
        player:addTitle(self.title)
    end
    if self.grantXP then
        player:addExp(self.grantXP)
    end
end

function Battlefield.onExitTrigger(player, npc)
    if player:getBattlefield() then
        player:startOptionalCutscene(32003)
    end
end

function Battlefield:onExitEventUpdate(player, csid, option, npc)
    if option == 2 then
        player:updateEvent(3)
    elseif option == 3 then
        player:updateEvent(0)
    end
end

function Battlefield:onEventFinishLeave(player, csid, option)
    player:leaveBattlefield(1)
end

function Battlefield:onEventFinishExit(player, csid, option)
    if option == 4 and player:getBattlefield() then
        player:leaveBattlefield(1)
    end
end

function Battlefield:onEventFinishBattlefield(player, csid, option)
end

function Battlefield:onBattlefieldInitialise(battlefield)
    if #self.loot > 0 then
        battlefield:setLocalVar("loot", 1)
    end

    local hasMultipleAreas = not self.area
    battlefield:addGroups(self.groups, hasMultipleAreas)

    for mobId, path in pairs(self.paths) do
        GetMobByID(mobId):pathThrough(path, xi.path.flag.PATROL)
    end
end

function Battlefield:onBattlefieldTick(battlefield, tick)
    local status        = battlefield:getStatus()
    local cutsceneTimer = battlefield:getLocalVar("cutsceneTimer")
    local isExiting = status == xi.battlefield.status.LOST or status == xi.battlefield.status.WON

    if isExiting then
        battlefield:setLocalVar("cutsceneTimer", cutsceneTimer - 1)
    end

    -- Check that players haven't all died or that their dead time is over.
    local players = battlefield:getPlayers()
    self:handleWipe(battlefield, players)

    local hasTimeRemaining = xi.battlefield.SendTimePrompts(battlefield, players)
    if not hasTimeRemaining then
        for _, player in pairs(players) do
            player:messageSpecial(zones[player:getZoneID()].text.TIME_IN_THE_BATTLEFIELD_IS_UP)
        end
        battlefield:setStatus(xi.battlefield.status.LOST)
        isExiting = true
    end

    if isExiting then
        -- Remaining in battlefield for an extended time
        if cutsceneTimer > 0 then
            return
        end

        if status == xi.battlefield.status.LOST then
            for _, player in pairs(players) do
                player:messageSpecial(zones[player:getZoneID()].text.PARTY_MEMBERS_HAVE_FALLEN)
            end
        end

        battlefield:cleanup(true)
    end
end

function Battlefield:onBattlefieldRegister(player, battlefield)
end

function Battlefield:onBattlefieldStatusChange(battlefield, players, status)
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
end

function Battlefield:onBattlefieldEnter(player, battlefield)
    local initiatorId, _ = battlefield:getInitiator()
    if player:getID() == initiatorId then
        if #self.requiredKeyItems > 0 then
            for _, item in ipairs(self.requiredKeyItems) do
                player:delKeyItem(item)
            end
            if self.requiredKeyItems.message ~= 0 then
                player:messageSpecial(self.requiredKeyItems.message, unpack(self.requiredKeyItems))
            end
        end

        for _, item in ipairs(self.requiredItems) do
            if item.message ~= 0 then
                player:messageSpecial(item.message, 0, 0, 0, item[0])
            end
        end
    end

    local ID = zones[self.zoneId]
    player:messageSpecial(ID.text.ENTERING_THE_BATTLEFIELD_FOR, 0, self.index)
    if self.maxPlayers > 6 then
        player:messageSpecial(ID.text.MEMBERS_OF_YOUR_ALLIANCE, 0, 0, 0, self.maxPlayers)
    else
        player:messageSpecial(ID.text.MEMBERS_OF_YOUR_PARTY, 0, 0, 0, self.maxPlayers)
    end

    player:messageSpecial(ID.text.TIME_LIMIT_FOR_THIS_BATTLE_IS, 0, 0, 0, math.floor(self.timeLimit / 60))
end

function Battlefield:onBattlefieldDestroy(battlefield)
end

function Battlefield:onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        self:onBattlefieldWin(player, battlefield)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        self:onBattlefieldLoss(player, battlefield)
    end
end

function Battlefield:onBattlefieldWin(player, battlefield)
    local _, clearTime, partySize = battlefield:getRecord()
    player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, self.index, 0)
end

function Battlefield:onBattlefieldLoss(player, battlefield)
    player:startEvent(32002, self.lossEventParams)
end

function Battlefield:handleWipe(battlefield, players)
    local wipeTime = battlefield:getWipeTime()
    local elapsed  = battlefield:getTimeInside()

    players = players or battlefield:getPlayers()

    -- If party has not yet wiped.
    if wipeTime <= 0 then
        -- Return if any players are still alive
        for _, player in pairs(players) do
            if player:isAlive() then
                return
            end
        end

        -- Party has wiped. Save and send time remaining before being booted.
        if self.hasWipeGrace then
            for _, player in pairs(players) do
                player:messageSpecial(zones[player:getZoneID()].text.THE_PARTY_WILL_BE_REMOVED, 0, 0, 0, 3)
            end

            battlefield:setWipeTime(elapsed)
        else
            battlefield:setStatus(xi.battlefield.status.LOST)
        end

    -- Party has already wiped.
    else
        if (elapsed - wipeTime) > utils.minutes(3) then
            battlefield:setStatus(xi.battlefield.status.LOST)
        else
            -- Cancel the wipe timer if any players are alive once again
            for _, player in pairs(players) do
                if player:isAlive() then
                    battlefield:setWipeTime(0)
                    break
                end
            end
        end
    end
end

function Battlefield:addEssentialMobs(mobNames)
    table.insert(self.groups,{
        mobs = mobNames,
        superlink = true,
        allDeath = utils.bind(self.handleAllMonstersDefeated, self),
    })
end

function Battlefield:handleAllMonstersDefeated(battlefield, mob)
    local crateId = battlefield:getArmouryCrate()
    if crateId ~= 0 then
        local crate = GetNPCByID(crateId)
        npcUtil.showCrate(crate)
        crate:addListener("ON_TRIGGER", "TRIGGER_CRATE", utils.bind(self.handleOpenArmouryCrate, self))
    else
        battlefield:setLocalVar("cutsceneTimer", self.delayToExit)
        battlefield:setStatus(xi.battlefield.status.WON)
    end
end

function Battlefield:handleOpenArmouryCrate(player, npc)
    npcUtil.openCrate(npc, function()
        local battlefield = player:getBattlefield()
        self:handleLootRolls(battlefield, self.loot, npc)
        battlefield:setStatus(xi.battlefield.status.WON)
        battlefield:setLocalVar("cutsceneTimer", self.delayToExit)
        return true
    end)
end

function Battlefield:handleLootRolls(battlefield, lootTable, npc)
    local players = battlefield:getPlayers()
    for i = 1, #lootTable, 1 do
        local lootGroup = lootTable[i]

        if lootGroup then
            local max = 0

            for _, entry in pairs(lootGroup) do
                if type(entry) == 'table' then
                    max = max + entry.droprate
                end
            end

            local quantity = lootGroup.quantity or 1
            for j = 1, quantity do
                local roll = math.random(max)

                local current = 0
                for _, entry in pairs(lootGroup) do
                    if type(entry) == 'table' then
                        current = current + entry.droprate

                        if current > roll then
                            if entry.itemid == 0 then
                                break
                            end

                            if entry.itemid == 65535 then
                                local gil = entry.amount/#players

                                for k = 1, #players, 1 do
                                    players[k]:addGil(gil)
                                    players[k]:messageSpecial(zones[players[1]:getZoneID()].text.GIL_OBTAINED, gil)
                                end

                                break
                            end

                            players[1]:addTreasure(entry.itemid, npc)
                            break
                        end
                    end
                end
            end
        end
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
            result = utils.mask.setBit(result, content.index, true)
        end
    end

    return result
end

function xi.battlefield.rejectLevelSyncedParty(player, npc)
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

BattlefieldMission = setmetatable({ }, { __index = Battlefield })
BattlefieldMission.__index = BattlefieldMission
BattlefieldMission.__eq = function(m1, m2)
    return m1.name == m2.name
end

BattlefieldMission.isMission = true

-- Creates a new Limbus Battlefield interaction
-- Data takes the additional following keys:
--  - missionArea: The mission area this battlefield is associated with (optional)
--  - mission: The mission this battlefield is associated with (optional)
--  - missionStatusArea: The mission area to retrieve the mission status from. Will default to using the player's nation (optional)
--  - missionStatus: The optional extra status information xi.mission.status (optional)
--  - requiredMissionStatus: The required mission status to enter
--  - skipMissionStatus: The required mission status to skip the cutscene. Defaults to the required mission status.
--  - canLoseExp: Determines if a character loses experience points upon death while inside the battlefield. Defaults to false. (optional)
function BattlefieldMission:new(data)
    local obj = Battlefield:new(data)
    setmetatable(obj, self)
    obj.missionArea = data.missionArea
    obj.mission = data.mission
    obj.missionStatusArea = data.missionStatusArea
    obj.missionStatus = data.missionStatus
    obj.requiredMissionStatus = data.requiredMissionStatus
    obj.skipMissionStatus = data.skipMissionStatus or data.requiredMissionStatus
    obj.canLoseExp = data.canLoseExp or false
    return obj
end

function BattlefieldMission:checkRequirements(player, npc, registrant, trade)
    Battlefield.checkRequirements(self, player, npc, registrant, trade)
    local missionArea = self.missionArea or player:getNation()
    local current = player:getCurrentMission(missionArea)
    local missionStatusArea = self.missionStatusArea or player:getNation()
    local status = player:getMissionStatus(missionStatusArea)
    return current == self.mission and status == self.requiredMissionStatus
end

function BattlefieldMission:checkSkipCutscene(player)
    local missionArea = self.missionArea or player:getNation()
    local current = player:getCurrentMission(missionArea)
    local missionStatusArea = self.missionStatusArea or player:getNation()
    local status = player:getMissionStatus(missionStatusArea, self.missionStatus)
    return player:hasCompletedMission(missionArea, self.mission) or
        (current == self.mission and status > self.skipMissionStatus)
end

function BattlefieldMission:onBattlefieldWin(player, battlefield)
    local current = player:getCurrentMission(self.missionArea)
    if current == self.mission then
        player:setLocalVar("battlefieldWin", battlefield:getID())
    end

    local _, clearTime, partySize = battlefield:getRecord()
    local canSkipCS = (current ~= self.mission) and 1 or 0
    player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, self.index, canSkipCS)
end

function BattlefieldMission:onEventFinishWin(player, csid, option)
    if self.title then
        player:addTitle(self.title)
    end

    -- Only grant mission XP once per JP midnight
    if self.grantXP and self:getVar(player, "XP") <= os.time() then
        self:setVar(player, "XP", getMidnight())
        player:addExp(self.grantXP)
    end
end

function xi.battlefield.onBattlefieldTick(battlefield, timeinside)
    local killedallmobs = true
    local leavecode     = -1
    local canLeave      = false

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
    local remainingTime  = battlefield:getRemainingTime()
    local lastTimeUpdate = battlefield:getLastTimeUpdate()
    local timeLimit      = battlefield:getTimeLimit()
    local message        = 0

    players = players or battlefield:getPlayers()

    if remainingTime < 600 and lastTimeUpdate > 600 and timeLimit > 600 then
        message = 600
    elseif remainingTime < 300 and lastTimeUpdate > 300 and timeLimit > 300 then
        message = 300
    elseif remainingTime < 60 and lastTimeUpdate > 60 and timeLimit > 60 then
        message = 60
    elseif remainingTime < 30 and lastTimeUpdate > 30 and timeLimit > 30 then
        message = 30
    elseif remainingTime < 10 and lastTimeUpdate > 10 and timeLimit > 10 then
        message = 10
    end

    if message ~= 0 then
        for i, player in pairs(players) do
            player:messageBasic(xi.msg.basic.TIME_LEFT, message)
        end

        battlefield:setLastTimeUpdate(message)
    end

    return remainingTime > 0
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

-- TODO(jmcmorris): This is no longer needed once Limbus uses the new Battlefield system
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
