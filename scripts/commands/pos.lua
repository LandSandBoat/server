-----------------------------------
-- func: pos <x> <y> <z> <optional zone> <optional target>
-- desc: Sets the players position. If none is given, prints out the position instead.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!pos (x) (y) (z) (zone ID) (player)')
end

commandObj.onTrigger = function(player, arg)
    local target
    local zoneId
    local x
    local y
    local z
    local targ

    if arg == nil then
        player:PrintToPlayer(string.format('%s\'s position: X %.4f  Y %.4f  Z %.4f  Rot %i  (Zone: %i)', player:getName(), player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID()), xi.msg.channel.SYSTEM_3)
        return
    end

    local args = utils.splitArg(arg)

    -- shift arguments depending on number passed
    if args[5] ~= nil then
        x = tonumber(args[1])
        y = tonumber(args[2])
        z = tonumber(args[3])
        zoneId = tonumber(args[4])
        target = args[5]
    elseif args[4] ~= nil then
        x = tonumber(args[1])
        y = tonumber(args[2])
        z = tonumber(args[3])
        if GetPlayerByName(args[4]) == nil then
            zoneId = args[4]
        else
            target = args[4]
        end
    elseif args[3] ~= nil then
        x = tonumber(args[1])
        y = tonumber(args[2])
        z = tonumber(args[3])
    elseif args[1] ~= nil then
        target = args[1]
    end

    -- validate target
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    -- validate zone
    if zoneId ~= nil then
        zoneId = tonumber(zoneId)
        if zoneId == nil or zoneId < 0 or zoneId > 298 then
            error(player, 'Invalid zone ID.')
            return
        end
    end

    -- report or move position
    if x == nil or y == nil or z == nil then
        player:PrintToPlayer(string.format('%s\'s position: X %.4f  Y %.4f  Z %.4f  Rot %i  (Zone: %i)', targ:getName(), targ:getXPos(), targ:getYPos(), targ:getZPos(), targ:getRotPos(), targ:getZoneID()), xi.msg.channel.SYSTEM_3)
    else
        if zoneId == nil then
            zoneId = targ:getZoneID()
            targ:setPos(x, y, z, 0)
        else
            targ:setPos(x, y, z, 0, zoneId)
        end

        if player:getID() ~= targ:getID() then
            player:PrintToPlayer(string.format('Moved %s to (%.4f, %.4f, %.4f) in zone %i.', targ:getName(), x, y, z, targ:getZoneID()), xi.msg.channel.SYSTEM_3)
        end
    end
end

return commandObj
