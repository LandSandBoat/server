-----------------------------------
-- Area: Norg
--  NPC: Nolan
-- Escha Beads Exchange NPC
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Set item cost here.
    local itemCostMenuOne   =    250
	local itemCostMenuTwo   =   7500
    local itemCostMenuThree =  15000
    local itemCostMenuFour  =  25000
    local itemCostMenuFive  =  50000
    local itemCostMenuSix   =  50000
    local itemCostMenuSeven =  50000

    -- Player beads balance.
    local beadsBalance = player:getCurrency("escha_beads")

    -- Inventory check.
    if player:getFreeSlotsCount() == 0 then
        player:PrintToPlayer("Please come back after sorting your inventory.")
        return
    end

    -- Set up for weaponskill unlocks from Atori-Tutori (Ru'Lude Gardens)
    if player:getCharVar("PaidForMeritWs") == 2 then shijinSpiralAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 3 then exenteratorAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 4 then requiescatAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 5 then resolutionAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 6 then ruinatorAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 7 then upheavalAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 8 then entropyAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 9 then stardiverAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 10 then bladeShunAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 11 then tachiShohaAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 12 then realmrazerAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 13 then shattersoulAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 14 then apexArrowAvailable = 1
	elseif player:getCharVar("PaidForMeritWs") == 15 then lastStandAvailable = 1
	end
	
    -- Print Beads balance
    player:PrintToPlayer(string.format("You have %s escha beads available to spend. Choose wisely.", beadsBalance), 0xD)

    -- Menu 1
    if
        npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and
        beadsBalance >= itemCostMenuOne
    then            
        local menu =
        {
            title = "Consumables:",

            onStart = function(playerArg)
                -- NOTE: This could be used to lock the player in place
                -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
            end,

            options =
            {
                {
                    "Pearlscale (grants Elvorseal)",
                    function(playerArg)
                        player:setCurrency("escha_beads", beadsBalance - itemCostMenuOne)
                        playerArg:addItem(5714)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 5714)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,
            
            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Nolan: See you again!", xi.msg.channel.NS_SAY)
            end,
        }

        player:customMenu(menu)    

	-- Menu 2
    elseif
        npcUtil.tradeHasExactly(trade, {{ 'gil', 2 }}) and
        beadsBalance >= itemCostMenuTwo
    then            
        local menu =
        {
            title = "Basic items:",

            onStart = function(playerArg)
                -- NOTE: This could be used to lock the player in place
                -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
            end,

            options =
            {
                {
                    "Teleport ring: Holla",
                    function(playerArg)
                        player:setCurrency("escha_beads", beadsBalance - itemCostMenuTwo)
                        player:addItem(14661)
                        playerArg:PrintToPlayer("Here's your Craftmaster's ring. Thanks for being a loyal player, we appreciate you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Teleport ring: Mea",
                    function(playerArg)                         
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuTwo)
                        playerArg:addItem(14663)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 14663)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Teleport ring: Dem",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuTwo)
                        playerArg:addItem(14662)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 14662)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,
            
            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Nolan: See you again!", xi.msg.channel.NS_SAY)
            end,
        }
        
        player:customMenu(menu)

    -- Menu 3
    elseif
        npcUtil.tradeHasExactly(trade, {{ 'gil', 3 }}) and
        beadsBalance >= itemCostMenuThree
    then
        local menu =
        {
            title = "Equipment:",

            onStart = function(playerArg)
                -- NOTE: This could be used to lock the player in place
                -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
            end,

            options =
            {
                {
                    "Emico mantle",
                    function(playerArg)
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuThree)
                        playerArg:addItem(27597)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 27597)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Crested torque",
                    function(playerArg)                         
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuThree)
                        playerArg:addItem(28349)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 28349)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Setae ring",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuThree)
                        playerArg:addItem(28529)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 28529)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Megasco earring",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuThree)
                        playerArg:addItem(28488)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 28488)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Salire belt",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuThree)
                        playerArg:addItem(28425)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 28425)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Charitoni Sling",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuThree)
                        playerArg:addItem(21347)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 21347)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Dew silk cape",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuThree)
                        playerArg:addItem(27598)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 27598)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Adsilio boots",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuThree)
                        playerArg:addItem(28271)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 28271)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,

            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Nolan: See you again!", xi.msg.channel.NS_SAY)
            end,
        }

        player:customMenu(menu)

    -- Menu 4
    elseif
        npcUtil.tradeHasExactly(trade, {{ 'gil', 4 }}) and
        beadsBalance >= itemCostMenuFour
    then        
        local menu =
        {
            title = "Equipment +1:",

            onStart = function(playerArg)
                -- NOTE: This could be used to lock the player in place
                -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
            end,

            options =
            {
                {
                    "Dew Silk Cape +1",
                    function(playerArg)
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuFour)
                        playerArg:addItem(27599)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 27599)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Adsilio Boots +1",
                    function(playerArg)                         
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuFour)
                        playerArg:addItem(28272)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 28272)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,

            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Nolan: See you again!", xi.msg.channel.NS_SAY)
            end,
        }

        player:customMenu(menu)
 
    -- Menu 5
    elseif 
        npcUtil.tradeHasExactly(trade, {{ 'gil', 5 }}) and
        beadsBalance >= itemCostMenuFive
    then
        local menu =
        {
            title = "Weaponskills (pg. 1):",

            onStart = function(playerArg)
                -- NOTE: This could be used to lock the player in place
                -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
            end,

            options =
            {
                {
                    "Apex Arrow (Bow)",
                    function(playerArg)
                        if apexArrowAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuFive)
                            playerArg:setCharVar("hasApexArrowUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Apex Arrow\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
                {
                    "Blade: Shun (Katana)",
                    function(playerArg)                         
                        if bladeShunAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuFive)
                            playerArg:setCharVar("hasBladeShunUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Blade: Shun\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
                {
                    "Entropy (Scythe)",
                    function(playerArg)     
                        if entropyAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuFive)
                            playerArg:setCharVar("hasEntropyUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Entropy\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
                {
                    "Exenterator (Dagger)",
                    function(playerArg)                         
                        if exenteratorAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuFive)
                            playerArg:setCharVar("hasExenteratorUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Exenterator\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
                {
                    "Last Stand (Gun)",
                    function(playerArg)                         
                        if lastStandAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuFive)
                            playerArg:setCharVar("hasLastStandUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Last Stand\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
                {
                    "Realmrazer (Club)",
                    function(playerArg)                         
                        if realmrazerAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuFive)
                            playerArg:setCharVar("hasRealmrazerUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Realmrazer\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,

            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Nolan: See you again!", xi.msg.channel.NS_SAY)
            end,
        }

        player:customMenu(menu)

    -- Menu 6            
    elseif
        npcUtil.tradeHasExactly(trade, {{ 'gil', 6 }}) and
        beadsBalance >= itemCostMenuSix
    then
        local menu =
        {
            title = "Weaponskills (pg. 2):",

            onStart = function(playerArg)
                -- NOTE: This could be used to lock the player in place
                -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
            end,

            options =
            {
                {
                    "Requiescat (Sword)",
                    function(playerArg)                         
                        if requiescatAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuSix)
                            playerArg:setCharVar("hasRequiescatUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Requiescat\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
                {
                    "Resolution (Great Sword)",
                    function(playerArg)                         
                        if resolutionAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuSix)
                            playerArg:setCharVar("hasResolutionUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Resolution\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
                {
                    "Ruinator (Axe)",
                    function(playerArg)                         
                        if ruinatorAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuSix)
                            playerArg:setCharVar("hasRuinatorUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Ruinator\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
                {
                    "Shattersoul (Staff)",
                    function(playerArg)                         
                        if shattersoulAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuSix)
                            playerArg:setCharVar("hasShattersoulUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Shattersoul\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
                {
                    "Shijin Spiral: (H2H)",
                    function(playerArg)                         
                        if shijinSpiralAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuSix)
                            playerArg:setCharVar("hasShijinSpiralUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Shijin Spiral\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
                {
                    "Stardiver (Polearm)",
                    function(playerArg)                         
                        if stardiverAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuSix)
                            playerArg:setCharVar("hasStardiverUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Stardiver\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,

            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Nolan: See you again!", xi.msg.channel.NS_SAY)
            end,
        }

        player:customMenu(menu)         

    -- Menu 7            
    elseif
        npcUtil.tradeHasExactly(trade, {{ 'gil', 7 }}) and
        beadsBalance >= itemCostMenuSeven
    then
        local menu =
        {
            title = "Weaponskills (pg. 3):",

            onStart = function(playerArg)
                -- NOTE: This could be used to lock the player in place
                -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
            end,

            options =
            {
                {
                    "Tachi: Shoha (Great Katana)",
                    function(playerArg)                         
                        if tachiShohaAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuSeven)
                            playerArg:setCharVar("hasTachiShohaUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Tachi: Shoha\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
                {
                    "Upheaval (Great Axe)",
                    function(playerArg)                         
                        if upheavalAvailable == 1 then				
						    playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuSeven)
                            playerArg:setCharVar("hasUpheavalUnlock", 1)
							playerArg:PrintToPlayer("Congratulations! You have unlocked \"Upheaval\"!")
						else
						    playerArg:PrintToPlayer("Nolan: Whoa, buddy! You still have some work to do before we can discuss this.", xi.msg.channel.NS_SAY)
						end
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,

            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Nolan: See you again!", xi.msg.channel.NS_SAY)
            end,
        }

        player:customMenu(menu)
    end
end

entity.onTrigger = function(player, npc)
    local beadsBalance = player:getCurrency("escha_beads")

    player:PrintToPlayer("Greetings adventurer! I'll be happy to exchange your escha beads for various equipment and unlocks.", 0xD)
    player:PrintToPlayer("Trade me the requested gil amount and I will present you with the corresponding menu!", 0xD)
    player:PrintToPlayer("1. Consumables (250), 2. Basic items (7,500), 3. Equipment (15,000), 4. Equipment +1 (25,000)", 28)
    player:PrintToPlayer("5. Weaponskills (page. 1), 6. Weaponskills (page 2), 7. Weaponskills (page 3)", 28)
    player:PrintToPlayer("All weaponskills cost 50,000 escha beads!", 28)
    player:PrintToPlayer(string.format("You have %s escha beads available to spend. Choose wisely.", beadsBalance), 0xD)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
