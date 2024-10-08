-----------------------------------
-- Container class
-----------------------------------
require('scripts/globals/interaction/actions/event')
require('scripts/globals/interaction/actions/message')
require('scripts/globals/interaction/actions/sequence')
require('scripts/globals/interaction/actions/keyitem')
-----------------------------------
---@class TInteractionContainer
---@field varPrefix string
Container = {}
Container.__index = Container
Container.__eq = function(c1, c2)
    return c1.id == c2.id
end

---@nodiscard
---@param varPrefix string
function Container:new(varPrefix)
    if varPrefix == nil or string.len(varPrefix) < 5 then
        printf('Invalid container with prefix: %s', varPrefix)
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

---@param eventid integer
---@param ... integer|table
---@return TEvent
function Container:event(eventid, ...)
    return Event:new(eventid, ...)
end

---@param eventid integer
---@param ... integer|table
---@return TEvent
function Container:cutscene(eventid, ...)
    return Event:new(eventid, ...):cutscene()
end

---@param eventid integer
---@param ... integer|table
---@return TEvent
function Container:progressEvent(eventid, ...)
    return Event:new(eventid, ...):progress()
end

---@param eventid integer
---@param ... integer|table
---@return TEvent
function Container:priorityEvent(eventid, ...)
    return Event:new(eventid, ...):progress()
end

---@param eventid integer
---@param ... integer|table
---@return TEvent
function Container:progressCutscene(eventid, ...)
    return Event:new(eventid, ...):cutscene():progress()
end

---@param eventid integer
---@param ... integer|table
---@return TEvent
function Container:replaceEvent(eventid, ...)
    return Event:new(eventid, ...):replaceDefault()
end

---@param keyItemId xi.keyItem
---@return TKeyItem
function Container:keyItem(keyItemId)
    return KeyItemAction:new(keyItemId)
end

---@param messageId integer
---@param messageType integer?
---@param ... integer?
---@return TMessage
function Container:message(messageId, messageType, ...)
    return Message:new(messageId, messageType, ...)
end

---@param messageId integer
---@param ... integer?
---@return TMessage
function Container:messageText(messageId, ...)
    return Message:new(messageId, Message.Type.Text, ...)
end

---@param messageId integer
---@param ... integer?
---@return TMessage
function Container:messageSpecial(messageId, ...)
    return Message:new(messageId, Message.Type.Special, ...)
end

---@param messageId integer
---@param ... integer?
---@return TMessage
function Container:messageName(messageId, ...)
    return Message:new(messageId, Message.Type.Name, ...)
end

---@param messageId integer
---@param ... integer?
function Container:replaceMessage(messageId, messageType, ...)
    return Message:new(messageId, messageType, ...):replaceDefault()
end

function Container:sequence(...)
    if type(...) == 'number' then
        return Message:new(...)
    else
        return Sequence:new({ ... })
    end
end

---@return TNoAction
function Container:noAction(...)
    return NoAction:new(...)
end

-----------------------------------
-- Variable helper functions
-----------------------------------

---@param player CBaseEntity
---@param name string
---@param value integer
---@return nil
function Container:incrementVar(player, name, value)
    return player:incrementCharVar(self.varPrefix .. name, value)
end

---@nodiscard
---@param player CBaseEntity
---@param name string
---@return integer
function Container:getVar(player, name)
    return player:getVar(self.varPrefix .. name)
end

---@param player CBaseEntity
---@param name string
---@param value integer
---@param expiry integer?
---@return nil
function Container:setVar(player, name, value, expiry)
    return player:setVar(self.varPrefix .. name, value, expiry)
end

---@param player CBaseEntity
---@param name string
---@param expiry integer
---@return nil
function Container:setVarExpiration(player, name, expiry)
    return player:setCharVarExpiration(self.varPrefix .. name, expiry)
end

-- Wrapper for setVar where the expiration matters more than any other
-- stored value.  There is no need to get specifically, since it will
-- be removed.  (Returned value is either 1 or 0)
---@param player CBaseEntity
---@param name string
---@param expiry integer
---@return nil
function Container:setTimedVar(player, name, expiry)
    return player:setVar(self.varPrefix .. name, 1, expiry)
end

---@nodiscard
---@param player CBaseEntity
---@param name string
---@param ... integer
---@return boolean
function Container:isVarBitsSet(player, name, ...)
    local sum = 0
    for _, bitNum in ipairs({ ... }) do
        sum = sum + bit.lshift(1, bitNum)
    end

    return bit.band(player:getVar(self.varPrefix .. name), sum) ~= 0
end

---@param player CBaseEntity
---@param name string
---@param bitNum integer
---@return nil
function Container:setVarBit(player, name, bitNum)
    local currentValue = player:getVar(self.varPrefix .. name)
    local bitValue = bit.lshift(1, bitNum)
    if bit.band(currentValue, bitValue) == 0 then
        -- TODO: This will always return nil
        return player:setVar(self.varPrefix .. name, currentValue + bitValue)
    end
end

---@param player CBaseEntity
---@param name string
---@param bitNum integer
---@return nil
function Container:unsetVarBit(player, name, bitNum)
    local currentValue = player:getVar(self.varPrefix .. name)
    local bitValue = bit.lshift(1, bitNum)
    if bit.band(currentValue, bitValue) ~= 0 then
        -- TODO: This will always return nil
        return player:setVar(self.varPrefix .. name, currentValue - bitValue)
    end
end

-- These helper functions will set or get a localVar using varPrefix to determine
-- if zoning/logout is required.  There is no clearing support at this time, outside
-- of legitimate methods.
---@nodiscard
---@param player CBaseEntity
---@return boolean
function Container:getMustZone(player)
    return player:getLocalVar(self.varPrefix .. 'mustZone') == 1 and true or false
end

---@param player CBaseEntity
---@return nil
function Container:setMustZone(player)
    player:setLocalVar(self.varPrefix .. 'mustZone', 1)
end

---@nodiscard
---@param player CBaseEntity
---@param name string
---@return integer
function Container:getLocalVar(player, name)
    return player:getLocalVar(self.varPrefix .. name)
end

---@param player CBaseEntity
---@param name string
---@param value integer
function Container:setLocalVar(player, name, value)
    return player:setLocalVar(self.varPrefix .. name, value)
end
