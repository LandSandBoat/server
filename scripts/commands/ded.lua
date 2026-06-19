-----------------------------------
-- func: !ded <target>
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 4,
    parameters = 's'
}

commandObj.onTrigger = function(player, target)
    if target == nil then
        player:printToPlayer('The proper syntax for this command is: !ded <target>')
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
    --     player:injectActionPacket(player:getID(), 5, 271)
    --     player:injectActionPacket(player:getID(), 5, 202)
    --     player:injectActionPacket(player:getID(), 5, 207)
    --     player:injectActionPacket(player:getID(), 5, 216)
    --     player:injectActionPacket(player:getID(), 5, 270)
    --     player:setHP(0)
    --     player:printToPlayer('OH NO YOU DIDANT *SNAP FINGERS*')
    --     return
    end

    local targ = GetPlayerByName(target)

    if targ == nil then
        player:printToPlayer(string.format('Player named \'%s\' not found.', target))
        return
    end

    targ:injectActionPacket(targ:getID(), 5, 271, 0, 0, 0, 10, 1)
    targ:injectActionPacket(targ:getID(), 5, 202, 0, 0, 0, 10, 1)
    targ:injectActionPacket(targ:getID(), 5, 207, 0, 0, 0, 10, 1)
    targ:injectActionPacket(targ:getID(), 5, 216, 0, 0, 0, 10, 1)
    targ:injectActionPacket(targ:getID(), 5, 270, 0, 0, 0, 10, 1)
    targ:setHP(0)
    player:printToPlayer(string.format('%s is resting in pepperoni\'s.', targ:getName()))
end

return commandObj
