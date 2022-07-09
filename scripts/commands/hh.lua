-----------------------------------
-- func: !npc
-- desc: Test dynamic entity before its placed into a module for testing.
-- note: Will spawn after you move from your current position
-----------------------------------
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    local tabs = player:getCurrency("valor_point")
    local zone = player:getZone()

    local menu =
    {
        title = "Accept Buffs?",
        onStart = function(playerArg)
            -- NOTE: This could be used to lock the player in place
            playerArg:PrintToPlayer("Would you like a \"Helping Hand\" for 5,000 tabs? ", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerArg)
                    if tabs > 5000 then 
                        player:setCurrency("valor_point", tabs - 5000)
                        playerArg:PrintToPlayer("Enjoy your buffs!", xi.msg.channel.NS_SAY)
                        player:addStatusEffect(xi.effect.REGAIN, 5, 0, 7200)
                        player:addStatusEffect(xi.effect.REGEN, 15, 0, 7200)
                        player:addStatusEffect(xi.effect.REFRESH, 10, 0, 7200)
                        player:addStatusEffect(xi.effect.HASTE, 3, 0, 7200)
                    else
                        playerArg:PrintToPlayer("You do not possess enough tabs.", 0xD)
                    end
                end,
            },
            {
                "No",
                function(playerArg)
                    playerArg:PrintToPlayer("You can always come back if you need a little boost!", xi.msg.channel.NS_SAY)
                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    
	player:customMenu(menu)
    player:PrintToPlayer(string.format("You currently have %i tabs available.", tabs), 0xD)
end