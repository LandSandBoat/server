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
        { -620, 11,  660, 0 },  { -180, 11,  660, 0 }, { 260, 11,  660, 0 }, { 700, 11,  660, 0 },
        { -620, 11,  220, 0 },  { -180, 11,  220, 0 }, { 260, 11,  220, 0 }, { 700, 11,  220, 0 },
        { -620, 11, -220, 0 },  { -180, 11, -220, 0 }, { 260, 11, -220, 0 }, { 700, 11, -220, 0 },
        { -620, 11, -620, 0 },  { -180, 11, -620, 0 }, { 260, 11, -620, 0 }, { 700, 11, -620, 0 },

        -- Floor 2 (Top)
        { -620, -400,  660, 0 },  { -180, -400,  660, 0 }, { 260, -400,  660, 0 }, { 700, -400,  660, 0 },
        { -620, -400,  220, 0 },  { -180, -400,  220, 0 }, { 260, -400,  220, 0 }, { 700, -400,  220, 0 },
        { -620, -400, -220, 0 },  { -180, -400, -220, 0 }, { 260, -400, -220, 0 }, { 700, -400, -220, 0 },
        { -620, -400, -620, 0 },  { -180, -400, -620, 0 }, { 260, -400, -620, 0 }, { 700, -400, -620, 0 },
    }

    -- defaults
    local targetIsOnline = false
    local targetID = 0

    -- find the target object (this only works on targets on the same map process (cluster) as GM)
    local targetObj = GetPlayerByName(target)

    -- did not find the target (so either invalid target name, offline target, or online target in a different map process (cluster) than GM)
    if targetObj == nil then
        -- check if the target name is in the database
        targetID = GetPlayerIDByName(target)
        -- if name in the database then will have valid ID > 0
        if targetID > 0 and targetID < 0xFFFFFFFF then
            -- next check if the target has a valid session (and thus online in a different map process (cluster))
            if PlayerHasValidSession(targetID) then
                -- target online in different map process (cluster) than GM so inform the GM and exit
                player:printToPlayer(string.format("Player '%s' is online but in a different zone group (cluster). Go to that zone group to use !jail", target))
                return
            end
        -- no such target name in the database so inform the GM and exit
        else
            player:printToPlayer(string.format("Invalid player '%s' given.", target))
            return
        end
    -- found the target online in this map process (cluster) so get their ID directly
    else
        targetIsOnline = true
        targetID = targetObj:getID()
    end

    -- validate the cell id and default to 1
    if cellId == nil or cellId == 0 or cellId > 32 then
        cellId = 1
    end

    -- validate the reason and default to Unspecified
    if reason == nil then
        reason = 'Unspecified'
    end

    local targetStatus = (targetIsOnline and 'Online') or 'Offline'
    -- inform the GM that they have jailed someone
    local message = string.format('%s jailed %s (ID: %d, status: %s) into cell %d. Reason: %s', player:getName(), target, targetID, targetStatus, cellId, reason)
    player:printToPlayer(message)
    printf(message)

    -- Send the target to jail using either the online or offline method
    local dest = jailCells[cellId]
    if targetIsOnline then
        targetObj:setCharVar('inJail', cellId)
        targetObj:setPos(dest[1], dest[2], dest[3], dest[4], 131)
    else
        SendToJailOffline(targetID, cellId, dest[1], dest[2], dest[3], dest[4])
    end
end

return commandObj
