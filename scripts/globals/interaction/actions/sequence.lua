----------------------------
----- Sequence class
----------------------------
require('scripts/globals/interaction/actions/action')
require('scripts/globals/interaction/actions/message')

Sequence = Action:new(Action.Type.Sequence)

-- Parse out a sequence from a table of actions.
--
-- Sequence example:
--      { { text = 11470, wait = 1000 }, { text = 11471, face = 82, wait = 2000 }, { face = 115 } }
--  which translates to:
--      * send message 11470, and wait 1 second
--      * send message 11471 and face 82, and wait 2 seconds
--      * face 115
function Sequence:new(unparsedSequence)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self

    if not unparsedSequence or #unparsedSequence == 0 then
        return nil
    end

    local dummyFirst = { }
    local last = dummyFirst
    local id = nil
    for _, entry in ipairs(unparsedSequence) do
        if entry.text then
            local newLast = Message:new(entry.text)
            last.__nextAction = newLast
            last = newLast
            if id == nil then
                id = entry.text
            end
            if entry.face then
                newLast:face(entry.face)
            end
        elseif entry.face then
            local newLast = { type = Action.Type.Face, face = entry.face }
            last.__nextAction = newLast
            last = newLast
        end

        -- Waits can be part of the other action
        if entry.wait then
            local newLast = { type = Action.Type.Wait, milliseconds = entry.wait }
            last.__nextAction = newLast
            last = newLast
        end
    end
    last.__nextAction = { type = Action.Type.Release }

    obj.id = id
    obj.priority = Action.Priority.Event
    obj.first = dummyFirst.__nextAction
    obj.insertAt = last
    return obj
end

function Sequence.performSequenceAction(action, player, targetEntity)
    if not action then
        return
    end

    if action.type == Action.Type.Face then
        local npc = action.npcId and GetNPCByID(action.npcId) or targetEntity
        local angle = type(action.face) == 'number' and action.face or npc:getAngle(player)
        npc:setRotation(angle)
        Sequence.performSequenceAction(action.__nextAction, player, targetEntity)

    elseif action.type == Action.Type.Wait then
        player:timer(action.milliseconds, function (player)
            Sequence.performSequenceAction(action.__nextAction, player, targetEntity)
        end)

    elseif action.type == Action.Type.Release then
        player:release()
        Sequence.performSequenceAction(action.__nextAction, player, targetEntity)

    elseif action.perform then
        -- Not a sequence-only action, so delegate responsibility to the corresponding action class
        if action:perform(player, targetEntity) ~= false then
            Sequence.performSequenceAction(action.__nextAction, player, targetEntity)
        end
    end
end

function Sequence:perform(player, targetEntity)
    player:startSequence()
    Sequence.performSequenceAction(self.first, player, targetEntity)
end

function Sequence:addNext(nextAction)
    if not self.id and nextAction.id then
        self.id = nextAction.id
    end
    if self.insertAt == nil then
        self.insertAt = nextAction
        self.insertAt.__nextAction = self.first
        self.first = nextAction
    else
        nextAction.__nextAction = self.insertAt.__nextAction
        self.insertAt.__nextAction = nextAction
        self.insertAt = nextAction
    end
    return self
end

function Sequence:message(messageId)
    return self:addNext(Message:new(messageId))
end

function Sequence:face(rotation)
    return self:addNext({ type = Action.Type.Face, face = rotation })
end

function Sequence:wait(milliseconds)
    return self:addNext({ type = Action.Type.Wait, milliseconds = milliseconds })
end
