-----------------------------------
-- func: inject
-- desc: Injects the given packet data.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!inject <packet>")
end

function onTrigger(player, packet)
    -- validate packet
    if packet == nil then
        error(player, "You must enter a packet file name.")
        return
    end

    -- inject packet
    player:injectPacket(packet)
end
