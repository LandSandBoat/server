-----------------------------------
-- func: getpool
-- desc: prints the treasure pool of the current target.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 3,
    parameters = ''
}

local function getItemNameById(id)
    for name, value in pairs(xi.item) do
        if value == id then
            return name
        end
    end

    return id
end

local function getPoolTypeById(id)
    for name, value in pairs(xi.treasurePool) do
        if value == id then
            return name
        end
    end

    return id
end

local function printPool(player, target, treasurePool)
    local itemsInPool = treasurePool:getItems()
    local members = treasurePool:getMembers()
    player:printToPlayer(
            string.format('%s\'s Treasure Pool (%s)', target:getName(), getPoolTypeById(treasurePool:getType())), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(
            string.format('%d/%d member(s)', #members, treasurePool:getType()), xi.msg.channel.SYSTEM_3)
    for _, member in pairs(members) do
        player:printToPlayer(
                string.format('  %s (%d)', member:getName(), member:getID()), xi.msg.channel.SYSTEM_3)
    end

    for _, item in pairs(itemsInPool) do
        if item.id ~= 0 then
            local lotters = item.lotters
            player:printToPlayer(
                    string.format('Slot_%d = %s', item.slotId, getItemNameById(item.id), #lotters), xi.msg.channel.SYSTEM_3)
            if #lotters == 0 then
                player:printToPlayer(
                        '  No lots', xi.msg.channel.SYSTEM_3)
            else
                for _, lotter in pairs(lotters) do
                    player:printToPlayer(
                            string.format('  %s -> %d', lotter.member:getName(), lotter.lot), xi.msg.channel.SYSTEM_3)
                end
            end
        end
    end
end

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!getpool')
end

commandObj.onTrigger = function(player)
    local target = player:getCursorTarget()
    if target == nil then
        target = player
    elseif target:isNPC() then
        error(player, 'Current target is an NPC.')
        return
    end

    local treasurePool = target:getTreasurePool()
    printPool(player, target, treasurePool)
end

return commandObj
