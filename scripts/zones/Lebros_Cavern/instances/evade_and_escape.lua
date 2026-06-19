-----------------------------------
-- Assault: Evade and Escape
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------
local switchPositions =
{
    { 262.999, -29.799,  133.000, 0 },
    {  91.999, -39.977,   19.999, 0 },
    { 107.999, -39.977,  -59.999, 0 },
    { 466.999, -49.818,   60.999, 0 },
    { 457.999, -29.989,  -99.999, 0 },
    { 268.999, -39.885, -180.999, 0 },
    { 523.999, -30.000, -279.999, 0 },
}

local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEBROS_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.EVADE_AND_ESCAPE and
        player:getCharVar('assaultEntered') == 0 and
        player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
        player:getMainLvl() > 50
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEBROS_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.EVADE_AND_ESCAPE and
        player:getCharVar('assaultEntered') == 0 and
        player:getMainLvl() > 50
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    xi.assault.afterInstanceRegister(player, xi.item.CAGE_OF_ZHAYOLM_FIREFLIES)

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(301.000, -29.978, -62.000, 192)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(299.000, -30.010, -62.000, 192)
end

instanceObject.onInstanceCreated = function(instance)
    for i, switchID in pairs(ID.npc.SWITCHES) do
        local npc = GetNPCByID(switchID, instance)
        local switchPos = math.random(1, #switchPositions)

        if npc then
            npc:setPos(switchPositions[switchPos])
            table.remove(switchPositions, switchPos)
        end
    end
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.assault.onInstanceCreatedCallback(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    xi.assault.onInstanceFailure(instance)
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress > 0 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    xi.assault.onInstanceComplete(instance, 8, 8)
end

instanceObject.onEventUpdate = function(player, csid, option, npc)
end

instanceObject.onEventFinish = function(player, csid, option, npc)
end

return instanceObject
