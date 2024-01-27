-----------------------------------
-- func: hide
-- desc: Hides the GM from other players.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

commandObj.onTrigger = function(player, cmd)
    -- Obtain the players hide status..
    local isHidden = player:getCharVar('GMHidden')
    if cmd ~= nil then
        if cmd == 'status' then
            player:printToPlayer(string.format('Current hide status: %s', tostring(isHidden)))
            return
        end
    end

    -- Toggle the hide status..
    if isHidden == 0 then
        isHidden = 1
    else
        isHidden = 0
    end

    -- If hidden animate us beginning our hide..
    if isHidden == 1 then
        player:setCharVar('GMHidden', 1)
        player:setGMHidden(true)
        player:printToPlayer('You are now GM hidden from other players.')
    else
        player:setCharVar('GMHidden', 0)
        player:setGMHidden(false)
        player:printToPlayer('You are no longer GM hidden from other players.')
    end
end

return commandObj
