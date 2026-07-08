-----------------------------------
-- doomvoid
-----------------------------------
local instanceObject = {}

instanceObject.onInstanceCreated = function(instance)
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    if instance then
        player:setInstance(instance)
        player:setPos(0, 0, 0, 0, instance:getZone():getID())
    end
end

instanceObject.afterInstanceRegister = function(player)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for _, v in pairs(chars) do
        v:setPos(-34.2, -16, 58, 32, 249)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
end

instanceObject.onInstanceComplete = function(instance)
end

return instanceObject
