----------------------------
----- Message class
----------------------------
require('scripts/globals/interaction/actions/action')

Message = Action:new(Action.Type.Message)

Message.Type = {
    Text = 1,
    Special = 2,
}

function Message:new(messageId, messageType, ...)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = messageId
    obj.priority = Action.Priority.Message -- messages have lowest default priority
    obj.messageType = messageType or Message.Type.Text
    obj.options = {...}
    return obj
end

function Message:perform(player, targetEntity)
    if self.messageType == Message.Type.Special then
        player:messageSpecial(self.id, unpack(self.options))
    else
        player:messageText(self.npcId and GetNPCByID(self.npcId) or targetEntity, self.id, { face = self.face })
    end
    return self.returnValue
end

function Message:face(direction)
    self.face = direction
end
