-----------------------------------
-- Container class
-----------------------------------
require('scripts/globals/interaction/actions/event')
require('scripts/globals/interaction/actions/message')
require('scripts/globals/interaction/actions/sequence')
require('scripts/globals/interaction/actions/keyitem')
-----------------------------------

Container = {}
Container.__index = Container
Container.__eq = function(c1, c2)
    return c1.id == c2.id
end

function Container:new(varPrefix)
    if varPrefix == nil or string.len(varPrefix) < 5 then
        printf("Invalid container with prefix: %s", varPrefix)
    end

    local obj = {}
    setmetatable(obj, self)
    obj.varPrefix = varPrefix
    obj.id = varPrefix
    return obj
end

function Container:cleanup(player)
    player:clearVarsWithPrefix(self.varPrefix)
end

-----------------------------------
-- Action helper functions
-----------------------------------

function Container:event(eventid, ...)
    return Event:new(eventid, ...)
end

function Container:cutscene(eventid, ...)
    return Event:new(eventid, ...):cutscene()
end

function Container:progressEvent(eventid, ...)
    return Event:new(eventid, ...):progress()
end

function Container:priorityEvent(eventid, ...)
    return Event:new(eventid, ...):progress()
end

function Container:progressCutscene(eventid, ...)
    return Event:new(eventid, ...):cutscene():progress()
end

function Container:replaceEvent(eventid, ...)
    return Event:new(eventid, ...):replaceDefault()
end

function Container:keyItem(keyItemId)
    return KeyItemAction:new(keyItemId)
end

function Container:message(messageId, messageType, ...)
    return Message:new(messageId, messageType, ...)
end

function Container:messageText(messageId, ...)
    return Message:new(messageId, Message.Type.Text, ...)
end

function Container:messageSpecial(messageId, ...)
    return Message:new(messageId, Message.Type.Special, ...)
end

function Container:replaceMessage(messageId, messageType, ...)
    return Message:new(messageId, messageType, ...):replaceDefault()
end

function Container:sequence(...)
    if type(...) == 'number' then
        return Message:new(...)
    else
        return Sequence:new({...})
    end
end


-----------------------------------
-- Variable helper functions
-----------------------------------

function Container:getVar(player, name)
    return player:getVar(self.varPrefix .. name)
end

function Container:setVar(player, name, value)
    return player:setVar(self.varPrefix .. name, value)
end

function Container:isVarBitsSet(player, name, ...)
    local sum = 0
    for _, bitNum in ipairs({...}) do
        sum = sum + bit.lshift(1, bitNum)
    end
    return bit.band(player:getVar(self.varPrefix .. name), sum) ~= 0
end

function Container:setVarBit(player, name, bitNum)
    local currentValue = player:getVar(self.varPrefix .. name)
    local bitValue = bit.lshift(1, bitNum)
    if bit.band(currentValue, bitValue) == 0 then
        return player:setVar(self.varPrefix .. name, currentValue + bitValue)
    end
end

function Container:unsetVarBit(player, name, bitNum)
    local currentValue = player:getVar(self.varPrefix .. name)
    local bitValue = bit.lshift(1, bitNum)
    if bit.band(currentValue, bitValue) ~= 0 then
        return player:setVar(self.varPrefix .. name, currentValue - bitValue)
    end
end
