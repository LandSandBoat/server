-----------------------------------
-- func: menu_paginated
-- desc: Shows a paginated test menu with two pages, an option per page.
-- note: title and options are required.
--     : onStart, onCancelled, and onEnd are optional.
--     : You must provide at least one option.
--     : Incorrectly creating or configuring a menu
--     : will not result in a crash or broken menus,
--     : but will produce scary looking warnings in
--     : the log.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

-- Forward declarations (required)
local menu  = {}
local page1 = {}
local page2 = {}

-- We need just a tiny delay to let the previous menu context be cleared out
-- 'New pages' are actually just whole new menus!
local delaySendMenu = function(player)
    player:timer(50, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

menu =
{
    title = 'Test Menu (Paginated)',
    options = {},
}

page1 =
{
    {
        'Option 1',
        function(playerArg)
            playerArg:printToPlayer('Option 1 Selected', xi.msg.channel.NS_SAY)
            playerArg:independentAnimation(playerArg, 251, 4) -- Hearts
        end,
    },
    {
        'Next Page',
        function(playerArg)
            menu.options = page2
            delaySendMenu(playerArg)
        end,
    },
}

page2 =
{
    {
        'Option 2',
        function(playerArg)
            playerArg:printToPlayer('Option 2 Selected', xi.msg.channel.NS_SAY)
            playerArg:independentAnimation(playerArg, 252, 4) -- Music Notes
        end,
    },
    {
        'Previous Page',
        function(playerArg)
            menu.options = page1
            delaySendMenu(playerArg)
        end,
    },
}

commandObj.onTrigger = function(player)
    menu.options = page1
    delaySendMenu(player)
end

return commandObj
