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
                                function(playerArgOne)							
                                    playerArgOne:PrintToPlayer("Option 1 of sub-menu 1 selected.", xi.msg.channel.NS_SAY)
                                end,
                            },
                            {
                                "Sub-Menu 1, Option 2",
                                function(playerArgOne)							
                                    playerArgOne:PrintToPlayer("Option 2 of sub-menu 1 selected.", xi.msg.channel.NS_SAY)
                                end,
                            },
                            {
                                "Sub-Menu 1, Option 3",
                                function(playerArgOne)		
                                    playerArgOne:PrintToPlayer("Option 3 of sub-menu 1 selected.", xi.msg.channel.NS_SAY)
                                end,
                            },
                        },
                    }

                    playerArg:customMenu(subMenuOne)
                end,
            },
            {
                "Open Sub-menu 2",
                function(playerArg)							
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
                                function(playerArgTwo)							
                                    playerArgTwo:PrintToPlayer("Option 1 of sub-menu 2 selected.", xi.msg.channel.NS_SAY)
                                end,
                            },
                            {
                                "Sub-Menu 2, Option 2",
                                function(playerArgTwo)							
                                    playerArgTwo:PrintToPlayer("Option 2 of sub-menu 2 selected.", xi.msg.channel.NS_SAY)
                                end,
                            },
                            {
                                "Sub-Menu 2, Option 3",
                                function(playerArgTwo)		
                                    playerArgTwo:PrintToPlayer("Option 3 of sub-menu 2 selected.", xi.msg.channel.NS_SAY)
                                end,
                            },
                        },
                    }

                    playerArg:customMenu(subMenuTwo)
                end,
            },
            {
                "Open Sub-menu 3",
                function(playerArg)		
                    local subMenuThree =
                    {
                        title = "Sub-Menu 3",

                        onStart = function(playerArg)
                            playerArg:PrintToPlayer("Main Sub menu 3 Opening", xi.msg.channel.NS_SAY)
                        end,

                        options =
                        {
                            {
                                "Sub-Menu 3, Option 1",
                                function(playerArgThree)							
                                    playerArgThree:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                                end,
                            },
                            {
                                "Sub-Menu 3, Option 2",
                                function(playerArgThree)							
                                    playerArgThree:PrintToPlayer("Option 2 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                                end,
                            },
                            {
                                "Sub-Menu 3, Option 3",
                                function(playerArgThree)		
                                    playerArgThree:PrintToPlayer("Option 3 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                                end,
                            },
                        },
                    }
                    playerArg:customMenu(subMenuThree)
                end,
            },
        },
    }

    player:customMenu(mainMenu)
end
