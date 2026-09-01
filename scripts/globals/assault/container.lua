-----------------------------------
-- Assault Instance Functions
-----------------------------------
xi = xi or {}
xi.assault = xi.assault or {}
xi.assault.contents = xi.assault.contents or {}
xi.assault.contentsByZone = xi.assault.contentsByZone or {}
-----------------------------------

---@class InstanceAssault : TInteractionContainer
---@field id                       integer
---@field assaultID                integer
---@field instanceID               integer
---@field zoneID                   integer
---@field suggestedLevel           integer
---@field loot                     table
---@field releasePos               table
---@field requiredProgress         integer?
---@field afterInstanceRegister    function
---@field onInstanceCreated        function
---@field onInstanceTimeUpdate     function
---@field onInstanceProgressUpdate function
---@field onInstanceComplete       function
---@field onAssaultFail            function
---@field onEventUpdate            function
---@field onEventFinish            function
InstanceAssault         = setmetatable({}, { __index = Container })
InstanceAssault.__index = InstanceAssault

InstanceAssault.__eq = function(self, other)
    return self.id == other.id
end

function InstanceAssault.getVarPrefix(assaultID)
    return string.format('Assault[%d]', assaultID)
end

-- Creates a new InstanceAssault container with the following params:
--  - assaultID:        (required) ID of the assault
--  - instanceID:       (required) ID of the global instance
--  - requiredOrders:   (required) Key item orders needed to enter the assault
--  - zoneID:           (required) ID of the zone
--  - assaultArea:      (required) Area used for assault point currency
--  - suggestedLevel:   (required) Recommended level; determines unappraised item eligibility
--  - entranceParams:   (required) Table of zone-in event parameters
--      - instanceID:   instanceID of the assault
--      - entryEvent:   { csid, ... } args unpacked into player:startEvent() at the Runic Portal
--      - confirmEvent: { csid, option } checked in onEventFinish to confirm zone-in
--      - memberEvent:  { csid, option } args for party members joining the instance
--  - runeOfReleasePos: (optional) { x, y, z, rot } position of the Rune of Release NPC on completion
--  - releasePos:       (optional) { x, z } grid coordinates for the rune-unlocked messageSpecial (A=0)
--  - ancientBoxPos:    (optional) { x, y, z, rot } position of the Ancient Lockbox NPC on completion
--  - requiredProgress: (optional) Progress value at which the instance auto-completes
--  - basePoints:       (optional) Base assault points before bonuses and penalties
--  - mobs:             (optional) { { baseID = id, offset = n } } - spawns mobs from baseID to baseID+offset
--  - npcs:             (optional) Same format as mobs; sets animation to NORMAL on instance creation
--  - wallNPCs:         (optional) { npcID, ... } - NPCs set to OPEN_DOOR animation on instance creation
--  - loot:             (optional) Ancient Lockbox reward table. Omit to use the zone's Ancient_Lockbox.lua.
--      - loot.appraisalReward = { { { itemId, weight }, ... } }       group for unappraised gear
--      - loot.bonusLoot       = { { { itemId, weight }, ... }, ... }  one or more groups for consumables
--      Use xi.item.NONE with a weight for a chance of no drop within a group.
--
-- The following functions can be overridden in individual assault files for custom behavior.
-- Call InstanceAssault.methodName(self, ...) within an override to utilize the default behavior of the functions.
--  - function content:afterInstanceRegister(player)
--  - function content:onInstanceCreated(instance)
--  - function content:onInstanceTimeUpdate(instance, elapsed)
--  - function content:onInstanceProgressUpdate(instance, progress)
--  - function content:onEventUpdate(player, csid, option, npc)
--  - function content:onEventFinish(player, csid, option, npc)
--  - function content:onLockboxOpen(player, npc)
--  - function content:onInstanceComplete(instance)
--  - function content:onAssaultFail(instance)
---@param data table
function InstanceAssault:new(data)
    assert(type(data.assaultID) == 'number',        'InstanceAssault: assaultID (number) is required')
    assert(type(data.instanceID) == 'number',       'InstanceAssault: instanceID (number) is required')
    assert(type(data.zoneID) == 'number',           'InstanceAssault: zoneID (number) is required')
    assert(type(data.suggestedLevel) == 'number',   'InstanceAssault: suggestedLevel (number) is required')
    assert(type(data.entranceParams) == 'table',    'InstanceAssault: entranceParams (table) is required')
    assert(data.assaultArea ~= nil,                 'InstanceAssault: assaultArea is required')
    assert(data.requiredOrders ~= nil,              'InstanceAssault: requiredOrders is required')

    local obj = Container:new(InstanceAssault.getVarPrefix(data.assaultID))
    setmetatable(obj, self)

    for key, value in pairs(data) do
        obj[key] = value
    end

    obj.entranceParams   = obj.entranceParams or {}
    obj.runeOfReleasePos = obj.runeOfReleasePos or {}
    obj.ancientBoxPos    = obj.ancientBoxPos or {}
    obj.releasePos       = obj.releasePos or {}
    obj.loot             = obj.loot or {}
    obj.mobs             = obj.mobs or {}
    obj.npcs             = obj.npcs or {}
    obj.wallNPCs         = obj.wallNPCs or {}

    return obj
