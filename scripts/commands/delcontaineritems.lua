-----------------------------------
-- func: delcontaineritems
-- desc: Deletes all items in a player's specified container, if they have any.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'is'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!delcontaineritems <container> (player)')
end

local containerNames =
{
    [xi.inv.INVENTORY]  = 'Inventory',
    [xi.inv.MOGSAFE]    = 'Mog Safe',
    [xi.inv.STORAGE]    = 'Storage',
    [xi.inv.TEMPITEMS]  = 'Temp. Items',
    [xi.inv.MOGLOCKER]  = 'Mog Locker',
    [xi.inv.MOGSATCHEL] = 'Mog Satchel',
    [xi.inv.MOGSACK]    = 'Mog Sack',
    [xi.inv.MOGCASE]    = 'Mog Case',
    [xi.inv.WARDROBE]   = 'Mog Wardrobe 1',
    [xi.inv.MOGSAFE2]   = 'Mog Safe 2',
    [xi.inv.WARDROBE2]  = 'Mog Wardrobe 2',
    [xi.inv.WARDROBE3]  = 'Mog Wardrobe 3',
    [xi.inv.WARDROBE4]  = 'Mog Wardrobe 4',
    [xi.inv.WARDROBE5]  = 'Mog Wardrobe 5',
    [xi.inv.WARDROBE6]  = 'Mog Wardrobe 6',
    [xi.inv.WARDROBE7]  = 'Mog Wardrobe 7',
    [xi.inv.WARDROBE8]  = 'Mog Wardrobe 8',
}

commandObj.onTrigger = function(player, container, target)
    -- validate target
    local targ
    if target == nil then
        targ = player:getCursorTarget()
        if targ == nil or not targ:isPC() then
            targ = player
        end
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    -- validate container
    local containerName = containerNames[container]
    if containerName == nil then
        error(player, 'Invalid container specified.')
        return
    end

    if targ:delContainerItems(container) then
        player:printToPlayer(string.format('Deleted all items in %s for %s.', containerName, targ:getName()))
    end
end

return commandObj
