-----------------------------------
-- func: menu
-- desc: Shows a basic test menu with three options
-- note: title and options are required.
--     : onStart, onCancelled, and onEnd are optional.
--     : You must provide at least one option.
--     : Incorrectly creating or configuring a menu
--     : will not result in a crash or broken menus,
--     : but will produce scary looking warnings in
--     : the log.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    local selection = 0
    local mainMenu =
    {
        title = "Main menu:",

        onStart = function(playerArg)
            playerArg:PrintToPlayer("Main-Menu Opening", xi.msg.channel.NS_SAY)
        end,

        options =
        {
            {
                "Open Sub-Menu 1",
                function(playerArg)							
                    selection = 1
                end,
            },
            {
                "Open Sub-menu 2",
                function(playerArg)							
                    selection = 2
                end,
            },
            {
                "Open Sub-menu 3",
                function(playerArg)		
                    selection = 3
                end,
            },
        },

        onCancelled = function(playerArg)
            playerArg:PrintToPlayer("Main-Menu Cancelled", xi.msg.channel.NS_SAY)
        end,

        onEnd = function(playerArg)
            -- NOTE: This could be used to release a locked player,
            playerArg:PrintToPlayer("Main-Menu Closing", xi.msg.channel.NS_SAY)

            -- Open Sub-Menu
            if selection == 1 then
                playerArg:customMenu(subMenuOne)
            elseif selection == 2 then
                playerArg:customMenu(subMenuTwo)
            elseif selection == 3 then
                playerArg:customMenu(subMenuThree)
            else
                playerArg:PrintToPlayer("Selection isn't valid'", xi.msg.channel.NS_SAY)       
            end
        end,
    }

    local subMenuOne =
    {
        title = "Sub-Menu 1",

        onStart = function(playerArg)
            playerArg:PrintToPlayer("Main Sub-menu 1 Opening", xi.msg.channel.NS_SAY)
        end,

        options =
        {
            {
                "Sub-Menu 1, Option 1",
                function(playerArg)							
                    playerArg:PrintToPlayer("Option 1 of sub-menu 1 selected.", xi.msg.channel.NS_SAY)
                end,
            },
            {
                "Sub-Menu 1, Option 2",
                function(playerArg)							
                    playerArg:PrintToPlayer("Option 2 of sub-menu 1 selected.", xi.msg.channel.NS_SAY)
                end,
            },
            {
                "Sub-Menu 1, Option 3",
                function(playerArg)		
                    playerArg:PrintToPlayer("Option 3 of sub-menu 1 selected.", xi.msg.channel.NS_SAY)
                end,
            },
        },

        onCancelled = function(playerArg)
            playerArg:PrintToPlayer("Sub-Menu 1 Cancelled", xi.msg.channel.NS_SAY)
        end,

        onEnd = function(playerArg)
            -- NOTE: This could be used to release a locked player,
            playerArg:PrintToPlayer("Sub-Menu 1 Closing", xi.msg.channel.NS_SAY)
        end,
    }

    local subMenuTwo =
    {
        title = "Sub-Menu 2",

        onStart = function(playerArg)
            playerArg:PrintToPlayer("Main Sub-menu 2 Opening", xi.msg.channel.NS_SAY)
        end,

        options =
        {
            {
                "Sub-Menu 2, Option 1",
                function(playerArg)							
                    playerArg:PrintToPlayer("Option 1 of sub-menu 2 selected.", xi.msg.channel.NS_SAY)
                end,
            },
            {
                "Sub-Menu 2, Option 2",
                function(playerArg)							
                    playerArg:PrintToPlayer("Option 2 of sub-menu 2 selected.", xi.msg.channel.NS_SAY)
                end,
            },
            {
                "Sub-Menu 2, Option 3",
                function(playerArg)		
                    playerArg:PrintToPlayer("Option 3 of sub-menu 2 selected.", xi.msg.channel.NS_SAY)
                end,
            },
        },

        onCancelled = function(playerArg)
            playerArg:PrintToPlayer("Sub-Menu 2 Cancelled", xi.msg.channel.NS_SAY)
        end,

        onEnd = function(playerArg)
            -- NOTE: This could be used to release a locked player,
            playerArg:PrintToPlayer("Sub-Menu 2 Closing", xi.msg.channel.NS_SAY)
        end,
    }

    local subMenuThree =
    {
        title = "Sub-Menu 3",

        onStart = function(playerArg)
            playerArg:PrintToPlayer("Main Sub-menu 3 Opening", xi.msg.channel.NS_SAY)
        end,

        options =
        {
            {
                "Sub-Menu 3, Option 1",
                function(playerArg)							
                    playerArg:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                end,
            },
            {
                "Sub-Menu 3, Option 2",
                function(playerArg)							
                    playerArg:PrintToPlayer("Option 2 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                end,
            },
            {
                "Sub-Menu 3, Option 3",
                function(playerArg)		
                    playerArg:PrintToPlayer("Option 3 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                end,
            },
        },

        onCancelled = function(playerArg)
            playerArg:PrintToPlayer("Sub-Menu 3 Cancelled", xi.msg.channel.NS_SAY)
        end,

        onEnd = function(playerArg)
            -- NOTE: This could be used to release a locked player,
            playerArg:PrintToPlayer("Sub-Menu 3 Closing", xi.msg.channel.NS_SAY)
        end,
    }

    player:customMenu(mainMenu)
end