-----------------------------------
-- func: costume
-- desc: Sets the players current costume.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!costume <costumeID>')
end

commandObj.onTrigger = function(player, costumeId)
    -- validate costumeId
    if costumeId == nil or costumeId < 0 then
        error(player, 'Invalid costumeID.')
        return
    end

    -- put on costume
    player:setCostume(costumeId)
end

return commandObj