end

function InstanceAssault:afterInstanceRegister(player)
    xi.assault.afterInstanceRegistration(player, self)
end

function InstanceAssault:onInstanceCreated(instance)
    xi.assault.onInstanceSetup(instance, self)
end

function InstanceAssault:onInstanceTimeUpdate(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, zones[self.zoneID].text)
end

function InstanceAssault:onInstanceProgressUpdate(instance, progress)
    if
        self.requiredProgress and
        progress >= self.requiredProgress and
        not instance:completed()
    then
        instance:complete()
    end
end

function InstanceAssault:onEventUpdate(player, csid, option, npc)
end

function InstanceAssault:onEventFinish(player, csid, option, npc)
end

function InstanceAssault:onLockboxOpen(player, npc)
    if not self.loot or not self.loot.appraisalReward then
        return
    end

    xi.assault.assaultChestTrigger(player, npc, self.loot.appraisalReward, self.loot.bonusLoot or {})
end

function InstanceAssault:onInstanceComplete(instance)
    local pos = self.releasePos
    xi.assault.onInstanceComplete(instance, pos.x, pos.z)
end

function InstanceAssault:onAssaultFail(instance)
    xi.assault.onInstanceFailure(instance)
end

function InstanceAssault:register()
    local content = self

    -- Add container to global lookup
    xi.assault.contents[content.assaultID]    = content
    xi.assault.contentsByZone[content.zoneID] = xi.assault.contentsByZone[content.zoneID] or {}
    table.insert(xi.assault.contentsByZone[content.zoneID], content)

    -- Create a dynamic instance object
    local instanceObject = {}

    -- Registry and entry requirements
    instanceObject.registryRequirements = function(player)
        return xi.assault.checkRequirements(player, content) and
            player:hasKeyItem(xi.ki.ASSAULT_ARMBAND)
    end

    instanceObject.entryRequirements = function(player)
        return xi.assault.checkRequirements(player, content)
    end

    -- Callback functions
    instanceObject.afterInstanceRegister = function(player)
        content:afterInstanceRegister(player)
    end

    instanceObject.onInstanceCreated = function(instance)
        content:onInstanceCreated(instance)
    end

    instanceObject.onInstanceCreatedCallback = function(player, instance)
        xi.assault.onInstanceCreatedCallback(player, instance, content)
    end

    instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
        content:onInstanceTimeUpdate(instance, elapsed)
    end

    instanceObject.onInstanceFailure = function(instance)
        content:onAssaultFail(instance)
    end

    instanceObject.onInstanceProgressUpdate = function(instance, progress)
        content:onInstanceProgressUpdate(instance, progress)
    end

    instanceObject.onInstanceComplete = function(instance)
        content:onInstanceComplete(instance)
    end

    instanceObject.onEventUpdate = function(player, csid, option, npc)
        content:onEventUpdate(player, csid, option, npc)
    end

    instanceObject.onEventFinish = function(player, csid, option, npc)
        content:onEventFinish(player, csid, option, npc)
    end

    return instanceObject
end

-----------------------------------
-- Entry Prerequisites
-----------------------------------

xi.assault.checkRequirements = function(player, content)
    return player:hasKeyItem(content.requiredOrders) and
        player:getCurrentAssault() == content.assaultID and
        player:getCharVar('assaultEntered') == 0 and
        player:getCharVar('AssaultFailed') == 0 and
        player:getMainLvl() >= 50
end

xi.assault.hasOrders = function(player)
    for _, assaultOrders in pairs(xi.assault.assaultOrders) do
        if player:hasKeyItem(assaultOrders) then
            return true
        end
    end

    return false
end

-----------------------------------
-- Runic Portal Entry Flow
-----------------------------------

