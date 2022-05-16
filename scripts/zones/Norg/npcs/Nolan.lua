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
    local itemCostMenuOne   =  15000
    local itemCostMenuTwo   =  35000
    local itemCostMenuThree =  50000
    local itemCostMenuFour  = 100000
    local itemCostMenuFive  = 100000
    local itemCostMenuSix   = 100000

    -- Player beads balance.
    local beadsBalance = player:getCurrency("escha_beads")

    -- Inventory check.
    if player:getFreeSlotsCount() == 0 then
        player:PrintToPlayer("Please come back after sorting your inventory.")
        return
    end

    player:PrintToPlayer(string.format("You have %s escha beads available to spend. Choose wisely.", beadsBalance), 0xD)

    -- Menu 1
    if
        npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }}) and
        beadsBalance >= itemCostMenuOne
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
                        player:setCurrency("escha_beads", beadsBalance - itemCostMenuOne)
                        player:addItem(14661)
                        playerArg:PrintToPlayer("Here's your Craftmaster's ring. Thanks for being a loyal player, we appreciate you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Teleport ring: Mea",
                    function(playerArg)                         
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuOne)
                        playerArg:addItem(14663)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 14663)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Teleport ring: Dem",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuOne)
                        playerArg:addItem(14662)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 14662)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,
            
            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Thank you for your purchase! Keep up the good fight!", xi.msg.channel.NS_SAY)
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
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuTwo)
                        playerArg:addItem(27597)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 27597)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Crested torque",
                    function(playerArg)                         
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuTwo)
                        playerArg:addItem(28349)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 28349)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Setae ring",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuTwo)
                        playerArg:addItem(28529)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 28529)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Megasco earring",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuTwo)
                        playerArg:addItem(28488)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 28488)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Salire belt",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuTwo)
                        playerArg:addItem(28425)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 28425)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Charitoni Sling",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuTwo)
                        playerArg:addItem(21347)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 21347)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Dew silk cape",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuTwo)
                        playerArg:addItem(27598)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 27598)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Adsilio boots",
                    function(playerArg)     
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuTwo)
                        playerArg:addItem(28271)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 28271)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,

            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Thank you for your purchase! Keep up the good fight!", xi.msg.channel.NS_SAY)
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
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuThree)
                        playerArg:addItem(27599)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 27599)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Adsilio Boots +1",
                    function(playerArg)                         
                        playerArg:setCurrency("escha_beads", beadsBalance - itemCostMenuThree)
                        playerArg:addItem(28272)
                        playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 28272)
                        playerArg:PrintToPlayer("Nolan: Pleasure doing business with you!", xi.msg.channel.NS_SAY)
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,

            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Thank you for your purchase! Keep up the good fight!", xi.msg.channel.NS_SAY)
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
                        playerArg:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Blade: Shun (Katana)",
                    function(playerArg)                         
                        playerArg:PrintToPlayer("Option 2 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Entropy (Scythe)",
                    function(playerArg)     
                        playerArg:PrintToPlayer("Option 3 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Exenterator (Dagger)",
                    function(playerArg)                         
                        playerArg:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Last Stand (Gun)",
                    function(playerArg)                         
                        playerArg:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Realmrazer (Club)",
                    function(playerArg)                         
                        playerArg:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,

            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Thank you for your purchase! Keep up the good fight!", xi.msg.channel.NS_SAY)
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
                        playerArgFive:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Resolution (Great Sword)",
                    function(playerArg)                         
                        playerArgFive:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Ruinator (Axe)",
                    function(playerArg)                         
                        playerArgFive:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Shattersoul (Staff)",
                    function(playerArg)                         
                        playerArgFive:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Shijin Spiral: (H2H)",
                    function(playerArg)                         
                        playerArgFive:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Stardiver (Polearm)",
                    function(playerArg)                         
                        playerArgFive:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,

            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Thank you for your purchase! Keep up the good fight!", xi.msg.channel.NS_SAY)
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
                        playerArg:PrintToPlayer("Option 1 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
                {
                    "Upheaval (Great Axe)",
                    function(playerArg)                         
                        playerArg:PrintToPlayer("Option 2 of sub-menu 3 selected.", xi.msg.channel.NS_SAY)
                    end,
                },
            },

            onCancelled = function(playerArg)
            end,

            onEnd = function(playerArg)
                playerArg:PrintToPlayer("Thank you for your purchase! Keep up the good fight!", xi.msg.channel.NS_SAY)
            end,
        }

        player:customMenu(menu)
    end
end

entity.onTrigger = function(player, npc)
    local beadsBalance = player:getCurrency("escha_beads")

    player:PrintToPlayer("Greetings adventurer! I'll be happy to exchange your escha beads for various equipment and unlocks.", 0xD)
    player:PrintToPlayer("Trade me the requested gil amount and I will present you with the corresponding menu!", 0xD)
    player:PrintToPlayer("1. Basic items (15,000), 2. Equipment (35,000), 3. Equipment +1 (50,000)", 28)
    player:PrintToPlayer("4. Weaponskills (page. 1), 5. Weaponskills (page 2), 6. Weaponskills (page 3)", 28)
    player:PrintToPlayer("All weaponskills cost 100,000 escha beads!", 28)
    player:PrintToPlayer(string.format("You have %s escha beads available to spend. Choose wisely.", beadsBalance), 0xD)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
