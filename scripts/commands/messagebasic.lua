-----------------------------------
-- func: messagebasic
-- desc: Injects a message basic packet.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "iii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!messagebasic <message ID> (param1) (param2)")
end

function onTrigger(player, msgId, param1, param2)
    -- validate msgId
    if msgId == nil then
        error(player, "You must provide a message ID.")
        return
    end

    local target = player:getCursorTarget()
    if target == nil then
        target = player
    end

    -- inject message packet
    player:messageBasic(msgId, param1, param2, target)
end
