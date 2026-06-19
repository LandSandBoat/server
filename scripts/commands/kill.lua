-----------------------------------
-- func: !kill <target>
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 2,
    parameters = 's'
}

commandObj.onTrigger = function(player, targetName)
    if targetName == nil then
        player:printToPlayer('The proper syntax for this command is: !kill <target>')
        return
    -- elseif
    --     target:getID() == 38300 or
    --     target:getID() == 15549 or
    --     target:getID() == 23814 or
    --     target:getID() == 32325 or
    --     target:getID() == 16880 or
    --     target:getID() == 17895 or
    --     target:getID() == 31150 or
    --     target:getVar('DavesBlessing') >= 1
    -- then
    --     player:injectActionPacket(player:getID(), 5, 207)
    --     player:injectActionPacket(player:getID(), 5, 216)
    --     player:injectActionPacket(player:getID(), 5, 270)
    --     player:injectActionPacket(player:getID(), 5, 236)
    --     player:printToPlayer('OH NO YOU DIDANT *SNAP FINGERS*')
    --     return
    end

    local target = GetPlayerByName(targetName)

    if target == nil then
        player:printToPlayer(string.format('Player name \'%s\' not found.', targetName))
        return
    end

    target:injectActionPacket(target:getID(), 5, 207, 0, 0, 0, 10, 1)
    target:injectActionPacket(target:getID(), 5, 216, 0, 0, 0, 10, 1)
    target:injectActionPacket(target:getID(), 5, 270, 0, 0, 0, 10, 1)
    target:injectActionPacket(target:getID(), 5, 236, 0, 0, 0, 10, 1)
    player:printToPlayer(string.format('Looks like %s is eating dirt for lunch now.', target:getName()))
end

return commandObj
