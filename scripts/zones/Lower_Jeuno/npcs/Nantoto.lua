-----------------------------------
-- Area: Lower Jeuno
--  NPC: Hunter (Nantoto)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("LoyaltyRewardObtained") ~= 1 then
        local menu =
        {
            title = "Loyaly Rewards",
            onStart = function(playerArg)
                -- NOTE: This could be used to lock the player in place
                playerArg:PrintToPlayer("Choose your loyalty reward:", xi.msg.channel.NS_SAY)
            end,
            options =
            {
                {
                    "Option 1: Craftmaster's ring",
                    function(playerArg)
                        player:setCharVar("LoyaltyRewardObtained", 1)
	    				playerArg:PrintToPlayer("Here's your Craftmaster's ring. Thanks for being a loyal player, we appreciate you!", xi.msg.channel.NS_SAY)
						playerArg:independentAnimation(playerArg, 251, 4) -- Hearts
	    				player:addItem(28586)
                    end,
                },
                {
                    "Option 2: Anniversary ring",
                    function(playerArg)
                        player:setCharVar("LoyaltyRewardObtained", 1)
	    				playerArg:PrintToPlayer("Here's your Anniversary ring. Thanks for being a loyal player, we appreciate you!", xi.msg.channel.NS_SAY)
	    				playerArg:independentAnimation(playerArg, 251, 4) -- Hearts
	    				player:addItem(15793)
                    end,
                },
            },
            onCancelled = function(playerArg)
     --           playerArg:PrintToPlayer("Test Menu Cancelled", xi.msg.channel.NS_SAY)
            end,
            onEnd = function(playerArg)
                -- NOTE: This could be used to release a locked player,
            --    playerArg:PrintToPlayer("Test Menu Closing", xi.msg.channel.NS_SAY)
            end,
        }
        player:customMenu(menu)
	else
	    player:PrintToPlayer("You've already selected a reward you greedy punk!")
	end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
