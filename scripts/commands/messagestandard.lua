-----------------------------------
-- func: messagestandard
-- desc: Injects a standard message packet.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!messagestandard <message ID>")
end

function onTrigger(player, msgId)
    -- validate msgId
    if msgId == nil then
        error(player, "You must provide a message ID.")
        return
    end

    -- inject message packet
    player:messageBasic(msgId)
end
