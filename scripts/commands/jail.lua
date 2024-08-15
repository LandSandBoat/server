-----------------------------------
-- func: jail
-- desc: Sends the target player to jail. (Mordion Gaol)
-- note: Only works if the target is on the same map process (cluster) as the GM or the target is offline
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'sis'
}

commandObj.onTrigger = function(player, target, cellId, reason)
    local jailCells =
    {
        -- Floor 1 (Bottom)
        { -620, 11,  660 },
        { -180, 11,  660 },
        {  260, 11,  660 },
        {  700, 11,  660 },
        { -620, 11,  220 },
        { -180, 11,  220 },
        {  260, 11,  220 },
        {  700, 11,  220 },
        { -620, 11, -220 },
        { -180, 11, -220 },
        {  260, 11, -220 },
        {  700, 11, -220 },
        { -620, 11, -620 },
        { -180, 11, -620 },
        {  260, 11, -620 },
        {  700, 11, -620 },

        -- Floor 2 (Top)
        { -620, -400,  660 },
        { -180, -400,  660 },
        {  260, -400,  660 },
        {  700, -400,  660 },
        { -620, -400,  220 },
        { -180, -400,  220 },
        {  260, -400,  220 },
        {  700, -400,  220 },
        { -620, -400, -220 },
        { -180, -400, -220 },
        {  260, -400, -220 },
        {  700, -400, -220 },
        { -620, -400, -620 },
        { -180, -400, -620 },
        {  260, -400, -620 },
        {  700, -400, -620 },
    }

    -- defaults
    local targetIsOnline = false
    local targetID       = 0
    local targetObj      = GetPlayerByName(target)

    -- Did not find the target (Invalid target name, offline target or online target in a different map process)
    if targetObj == nil then
        -- check if the target name is in the database
        targetID = GetPlayerIDByName(target)

        -- If name in the database then will have valid ID > 0
        if
            targetID ~= nil and
            targetID > 0 and
            targetID < 0xFFFFFFFF
        then
            -- next check if the target has a valid session (and thus online in a different map process (cluster))
            if PlayerHasValidSession(targetID) then
                -- Target online in different map process (cluster) than GM so inform the GM and exit
                player:printToPlayer(string.format("Player '%s' is online but in a different zone group (cluster). Go to that zone group to use !jail", target))
                return
            end

        -- No such target name in the database so inform the GM and exit
        else
            player:printToPlayer(string.format("Invalid player '%s' given.", target))
            return
        end

    -- Found the target online in this map process. Get their ID.
    else
        targetIsOnline = true
        targetID       = targetObj:getID()
    end

    -- Target safety check.
    if
        targetID == nil or
        targetID <= 0 or
        targetID >= 0xFFFFFFFF
    then
        player:printToPlayer('Something went wrong.')
        return
    end

    -----------------------------------
    -- Validate parameter 2 (Cell id) (Optional)
    -----------------------------------
    local chosenCell = 1

    if
        cellId ~= nil and
        cellId > 0 and
        cellId <= 32
    then
        chosenCell = cellId
    end

    -----------------------------------
    -- Validate parameter 3 (Reason) (Optional)
    -----------------------------------
    if reason == nil then
        reason = 'Unspecified'
    end

    -----------------------------------
    -- Perform the jailing
    -----------------------------------
    -- Send message to GM and console.
    local targetStatus = (targetIsOnline and 'Online') or 'Offline'
    local message      = string.format('%s jailed %s (ID: %d, status: %s) into cell %d. Reason: %s', player:getName(), target, targetID, targetStatus, chosenCell, reason)

    player:printToPlayer(message)
    printf(message)

    -- Send player to jail using either the online or offline method
    local dest = jailCells[chosenCell]

    if targetObj and targetIsOnline then
        targetObj:setCharVar('inJail', chosenCell)
        targetObj:setPos(dest[1], dest[2], dest[3], 0, 131)
    else
        SendToJailOffline(targetID, chosenCell, dest[1], dest[2], dest[3], 0)
    end
end

return commandObj
