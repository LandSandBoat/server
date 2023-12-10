-----------------------------------
-- func: costume2
-- desc: Sets the players current costume2.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!costume2 <costumeID>')
end

commandObj.onTrigger = function(player, costumeId)
    -- validate costumeId
    if costumeId == nil or costumeId < 0 then
        error(player, 'Invalid costumeID.')
        return
    end

    -- put on costume
    player:setCostume2(costumeId)
end

return commandObj