-- Search first for eligible assaults. If failed search instead for eligible instances
xi.assault.onRunicTrigger = function(player, npc, zone)
    local chosenAssault
    for _, eligibleAssault in ipairs(xi.assault.contentsByZone[zone] or {}) do
        if
            xi.assault.checkRequirements(player, eligibleAssault) and
            player:hasKeyItem(xi.ki.ASSAULT_ARMBAND)
        then
            chosenAssault = eligibleAssault
            break
        end
    end

    if chosenAssault == nil then
        if not xi.instance.onTrigger(player, npc, zone) then
            player:messageSpecial(zones[player:getZoneID()].text.NOTHING_HAPPENS)
            return
        end
    else
        xi.instance.clearInstance(player)
        player:setLocalVar('INSTANCE_ID', chosenAssault.instanceID)
        player:startEvent(unpack(chosenAssault.entranceParams.entryEvent))
    end
end

xi.assault.onAssaultUpdate = function(player, csid, option, npc)
    local levelCap = xi.assault.levelCapByIndex[bit.band(option, 0x03)]
    local ID       = zones[player:getZoneID()]

    player:setLocalVar('AssaultCap', levelCap)

    if
        player:getGMLevel() == 0 and
        player:getPartySize() < xi.settings.main.ASSAULT_MINIMUM
    then
        player:messageSpecial(ID.text.MEMBER_TOO_FAR - 1, xi.settings.main.ASSAULT_MINIMUM)
        player:instanceEntry(npc, 1)
        return
    elseif player:checkSoloPartyAlliance() == 2 then
        player:messageText(player, ID.text.MEMBER_NO_REQS + 1, false)
        player:instanceEntry(npc, 1)
        return
    end

    xi.instance.onEventUpdate(player, csid, option, npc)
end

xi.assault.onEventFinish = function(player, csid, option, npc)
    local assaultInfo = xi.assault.contents[player:getCurrentAssault()]
    if assaultInfo then
        xi.instance.onEventFinish(player, csid, option, npc, assaultInfo.entranceParams.confirmEvent)
    else
        xi.instance.onEventFinish(player, csid, option, npc)
    end
end

-----------------------------------
-- Instance Creation
-----------------------------------

xi.assault.onInstanceCreatedCallback = function(player, instance, content)
    if not instance then
        local npc = player:getEventTarget()
        player:messageText(player, zones[player:getZoneID()].text.CANNOT_ENTER, false)
        player:instanceEntry(npc, 3)
        return
    end

    instance:setLevelCap(player:getLocalVar('AssaultCap'))
    player:setLocalVar('AssaultCap', 0)
    player:setCharVar('Assault_Armband', 1)
    player:delKeyItem(xi.ki.ASSAULT_ARMBAND)

    if content then
        xi.instance.onInstanceCreatedCallback(player, instance, content.entranceParams)
    end
end

xi.assault.onInstanceSetup = function(instance, content)
    local ID   = zones[content.zoneID]
    local rPos = content.runeOfReleasePos
    local aPos = content.ancientBoxPos

    if rPos and next(rPos) then
        GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(rPos.x, rPos.y, rPos.z, rPos.rot)
    end

    if aPos and next(aPos) then
        GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(aPos.x, aPos.y, aPos.z, aPos.rot)
    end

    for _, group in pairs(content.mobs) do
        for mobID = group.baseID, group.baseID + group.offset, 1 do
            SpawnMob(mobID, instance)
        end
    end

    for _, group in pairs(content.npcs) do
        for npcID = group.baseID, group.baseID + group.offset, 1 do
            GetNPCByID(npcID, instance):setAnimation(xi.status.NORMAL)
        end
    end

    for _, npcID in ipairs(content.wallNPCs) do
        GetNPCByID(npcID, instance):setAnimation(xi.animation.OPEN_DOOR)
    end

    if content.loot and content.loot.appraisalReward then
        local lockboxNPC = GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance)
        if lockboxNPC then
            lockboxNPC:addListener('ON_TRIGGER', 'LOCKBOX_TRIGGER', xi.assault.onLockboxTrigger)
        end
    end
end

-- Runs once for each player as they enter
xi.assault.afterInstanceRegistration = function(player, content)
    local instance  = player:getInstance()
    local assaultID = content.assaultID
    local ID        = zones[content.zoneID]

    player:setCharVar('assaultEntered', assaultID)
    player:messageSpecial(ID.text.ASSAULT_START_OFFSET + assaultID, assaultID)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit() / 60)

    local areaData = xi.assault.areaData[content.assaultArea]
    if areaData and areaData.firefly then
        -- Only add firefly if there's no entry event that will give it to prevent double items in inv.
        if not content.entranceParams or not content.entranceParams.entryEvent then
            player:addTempItem(areaData.firefly)
        end
    end
