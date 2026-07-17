-----------------------------------
-- Zone Utilities
-- random globals that may be used per zone
-----------------------------------
local ID = zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS]
-----------------------------------
xi = xi or {}
xi.zoneUtil = xi.zoneUtil or {}
-----------------------------------

xi.zoneUtil.ImperialAgent_PotHatch = function(player, npc, posX, posZ, posR)
    local instance = npc:getInstance()
    if not instance then
        return
    end

    -- The Assault controller normally initializes this when the instance is
    -- created. Retain a defensive fallback for already-running instances.
    local selectedPot = instance:getLocalVar('ImperialAgentRescuePotId')
    if selectedPot == 0 then
        selectedPot = math.randomInt(ID.npc.POT_HATCH, ID.npc.POT_HATCH + 2)
        instance:setLocalVar('ImperialAgentRescuePotId', selectedPot)
    end

    npc:setAnimation(8)

    if
        npc:getID() ~= selectedPot or
        instance:getLocalVar('ImperialAgentRescueTriggered') == 1
    then
        return
    end

    local ally = GetNPCByID(ID.npc.BRUJEEL, instance)
    if not ally then
        return
    end

    instance:setLocalVar('ImperialAgentRescueTriggered', 1)

    ally:setStatus(xi.status.NORMAL)
    ally:entityAnimationPacket(xi.animationString.STATUS_VISIBLE)

    npc:timer(2000, function(npcArg)
        ally:setPos(posX, -1, posZ, posR)
    end)

    npc:timer(4000, function(npcArg)
        ally:setAnimation(0)
    end)

    local function showBrujeelText(messageOffset)
        for _, member in pairs(instance:getChars()) do
            member:showText(ally, ID.text.BRUJEEL_TEXT + messageOffset)
        end
    end

    npc:timer(7000, function(npcArg)
        showBrujeelText(0)
    end)

    npc:timer(10000, function(npcArg)
        showBrujeelText(1)
    end)

    npc:timer(12000, function(npcArg)
        showBrujeelText(2)
    end)

    npc:timer(14000, function(npcArg)
        showBrujeelText(3)
    end)

    npc:timer(16000, function(npcArg)
        showBrujeelText(4)
    end)

    npc:timer(18000, function(npcArg)
        showBrujeelText(5)
    end)

    npc:timer(20000, function(npcArg)
        ally:entityAnimationPacket(xi.animationString.CAST_BLACK_MAGIC_START)
    end)

    npc:timer(22000, function(npcArg)
        ally:entityAnimationPacket(xi.animationString.CAST_BLACK_MAGIC_STOP)
    end)

    npc:timer(23000, function(npcArg)
        ally:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
    end)

    npc:timer(24500, function(npcArg)
        ally:setStatus(xi.status.DISAPPEAR)
    end)

    npc:timer(26000, function(npcArg)
        if not instance:completed() then
            instance:complete()
        end
    end)
end

return xi.zoneUtil
