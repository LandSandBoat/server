-----------------------------------
-- func: costume
-- desc: Sets the players current costume.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!costume <costumeID>")
end

function onTrigger(player, costumeId)
    -- validate costumeId
    if (costumeId == nil or costumeId < 0) then
        error(player, "Invalid costumeID.")
        return
    end

    -- put on costume
    player:costume( costumeId )
end
