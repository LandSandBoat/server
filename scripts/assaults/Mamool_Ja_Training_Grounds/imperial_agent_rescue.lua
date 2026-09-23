-----------------------------------
-- Assault: Imperial Agent Rescue
-- Instance 6600
-- Objective: Rescue the agent
-- TODO: Gates should be untargetable.
-----------------------------------
local ID = zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS]
-----------------------------------

local content = InstanceAssault:new(
{
    zoneID           = xi.zone.MAMOOL_JA_TRAINING_GROUNDS,
    assaultID        = xi.assault.mission.IMPERIAL_AGENT_RESCUE,
    instanceID       = xi.assault.instance.IMPERIAL_AGENT_RESCUE,
    assaultArea      = xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS,
    requiredOrders   = xi.keyItem.MAMOOL_JA_ASSAULT_ORDERS,

    runeOfReleasePos = { x = 220.000, y = 1.465, z = -504.999, rot = 0 },
    ancientBoxPos    = { x = 220.000, y = 1.619, z = -502.999, rot = 0 },
    releasePos       = { x = 9, z = 8 },

    suggestedLevel   = 60,
    basePoints       = 1100,
    requiredProgress = 1,

    entranceParams   =
    {
        instanceID   = xi.assault.instance.IMPERIAL_AGENT_RESCUE,
        entryEvent   = { 505, 11, -4, 0, 60, 0, 1 },
        confirmEvent = { 505, 4 },
        memberEvent  = { 511, 0 },
    },
})

content.loot =
{
    appraisalReward =
    {
        {
            { itemId = xi.item.UNAPPRAISED_RING, weight =  7000 },
            { itemId = xi.item.UNAPPRAISED_BOX,  weight =  3000 },
        },
    },

    bonusLoot =
    {
        {
            { itemId = xi.item.HI_POTION_P2,     weight = 10000 },
        },

        {
            { itemId = xi.item.HI_POTION_TANK,   weight =  5000 },
            { itemId = xi.item.NONE,             weight =  5000 },
        },
    },
}

local agentRooms =
{
    { hatch = ID.npc._JUL, x = 183.865, y =  0.682, z = -583.247, rot = 187 },
    { hatch = ID.npc._JUM, x = 268.967, y =  0.884, z = -582.156, rot = 124 },
    { hatch = ID.npc._JUN, x = 219.108, y = -0.174, z = -414.769, rot =  11 },
}

function content:onInstanceCreated(instance)
    InstanceAssault.onInstanceCreated(self, instance)

    for mobID = ID.mob.MAMOOL_JA_WARDER_WHM, ID.mob.DILAPIDATED_GATE + 2 do
        if not GetMobByID(mobID, instance):getMaster() then
            SpawnMob(mobID, instance)
        end
    end

    local chosenRoom = agentRooms[math.randomInt(1, #agentRooms)]
    local brujeel    = GetNPCByID(ID.npc.BRUJEEL, instance)

    if not brujeel then
        return
    end

    instance:setLocalVar('brujeelHatch', chosenRoom.hatch)
    brujeel:setPos(chosenRoom.x, chosenRoom.y, chosenRoom.z, chosenRoom.rot)
    brujeel:setStatus(xi.status.DISAPPEAR)
end

content.onHatchTrigger = function(player, npc)
    local instance = npc:getInstance()

    npc:setAnimation(xi.animation.OPEN_DOOR)
    npc:setUntargetable(true)

    if npc:getID() ~= instance:getLocalVar('brujeelHatch') then
        return
    end

    instance:setLocalVar('brujeelHatch', 0)

    local brujeel = GetNPCByID(ID.npc.BRUJEEL, instance)

    if not brujeel then
        return
    end

    brujeel:entityAnimationPacket(xi.animationString.STATUS_VISIBLE)

    brujeel:timer(2000, function(brujeelArg)
        brujeelArg:setStatus(xi.status.NORMAL)
    end)

    brujeel:timer(7000, function(brujeelArg)
        brujeelArg:messageText(brujeelArg, ID.text.BRUJEEL_TEXT)
    end)

    brujeel:timer(8000, function(brujeelArg)
        brujeelArg:setAnimation(xi.animation.NONE)
    end)

    brujeel:timer(10000, function(brujeelArg)
        brujeelArg:messageText(brujeelArg, ID.text.BRUJEEL_TEXT + 1)
    end)

    brujeel:timer(15000, function(brujeelArg)
        brujeelArg:messageText(brujeelArg, ID.text.BRUJEEL_TEXT + 2)
    end)

    brujeel:timer(18000, function(brujeelArg)
        brujeelArg:messageText(brujeelArg, ID.text.BRUJEEL_TEXT + 3)
    end)

    brujeel:timer(20000, function(brujeelArg)
        brujeelArg:independentAnimation(brujeelArg, xi.magic.spell.WARP, 0)
    end)

    brujeel:timer(24000, function(brujeelArg)
        brujeelArg:messageText(brujeelArg, ID.text.BRUJEEL_TEXT + 4)
    end)

    brujeel:timer(25000, function(brujeelArg)
        brujeelArg:messageText(brujeelArg, ID.text.BRUJEEL_TEXT + 5)
    end)

    brujeel:timer(31000, function(brujeelArg)
        brujeelArg:setStatus(xi.status.CUTSCENE_ONLY)
        instance:setProgress(1)
    end)
end

content.findGate = function(mob)
    local instance = mob:getInstance()

    for gateId = ID.mob.DILAPIDATED_GATE, ID.mob.DILAPIDATED_GATE + 2 do
        local gate = GetMobByID(gateId, instance)

        if
            gate and
            gate:isAlive() and
            mob:checkDistance(gate) <= 10 and
            mob:isFacing(gate)
        then
            return gate
        end
    end

    return nil
end

return content:register()
