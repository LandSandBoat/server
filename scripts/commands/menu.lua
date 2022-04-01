-----------------------------------
-- func: menu
-- desc: Shows a basic test menu with three options
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    player:customMenu({ "Test Menu (Play Effect)",
        { "Option 1: Hearts", function(playerArg)
            playerArg:PrintToPlayer("Option 1 Selected", xi.msg.channel.NS_SAY)
            playerArg:independentAnimation(playerArg, 251, 4) -- Hearts
        end },
        { "Option 2: Music Notes", function(playerArg)
            playerArg:PrintToPlayer("Option 2 Selected", xi.msg.channel.NS_SAY)
            playerArg:independentAnimation(playerArg, 252, 4) -- Music Notes
        end },
        { "Option 3: Lightbulb", function(playerArg)
            playerArg:PrintToPlayer("Option 3 Selected", xi.msg.channel.NS_SAY)
            playerArg:independentAnimation(playerArg, 250, 4) -- Lightbulb
        end },
    })
end
