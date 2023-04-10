-----------------------------------
-- func: cs2
-- desc: Starts the given event for the player.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "issssiiiiiiii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!cs2 <csID> (string1) (string2) (string3) (string4) (op1) (op2) (op3) (op4) (op5) (op6) (op7) (op8)")
end

function onTrigger(player, csid, string1, string2, string3, string4, op1, op2, op3, op4, op5, op6, op7, op8)
    -- validate csid
    if csid == nil then
        error(player, "You must enter a cutscene id.")
        return
    end

    -- play cs
    player:startEventString(csid, string1, string2, string3, string4, op1, op2, op3, op4, op5, op6, op7, op8)
end
