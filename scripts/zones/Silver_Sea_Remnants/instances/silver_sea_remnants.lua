-----------------------------------
-- Salvage : Silver Sea Remnants
-----------------------------------
local ID = zones[xi.zone.SILVER_SEA_REMNANTS]
-----------------------------------

local instanceObject = {}

-- Requirements for the first player registering the instance
instanceObject.registryRequirements = function(player)
    return player:getMainLvl() >= 65 and player:hasKeyItem(xi.ki.REMNANTS_PERMIT)
end

-- Requirements for further players entering an already-registered instance
instanceObject.entryRequirements = function(player)
    return player:getMainLvl() >= 65 and player:hasKeyItem(xi.ki.REMNANTS_PERMIT)
end

-- Called on the instance once it is created and ready
instanceObject.onInstanceCreated = function(instance)
    instance:setStage(1)
    instance:setProgress(1)
end

-- Once the instance is ready inform the requester that it's ready
instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

-- When the player zones into the instance
instanceObject.afterInstanceRegister = function(player)
    for i = xi.slot.MAIN, xi.slot.BACK do
        player:unequipItem(i)
    end

    player:addStatusEffectEx(xi.effect.ENCUMBRANCE_I, xi.effect.ENCUMBRANCE_I, 0xFFFF, 0, 6000)
    player:addStatusEffectEx(xi.effect.OBLIVISCENCE, xi.effect.OBLIVISCENCE, 1, 0, 6000)
    player:addStatusEffectEx(xi.effect.OMERTA, xi.effect.OMERTA, 0x3F, 0, 6000)
    player:addStatusEffectEx(xi.effect.IMPAIRMENT, xi.effect.IMPAIRMENT, 3, 0, 6000)
    player:addStatusEffectEx(xi.effect.DEBILITATION, xi.effect.DEBILITATION, 0x1FF, 0, 6000)
    player:addTempItem(xi.item.CAGE_OF_S_REMNANTS_FIREFLIES)
    player:delKeyItem(xi.ki.REMNANTS_PERMIT)
end

-- Instance 'tick'
instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

-- On fail
instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    local mobs  = instance:getMobs()

    for _, entity in pairs(mobs) do
        DespawnMob(entity:getID(), instance)
    end

    for _, players in ipairs(chars) do
        players:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        players:startCutscene(1)
    end
end

instanceObject.onTriggerAreaEnter = function(player, triggerArea)
end

-- When something in the instance calls: instance:setProgress(...)
instanceObject.onInstanceProgressUpdate = function(instance, progress)
end

-- On win
instanceObject.onInstanceComplete = function(instance)
end

-- Standard event hooks, these will take priority over everything apart from m_event.Script
-- Omitting this will fallthrough to the same calls in the Zone.lua
instanceObject.onEventUpdate = function(player, csid, option, npc)
end

instanceObject.onEventFinish = function(player, csid, option, npc)
    local instance = player:getInstance()
    local chars    = instance:getChars()

    if csid == 1 then
        for _, players in ipairs(chars) do
            players:setPos(580, 0, 500, 192, xi.zone.ALZADAAL_UNDERSEA_RUINS)
        end
    end
end

return instanceObject
