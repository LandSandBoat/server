-----------------------------------
-- Assault: Extermination
-- Instance: 6602
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.ILRUSI_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.EXTERMINATION and
        player:getCharVar("assaultEntered") == 0 and
        player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
        player:getMainLvl() > 70
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.ILRUSI_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.EXTERMINATION and
        player:getCharVar("assaultEntered") == 0 and
        player:getMainLvl() > 70
end

instanceObject.onInstanceCreated = function(instance)
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.assault.onInstanceCreatedCallback(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
    local mobTable = ID.mob[xi.assault.mission.EXTERMINATION].MOBS_START

    local playerCount = instance:getChars()

    instance:setLocalVar("nmLimit", 1)
    instance:setLocalVar("chosenMob1", math.random(mobTable[1], mobTable[#mobTable]))

    if #playerCount >= 6 then
        instance:setLocalVar("nmLimit", 2)
        instance:setLocalVar("chosenMob2", math.random(mobTable[1], mobTable[#mobTable]))

        while instance:getLocalVar("chosenMob2") ~= instance:getLocalVar("chosenMob1") do
            instance:setLocalVar("chosenMob2", math.random(mobTable[1], mobTable[#mobTable]))
        end
    end
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    xi.assault.afterInstanceRegister(player, xi.items.CAGE_OF_BHAFLAU_FIREFLIES)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(290.857, -3.424, 132.339, 210)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(293.637, -3.376, 130.364, 210)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    xi.assault.onInstanceFailure(instance)
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 20 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    xi.assault.onInstanceComplete(instance, 6, 8) -- (H-8)
end

instanceObject.onEventFinish = function(player, csid, option)
    xi.assault.instanceOnEventFinish(player, csid, xi.zone.BHAFLAU_THICKETS)
end

return instanceObject
