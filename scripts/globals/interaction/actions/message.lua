-----------------------------------
----- Message class
-----------------------------------
require('scripts/globals/interaction/actions/action')

---@class TMessage: TAction
---@field messageType Message.type
---@field id integer
---@field npcId integer?
---@field options integer[]
---@field face integer?
Message = Action:new(Action.Type.Message)

---@enum Message.type
Message.Type =
{
    Text    = 1,
    Special = 2,
    Name    = 3,
}

---@param messageId integer
---@param messageType Message.type?
---@param ... integer?
---@return TMessage
function Message:new(messageId, messageType, ...)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = messageId
    obj.priority = Action.Priority.Message -- messages have lowest default priority
    obj.messageType = messageType or Message.Type.Text
    obj.options = { ... }
    return obj
end

---@param player CBaseEntity
---@param targetEntity CBaseEntity
function Message:perform(player, targetEntity)
    if self.messageType == Message.Type.Special then
        player:messageSpecial(self.id, unpack(self.options))
    elseif self.messageType == Message.Type.Name then
        player:showText(self.npcId and GetNPCByID(self.npcId) or targetEntity, self.id, unpack(self.options))
    else
        player:messageText(self.npcId and GetNPCByID(self.npcId) or targetEntity, self.id, { face = self.face })
    end

    return self.returnValue
end

function Message:face(direction)
    self.face = direction
end
