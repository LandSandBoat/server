-------------------------------------------
-- Escha RuAun Portal NPC'select
-------------------------------------------
require("modules/module_utils")
require("scripts/globals/items")
require("scripts/globals/treasure")
require("scripts/globals/zone")
-------------------------------------------
local m = Module:new("Eschan_Portal")

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#1.onTrigger", function(player, npc)
local GodsWin = (player:getCharVar("[Eschan]Byakko") == 1) and (player:getCharVar("[Eschan]Suzaku") == 1) and
				(player:getCharVar("[Eschan]Genbu") == 1) and (player:getCharVar("[Eschan]Seiryu") == 1) 

local menu =
    {
        title = "Choose your destination",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Where would you like to go?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Suzaku's Nest",
                function(playerarg)
                    player:PrintToPlayer("Electricty begins surging through your body!!", xi.msg.channel.NS_SAY)
    			    player:injectActionPacket(6, 600, 0, 0, 0)

    			    player:timer(2000, function(playerArg)
                        player:setPos(-454.030, -3.626, -147.184)
					end)

    		        player:timer(2750, function(playerArg)
						player:injectActionPacket(6, 602, 0, 0, 0)
					end)
                end,
            },
            {
                "Byakko's Pride",
                function(playerArg)
                    player:PrintToPlayer("Electricty begins surging through your body!!", xi.msg.channel.NS_SAY)
    			    player:injectActionPacket(6, 600, 0, 0, 0)

    			    player:timer(2000, function(playerArg)
                        player:setPos(-280.484, -3.626, 386.104, 36)
					end)

    		        player:timer(2750, function(playerArg)
						player:injectActionPacket(6, 602, 0, 0, 0)
					end)
                end,
            },
            {
                "Genbu's Cove",
                function(playerArg)
                    player:PrintToPlayer("Electricty begins surging through your body!!", xi.msg.channel.NS_SAY)
    			    player:injectActionPacket(6, 600, 0, 0, 0)

    			    player:timer(2000, function(playerArg)
                        player:setPos(278.092, -3.998, 382.416, 88)
					end)

    		        player:timer(2750, function(playerArg)
						player:injectActionPacket(6, 602, 0, 0, 0)
					end)
                end,
            },
            {
                "Seiryu's Shadows",
                function(playerArg)
                    player:PrintToPlayer("Electricty begins surging through your body!!", xi.msg.channel.NS_SAY)
    			    player:injectActionPacket(6, 600, 0, 0, 0)

    			    player:timer(2000, function(playerArg)
                        player:setPos(451.753, -3.790, -146.248, 141)
					end)

    		        player:timer(2750, function(playerArg)
						player:injectActionPacket(6, 602, 0, 0, 0)
					end)
                end,
            },
            {
                "???",
                function(playerArg)
                    player:PrintToPlayer("Electricty begins surging through your body!!", xi.msg.channel.NS_SAY)
       			    player:injectActionPacket(6, 600, 0, 0, 0)
   
       			    player:timer(2000, function(playerArg)
                        player:setPos(-1.626, -52.365, -583.528, 65)
   					end)
   
       		        player:timer(2750, function(playerArg)
   						player:injectActionPacket(6, 602, 0, 0, 0)
   					end)
				end,
            },

        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#2.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes, take me back.",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No, I'm not finished yet!",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#3.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#4.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#5.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#6.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#7.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#8.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#9.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#10.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)

end)

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#11.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#12.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)


m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#13.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)

m:addOverride("xi.zones.Escha_RuAun.npcs.Eschan_Portal_#15.onTrigger", function(player, npc)
local menu =
    {
        title = "Return to Entrance?",
        onStart = function(playerArg)
            -- playerArg:PrintToPlayer("Would you like to go back?", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Yes",
                function(playerarg)
                    player:injectActionPacket(6, 600, 0, 0, 0)
	    
                    player:timer(2000, function(playerArg)
                       player:setPos(-0.371, -34.278, -466.980, 192)
                    end)
	    
                    player:timer(2750, function(playerArg)
                        player:injectActionPacket(6, 602, 0, 0, 0)
                    end)
                end,
            },
            {
                "No",
                function(playerArg)

                end,
            },
        },
        onCancelled = function(playerArg)
        end,
        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end)

return m
