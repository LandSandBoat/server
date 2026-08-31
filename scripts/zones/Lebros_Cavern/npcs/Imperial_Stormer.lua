-----------------------------------
-- Area: Lebros Cavern
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Must be kept in sync with the table in Yazuhma.lua
local supplyItems =
{
    { itemId = xi.item.SEAFOOD_STEWPOT,     points = 7, fillsGroup = true },
    { itemId = xi.item.BISON_STEAK,         points = 5 },
    { itemId = xi.item.COEURL_SUB,          points = 4 },
    { itemId = xi.item.BISON_JERKY,         points = 3 },
    { itemId = xi.item.BOWL_OF_PEA_SOUP,    points = 2 },
    { itemId = xi.item.LOAF_OF_WHITE_BREAD, points = 1 },
}

local pointsVar = 'supplyPoints'
local coordinateOffset = 1000
local coordinateScale = 1000
local homeXVar = 'roamHomeX'
local homeYVar = 'roamHomeY'
local homeZVar = 'roamHomeZ'

local function getRoamHome(npc)
    return
    {
        x = npc:getLocalVar(homeXVar) / coordinateScale - coordinateOffset,
        y = npc:getLocalVar(homeYVar) / coordinateScale - coordinateOffset,
        z = npc:getLocalVar(homeZVar) / coordinateScale - coordinateOffset,
    }
end

local function pathToPoint(npc, position)
    local roamMinWait = 5000
    local roamMaxWait = 10000

    npc:pathThrough(
    {
        {
            x = position.x,
            y = position.y,
            z = position.z,
            wait = math.randomInt(roamMinWait, roamMaxWait),
        },
    }, xi.path.flag.PATROL)
end

local function startRoamPath(npc)
    local roamMinDistance = 5
    local roamMaxDistance = 10
    local home = getRoamHome(npc)

    for _ = 1, 12 do
        local distance = math.randomInt(roamMinDistance, roamMaxDistance)
        local angle = math.randomFloat(0, 1) * 2 * math.pi
        local position = GetFurthestValidPosition(npc, distance, angle)

        if position then
            local currentPosition = npc:getPos()
            local traveledX = position.x - currentPosition.x
            local traveledZ = position.z - currentPosition.z
            local homeX = position.x - home.x
            local homeZ = position.z - home.z
            local traveled = math.sqrt(traveledX ^ 2 + traveledZ ^ 2)
            local distanceFromHome = math.sqrt(homeX ^ 2 + homeZ ^ 2)

            if traveled >= roamMinDistance and distanceFromHome <= roamMaxDistance then
                pathToPoint(npc, position)
                return
            end
        end
    end

    pathToPoint(npc, home)
end

-- Groups for stewpot supply, which fills the entire group
local soldierGroups =
{
    { 0, 1 },
    { 2, 3 },
    { 4, 5, 6 },
    { 7, 8, 9 },
    { 10, 11 },
}

local function isFull(npc)
    return npc:getLocalVar(pointsVar) >= 7
end

local function findHeldSupply(player)
    for _, supply in ipairs(supplyItems) do
        if player:hasItem(supply.itemId, xi.inv.TEMPITEMS) then
            return supply
        end
    end

    return nil
end

local function consumeSupplyItem(player, itemId)
    local tempItem = player:findItem(itemId, xi.inv.TEMPITEMS)
    if
        tempItem and
        player:delItemAt(itemId, 1, tempItem:getLocationID(), tempItem:getSlotID())
    then
        return true
    end

    return false
end

local function getGroupOffsets(npc)
    local offset = npc:getID() - ID.npc.IMPERIAL_STORMER

    for _, group in ipairs(soldierGroups) do
        for _, memberOffset in ipairs(group) do
            if memberOffset == offset then
                return group
            end
        end
    end

    return { offset }
end

local function addPoints(npc, instance, points)
    if isFull(npc) then
        return
    end

    npc:setLocalVar(pointsVar, npc:getLocalVar(pointsVar) + points)

    if isFull(npc) then
        instance:setProgress(instance:getProgress() + 1)
    end
end

entity.onTrigger = function(player, npc)
    local instance = player:getInstance()

    if not instance then
        return
    end

    npc:facePlayer(player)

    local heldSupply = findHeldSupply(player)

    if not heldSupply then
        if isFull(npc) then
            player:messageSpecial(ID.text.FULL_BELLY, 0)
            npc:sendEmote(npc, xi.emote.BOW, xi.emoteMode.MOTION, false)
        else
            player:messageSpecial(ID.text.HAVE_YOU_BROUGHT_PROVISIONS, 0)
        end

        return
    end

    if not consumeSupplyItem(player, heldSupply.itemId) then
        return
    end

    player:setVolatileCharVar('lebrosAssignedSupply', 0)

    if isFull(npc) then
        player:messageSpecial(ID.text.CAN_NEVER_HAVE_TOO_MUCH, 0)
        return
    end

    player:messageSpecial(ID.text.THANK_ZAHAK_YOURE_HERE, 0)

    if heldSupply.fillsGroup then
        for _, memberOffset in ipairs(getGroupOffsets(npc)) do
            local member = GetNPCByID(ID.npc.IMPERIAL_STORMER + memberOffset, instance)
            if member then
                addPoints(member, instance, heldSupply.points)
            end
        end
    else
        addPoints(npc, instance, heldSupply.points)
    end
end

entity.onSpawn = function(npc)
    npc:setStatus(xi.status.NORMAL)
    npc:initNpcAi()
    npc:setLocalVar(homeXVar, math.floor((npc:getXPos() + coordinateOffset) * coordinateScale + 0.5))
    npc:setLocalVar(homeYVar, math.floor((npc:getYPos() + coordinateOffset) * coordinateScale + 0.5))
    npc:setLocalVar(homeZVar, math.floor((npc:getZPos() + coordinateOffset) * coordinateScale + 0.5))
    npc:setLocalVar('pauseNPCPathing', 0)
    startRoamPath(npc)
end

entity.onPathComplete = function(npc)
    startRoamPath(npc)
end

return entity
