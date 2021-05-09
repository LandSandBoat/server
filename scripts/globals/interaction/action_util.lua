require('scripts/globals/interaction/actions/event')
require('scripts/globals/interaction/actions/message')
require('scripts/globals/interaction/actions/sequence')
require('scripts/globals/interaction/actions/lambdaaction')

actionUtil = actionUtil or {}

local function parseActionShorthand(actionDef)
    -- Event or cutscene
    local info = actionDef.event or actionDef.cutscene
    if info then
        local event = Event:new(info, actionDef.options)
        if actionDef.cutscene then
            event = event:cutscene()
        end
        if actionDef.progress then
            event = event:progress()
        end
        return event
    end

    -- Message
    info = actionDef.text or actionDef.message
    if info then
        return Message:new(info, actionDef.messageType or actionDef.type, actionDef.options and unpack(actionDef.options))
    end

    -- Message special
    info = actionDef.special or actionDef.messageSpecial
    if info then
        return Message:new(info, Message.Type.Special, actionDef.options and unpack(actionDef.options))
    end

    -- Sequence
    if #actionDef > 0 and type(actionDef[1]) == "table" then
        local sequence = Sequence:new(actionDef)
        if sequence then
            return sequence
        end
    end

    -- Door only
    info = actionDef.open
    if info == nil then
        info = actionDef.door
    end
    if info ~= nil then
        -- Return -1 to open door, else 0
        return LambdaAction:new(function ()
            return info and -1 or 0
        end, Action.Priority.Default)
    end

end

-- Parses out short-hand ways of writing quest actions, in order to avoid having to make function declarations for each simple interaction.
-- Some examples of things it can parse, and what the corresponding actions are:
--
-- Event examples:
--          { event = 123 }                             == quest:event(123)
--          { event = 123, progress = true }            == quest:progressEvent(123)
--          { cutscene = 123 }                          == quest:cutscene(123)
--          { event = 123, options = { [2] = 555 } }    == quest:event(123, { [2] = 555 })
--
-- Message examples:
--          { text = 456 }          == quest:message(456)
--          { message = 456 }       == quest:message(456)
--
-- Sequence example:
--          { { text = 11470, wait = 1000 }, { text = 11471, face = 82, wait = 2000 }, { face = 115 } }
--
-- Door example
--          { door = false }
function actionUtil.parseActionDef(actionDef)
    if type(actionDef) == 'function' then
        return actionDef
    end

    if not actionDef or type(actionDef) ~= 'table' or actionDef.onTrigger or actionDef.onTrade then
        return nil
    end

    -- Action definition is a fully fledged action
    if actionDef.type then
        return actionDef
    end

    local action = parseActionShorthand(actionDef)
    if action ~= nil then
        -- Update priority if specified
        local prio = actionDef.priority or actionDef.prio
        if prio ~= nil then
            action:setPriority(prio)
        end

        -- Update door opening if specified
        local door = actionDef.open
        if door == nil then
            door = actionDef.door
        end
        if door == true then
            action:openDoor()
        end
    end

    return action
end


-- Returns a string containing identification for a specific action
function actionUtil.getActionVarName(secondLevelKey, thirdLevelKey, suffix)
    suffix = suffix or ""
    return string.format("[Action][%s][%s]%s", secondLevelKey, thirdLevelKey, suffix)
end

return actionUtil
