-----------------------------------
-- func: entityVisual
-- desc: push entityVisual packet to player
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!entityvisual <animation string>")
end

function onTrigger(player, visualstring)
    -- validate visualstring
    if visualstring == nil then
        error(player, "You must enter a valid animation string.")
        return
    end

    -- push visual packet to player
    player:entityVisualPacket(visualstring)
end