end

xi.assault.adjustMobLevel = function(mob)
    local instance     = mob:getInstance()
    local levelCap     = instance:getLevelCap()
    local reducedLevel = 75 - levelCap

    if levelCap ~= 0 then
        mob:setMobLevel(mob:getMainLvl() - reducedLevel)
    end
end

-----------------------------------
-- Completion / Failure
-----------------------------------

xi.assault.onInstanceComplete = function(instance, posX, posZ)
    local chars = instance:getChars()
    local ID    = zones[instance:getZone():getID()]

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setStatus(xi.status.NORMAL)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setStatus(xi.status.NORMAL)

    for _, entity in pairs(chars) do
        entity:messageSpecial(ID.text.RUNE_UNLOCKED_POS, posX, posZ)
    end
end

xi.assault.onInstanceFailure = function(instance)
    local chars     = instance:getChars()
    local mobs      = instance:getMobs()
    local zoneID    = instance:getZone():getID()
    local _, player = next(chars)
    if not player then
        return
    end

    local assaultID = player:getCurrentAssault()
    local area      = xi.assault.missionToArea[assaultID]

    for _, entity in pairs(mobs) do
        DespawnMob(entity:getID(), instance)
    end

    for _, entity in pairs(chars) do
        if area then
            entity:addAssaultPoint(area, 100)
            entity:messageSpecial(zones[zoneID].text.ASSAULT_POINTS_OBTAINED, 100)
        end

        entity:messageSpecial(zones[zoneID].text.MISSION_FAILED, 10, 10)
        entity:setCharVar('assaultEntered', 0)
        entity:setCharVar('AssaultFailed', 1)
        entity:startEvent(102)
    end
end

local function awardCompletionPoints(player, instance)
    if not instance then
        return
    end

    local assaultID  = player:getCurrentAssault()
    local content    = xi.assault.contents[assaultID]
    local basePoints = content and content.basePoints
    if not basePoints then
        return
    end

    local chars               = instance:getChars()
    local playerPointMod      = math.max((#chars - 3) * 0.1, 0)
    local basePointsForMember = basePoints - (basePoints * playerPointMod) -- Base points before per-member bonuses
    local pointsArea          = xi.assault.missionToArea[assaultID]
    local zoneText            = zones[instance:getZone():getID()].text

    for _, member in pairs(chars) do
        if member:getLocalVar('AssaultPointsAwarded') == 0 then
            member:setLocalVar('AssaultPointsAwarded', 1)

            local points         = basePointsForMember
            local promotionBonus = 1

            -- Leader Bonus
            if member:getCharVar('Assault_Armband') == 1 then
                points = points * 1.1
            end

            -- First time completion bonus
            if not member:hasCompletedAssault(assaultID) then
                promotionBonus = 5
                points         = points * 1.5
            end

            if pointsArea then
                member:addAssaultPoint(pointsArea, math.floor(points))
                member:messageSpecial(zoneText.ASSAULT_POINTS_OBTAINED, math.floor(points))
            end

            member:setVar('AssaultPromotion', member:getCharVar('AssaultPromotion') + promotionBonus)
            member:setVar('AssaultComplete', 1)

            member:setCharVar('assaultEntered', 0)
            member:setCharVar('Assault_Armband', 0)
            member:startEvent(102)
        end
    end

    -- Cleanup remaining mobs
    for _, mob in pairs(instance:getMobs()) do
        DespawnMob(mob:getID(), instance)
    end
end

local function exitToZone(player, exitZone)
    local instance = player:getInstance()
    if not instance then
        return
    end

    local chars = instance:getChars()
    for _, entity in pairs(chars) do
        entity:setPos(0, 0, 0, 0, exitZone)
    end
end

xi.assault.instanceOnEventFinish = function(player, csid, exitZone)
    if csid == 102 then
        exitToZone(player, exitZone)
    end
end

xi.assault.runeReleaseFinish = function(player, csid, option, npc, exitZone)
    if csid == 100 and option == 1 then
        awardCompletionPoints(player, player:getInstance())
    elseif csid == 102 and exitZone then
        exitToZone(player, exitZone)
    end
end

xi.assault.InstanceAssault = InstanceAssault
