------------------------------------
-- CatsEyeXI Custom NPCs
------------------------------------
-- RUN/GEO Custom Artifact Quests --
------------------------------------
require("modules/module_utils")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require('scripts/globals/spell_data')
require("scripts/globals/status")
------------------------------------
local m = Module:new("run_geo_quests")

---------------------------------------------
--               RUN UNLOCK                --
---------------------------------------------
m:addOverride("xi.zones.RuLude_Gardens.Zone.onInitialize", function(zone)
    -- Call the zone's original function for onInitialize
    super(zone)
    
    local volgoi = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "Volgoi",
        look     = "0x01000D0856115621963056419650006000700000",
        x        =   3.544,
        y        =   2.000,
        z        = 126.997,
        rotation =      78,
        widescan =       1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            local runVar = player:getCharVar("[RUN]Unlocked")

            -- Unlock job if conditions are met.
            if player:hasSpell(xi.magic.spell.MAAT) and runVar == 0 then
                player:PrintToPlayer("Volgoi: With the powers channeled through Altana, I now pronounce you a Rune Fencer!", 0xD)

                npc:timer(200, function(npcArg)
                    player:setAnimation(101)
                end)

                npc:timer(1000, function(npcArg)
                    if npcUtil.giveItem(player, 5102) then -- Scroll of Foil
                        npcUtil.giveKeyItem(player, xi.ki.JOB_GESTURE_RUNE_FENCER)
                        player:unlockJob(xi.job.RUN)
                        player:setCharVar("[RUN]Unlocked", 1)
                    else
                        player:PrintToPlayer("Volgoi: Something is wrong... Are you carrying too many stuff?", 0xD)
                    end

                    player:setAnimation(0)
                end)

            -- Already unlocked job.
            elseif runVar == 1 then
                player:PrintToPlayer("Volgoi: Never tell how you got this power. Just don't.", 0xD)

            -- Default dialog.
            else
                player:PrintToPlayer("Volgoi: Think you got what it takes to become a Rune Fencer?", 0xD)
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("Volgoi: I need to see some evidence of your mastery over Maat\'s alter ego first!", 0xD)
                end)
            end
        end,
    })

    utils.unused(volgoi)
end)

---------------------------------------------
--                GEO UNLOCK               --
---------------------------------------------
m:addOverride("xi.zones.RuLude_Gardens.Zone.onInitialize", function(zone)
    -- Call the zone's original function for onInitialize
    super(zone)
    
    local sylvie = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "Sylvie",
        look     = "0x0000180C00000000000000000000000000000000",
        x        = -3.956,
        y        = 2.000,
        z        = 126.656,
        rotation = 25,
        widescan = 1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            local geoVar = player:getCharVar("GEO_Unlocked")

            -- Already unlocked job. Open GEO shop.
            if geoVar == 1 then 
                local stock =
                {
                    6074,    1000,  -- Indi-Poison
                    6088,    3720,  -- Indi-Voidance
                    6087,   11400,  -- Indi-Precision
                    6073,   23350,  -- Indi-Regen
                    6090,   24250,  -- Indi-Attunement
                    6089,   66920,  -- Indi-Focus
                    6084,  109260,  -- Indi-Barrier
                    6075,  210000,  -- Indi-Refresh
                    6082,  210000,  -- Indi-CHR
                    6081,  239400,  -- Indi-MND
                    6083,  252700,  -- Indi-Fury
                    6080,  309120,  -- Indi-INT
                    6079,  326400,  -- Indi-AGI
                    6086,  340000,  -- Indi-Fend
                    6078,  337400,  -- Indi-VIT
                    6077,  364400,  -- Indi-DEX
                    6085,  320800,  -- Indi-Acumen
                    6076,  434600,  -- Indi-STR
                    6099,  434600,  -- Indi-Slow
                    6096,  418750,  -- Indi-Torpor
                    6095,  531600,  -- Indi-Slip
                    6098,  541850,  -- Indi-Languor
                    6100,  503040,  -- Indi-Paralysis
                    6097,  540000,  -- Indi-Vex
                    4916,   34000,  -- Fira
                    4924,   54600,  -- Thundara
                    4918,   46440,  -- Blizzara
                    4920,   26600,  -- Aerora
                    4922,   22490,  -- Stonera
                    4923,  256000,  -- Stonera_II
                    4926,   21000,  -- Watera
                    4927,  255000,  -- Watera_II
                }

                player:PrintToPlayer("Welcome to the Geomancer magic shop!", 0, npc:getPacketName())
                xi.shop.general(player, stock)

            -- Unlock job.if conditions are met.
            elseif player:hasSpell(xi.magic.spell.MAAT) and geoVar == 0 then
                player:PrintToPlayer("Sylvie: With the powers channeled through Altana, I now pronounce you a Geomancer!", 0xD)

                npc:timer(200, function(npcArg)
                    player:setAnimation(101)
                end)

                npc:timer(1000, function(npcArg)
                    if npcUtil.giveItem(player, 21460) then
                        npcUtil.giveKeyItem(player, xi.ki.LUOPAN)
                        npcUtil.giveKeyItem(player, xi.ki.JOB_GESTURE_GEOMANCER)
                        player:unlockJob(xi.job.GEO)
                        player:setCharVar("GEO_Unlocked", 1)
                    else
                        player:PrintToPlayer("Sylvie: Something is wrong... Are you carrying too many stuff?", 0xD)
                    end

                    player:setAnimation(0)
                end)

            -- Default dialog.
            else
                player:PrintToPlayer("Sylvie: Think you got what it takes to become a Geomancer?", 0xD)
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("Sylvie: I need to see some evidence of your mastery over Maat\'s alter ego first!", 0xD)
                end)
            end
        end,
    })

    utils.unused(sylvie)
end)

-- GEO AF Quest
m:addOverride("xi.zones.Bibiki_Bay.Zone.onInitialize", function(zone)
    local ID = require("scripts/zones/Bibiki_Bay/IDs")
    -- Call the zone's original function for onInitialize
    super(zone)
    
    local drunktaru = zone:insertDynamicEntity({  -- sell pup attachments
        objtype  = xi.objType.NPC,
        name     = "Drunk Taru",
        look     = "0x01000F0352115221523152415251006000700000",
        x        = 313.542,
        y        =  -2.850,
        z        = 170.185,
        rotation =      37,
        widescan =       1,

        onTrade = function(player, npc, trade)
            local isGEO = player:getMainJob() == xi.job.GEO and player:getJobLevel(xi.job.GEO) == 75
            local afProgress = player:getCharVar("[GEO]AF_Progress")

            if isGEO then 
                npc:setRotation(player:getRotPos() + 127)
                -- AF1 (Feet)
                if afProgress < 1 and npcUtil.tradeHasExactly(trade, 5714) then  -- pearlscale
                    player:tradeComplete()
                    player:PrintToPlayer(string.format("Drunk Taru: My savior! How could I ever repay you? I'm going to get this pearlscale to Koru-Moru right away!"), 0xD)

                    npc:timer(2000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Oh, your reward?"), 0xD)
                    end)

                    npc:timer(4000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: ..."), 0xD)
                    end)

                    npc:timer(6000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: ..."), 0xD)
                    end)

                    npc:timer(8000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: I always get myself into trouble when I drink, but I guess a deal is a deal!"), 0xD)
                    end)

                    npc:timer(10000, function(npcArg)
                        player:setCharVar("[GEO]AF_Progress", 1)
                        player:addItem(28346) -- Geomancy Sandals
                        player:messageSpecial(ID.text.ITEM_OBTAINED, 28346)
                    end)

                    npc:timer(12000, function(npcArg)
                        npc:setRotation(player:getRotPos() + 1)
                    end)

                    -- End AF1 (Feet) -- Start AF2 (Hands)

                elseif afProgress == 1 and npcUtil.tradeHasExactly(trade, 1406) then -- seal_of_byakko
                    player:tradeComplete()
                    player:PrintToPlayer(string.format("Drunk Taru: Wow! You're not as dumb as you look."), 0xD)

                    npc:timer(2000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Yes, this seal should do, this should do juuuuuust f..."), 0xD)
                    end)

                    npc:timer(4000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Let me guess, you want your reward now? dang nabbit!"), 0xD)
                    end)

                    npc:timer(6000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Whatever happened to doing things from the goodness of your heart??"), 0xD)
                    end)

                    npc:timer(8000, function(npcArg)
                        player:setCharVar("[GEO]AF_Progress", 2)
                        player:addItem(28066) -- Geomancy Mitaines
                        player:messageSpecial(ID.text.ITEM_OBTAINED, 28066)
                    end)

                    npc:timer(10000, function(npcArg)
                        npc:setRotation(player:getRotPos() + 1)
                    end)

                -- End AF2 (Hands) -- Start AF3 (Head)

                elseif afProgress == 2 and npcUtil.tradeHasExactly(trade, 576) then -- sirens_tear
                    player:tradeComplete()
                    player:PrintToPlayer(string.format("Drunk Taru: I'm beginning to think I may have underestimated you, Albert."), 0xD)

                    npc:timer(2000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: I've been saving this to give to someone special..."), 0xD)
                    end)

                    npc:timer(4000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: ..."), 0xD)
                    end)

                    npc:timer(6000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: That someone special never came, so I guess you can have it."), 0xD)
                    end)

                    npc:timer(8000, function(npcArg)
                        player:setCharVar("[GEO]AF_Progress", 3)
                        player:addItem(27786) -- Geomancy Galero
                        player:messageSpecial(ID.text.ITEM_OBTAINED, 27786)
                    end)

                    npc:timer(10000, function(npcArg)
                        npc:setRotation(player:getRotPos() + 1)
                    end)

                -- End AF3 (Head) -- Start AF4 (Pants)

                elseif afProgress == 3 and npcUtil.tradeHasExactly(trade, 2704) then -- square_of_oil-soaked_cloth
                    player:tradeComplete()
                    player:PrintToPlayer(string.format("Drunk Taru: Mmmm.... yass... that's the spot!"), 0xD)

                    npc:timer(2000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Don't be shy, squirt some more on there!"), 0xD)
                    end)

                    npc:timer(4000, function(npcArg)
                        player:PrintToPlayer("\129\153\129\154 Drunk Taru falls asleep... \129\153\129\154")
                    end)

                    npc:timer(6000, function(npcArg)
                        player:PrintToPlayer(string.format("You sneakily grab your reward and inch away ..."), 0xD)
                    end)

                    npc:timer(8000, function(npcArg)
                        player:setCharVar("[GEO]AF_Progress", 4)
                        player:addItem(28206) -- Geomancy Pants
                        player:messageSpecial(ID.text.ITEM_OBTAINED, 28206)
                    end)

                    npc:timer(10000, function(npcArg)
                        npc:setRotation(player:getRotPos() + 1)
                    end)
                end

                npc:setRotation(37)

            end
        end,

        onTrigger = function(player, npc)
            local isGEO      = player:getMainJob() == xi.job.GEO and player:getJobLevel(xi.job.GEO) == 75
            local afProgress = player:getCharVar("[GEO]AF_Progress")

            -- First AF Piece (Feet)    
            if isGEO then 
                npc:setRotation(player:getRotPos() + 127)
                if afProgress < 1 then
                    player:PrintToPlayer(string.format("Drunk Taru: My faaaaavorite drinking buddy-wuddy! Let's get some mead! Let me just get my sho..."), 0xD)

                    npc:timer(2000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Oh no! Have you seen my shoes? I could have sworn I left them by the ledge."), 0xD)
                    end)

                    npc:timer(4000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Yep! There they are... swimming away..."), 0xD)
                    end)

                    npc:timer(6000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Ugh! It took me forever to have those made. They're made from the rare fish, pearlscale."), 0xD)
                    end)

                    npc:timer(8000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Would you be a sweetheart and fetch me a new \"pearlscale\"? I promise-womise to make it worth your while!"), 0xD)
                    end)

                    npc:timer(10000, function(npcArg)
                        npc:setRotation(player:getRotPos() + 1)
                    end)

                -- End Feet -- Start Hands
                elseif afProgress == 1 then
                    player:PrintToPlayer(string.format("Drunk Taru: Buuuuuuurrrp! Let me guess, someone stole your sweetroll?"), 0xD)

                    npc:timer(2000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: That's too bad, now listen here Albert..."), 0xD)
                    end)

                    npc:timer(4000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: I just got into a little scuffle at the pub, and shredded my new tiger mitts!"), 0xD)
                    end)

                    npc:timer(6000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: I don't suppose you'd snag a \"Seal of Byakko\" for me, so I could have a new pair made?"), 0xD)
                    end)

                    npc:timer(8000, function(npcArg)
                        player:PrintToPlayer(string.format("*Drunk Taru staggers*"), 0xD)
                    end)

                    npc:timer(10000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Go on now... git!"), 0xD)
                    end)

                    npc:timer(12000, function(npcArg)
                        npc:setRotation(player:getRotPos() + 1)
                    end)

                -- End Hands -- Start Head
                elseif afProgress == 2 then
                    player:PrintToPlayer(string.format("Drunk Taru: You wanna call yourself a Geomancer...?"), 0xD)
                    
                    npc:timer(2000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Oh you..."), 0xD)
                    end)
                    
                    npc:timer(4000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Don't cry Albert... It's OK to give up!"), 0xD)
                    end)
                    
                    npc:timer(6000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: I'll tell you what, bring me back a \"Siren's tear\" and I'll give you something that will make you feel better."), 0xD)
                    end)
                
                    npc:timer(8000, function(npcArg)
                        npc:setRotation(player:getRotPos() + 1)
                    end)

                -- End Head -- Start Legs

                elseif afProgress == 3 then
                    player:PrintToPlayer(string.format("Drunk Taru: Why do you hesitate?"), 0xD)

                    npc:timer(2000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Have we not done this time and time again?"), 0xD)
                    end)

                    npc:timer(4000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Oil me up, man!"), 0xD)
                    end)

                    npc:timer(6000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Fine, if you won't do it, give me the \"square of oil-soaked cloth\" and I'll do it myself!"), 0xD)
                    end)

                    npc:timer(8000, function(npcArg)
                        npc:setRotation(player:getRotPos() + 1)
                    end)

                -- End Legs -- Start Body

                -- Player has killed Sandworm
                elseif afProgress == 4 and player:hasTitle(xi.title.SANDWORM_WRANGLER) then 
                    local name = player:getName()
                    player:PrintToPlayer(string.format("Drunk Taru: You've come a long way, %s...", name), 0xD)

                    npc:timer(2000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: You should be proud to call yourself a Geomancer."), 0xD)
                    end)

                    npc:timer(4000, function(npcArg)
                        player:PrintToPlayer("\129\153\129\154 Congratulations! You have finished the Geomancer Artifact Quests! \129\154\129\153\n")
                    end)

                    npc:timer(6000, function(npcArg)
                        player:setCharVar("[GEO]AF_Progress", 5)
                        player:addItem(27926) -- Geomancy Tunic
                        player:messageSpecial(ID.text.ITEM_OBTAINED, 27926)
                    end)        

                    npc:timer(8000, function(npcArg)
                        npc:setRotation(player:getRotPos() + 1)
                    end)

                -- Fallback
                elseif afProgress == 4 then
                    player:PrintToPlayer(string.format("Drunk Taru: Albert... Come closer... I have a secret to tell you..."), 0xD)

                    npc:timer(2000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: The reason I've been so moody lately, is my pet Sandworm ran away."), 0xD)
                    end)

                    npc:timer(4000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: Won't you find him for me, Albert?"), 0xD)
                    end)

                    npc:timer(6000, function(npcArg)
                        player:PrintToPlayer(string.format("Drunk Taru: I promise-womise this is the last thing I'll ever ask of you!"), 0xD)
                    end)

                    npc:timer(8000, function(npcArg)
                        npc:setRotation(player:getRotPos() + 1)
                    end)
                end
            end
        end,
    })

    utils.unused(drunktaru)
    
end) 

-- RUN AF Quest
----------------------------------------------------------------------------------------------------
-- STEP 1: Rulude Gardens - West Minstrel ( [RUN]AFprog == 0 )
----------------------------------------------------------------------------------------------------

m:addOverride("xi.zones.RuLude_Gardens.Zone.onInitialize", function(zone)
    -- Call the zone's original function for onInitialize
    super(zone)

    -- Define NPC
    local runMinstrel = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "West Minstrel",
        look     = "0x0000CD0300000000000000000000000000000000",
        x        = -0.5,
        y        =    9,
        z        =  -38,
        rotation =  191,
        widescan =    1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            local progVar = player:getCharVar("[RUN]AFprog")

            -- Quest starting dialog.
            if player:getMainJob() == xi.job.RUN and player:getMainLvl() >= 40 and progVar == 0 then
                player:PrintToPlayer("That stance... I hadn't met a Rune Fencer I didn't knew by name in quite some time.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("Oh, don't be surprised, I can tell. I've seen Rune Fencers my whole life, back in Adoulin.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("This brings so many bittersweet memories from back home... Do you miss our homeland too, adventurer?", 0, npc:getPacketName())
                end)

                npc:timer(3100, function(npcArg)
                    local menu =
                    {
                        title = "Do you miss Adoulin?",

                        onStart = function(playerArg)
                        end,

                        options =
                        {
                            {
                                "I'm sorry, I'm not from Adoulin.",
                                function(playerArg)
                                    player:setCharVar("[RUN]AFprog", 1)

                                    player:PrintToPlayer("Wait, you aren't from Adoulin? But then how did you even became a Rune Fencer?", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("That's so strange... Do you even know what a Rune Fencer is or stands for?", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("And yet, here you are. What's that? Oh, sorry, I can't help you understand what a Runefencer is, but...", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("Travel to Gustaberg. There, somewhere, you will meet a man called Varado. He may be able to show you the path.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "I don't know what you are talking about.",
                                function(playerArg)
                                    player:setCharVar("[RUN]AFprog", 1)

                                    player:PrintToPlayer("Wait, you aren't from Adoulin? But then how did you even became a Rune Fencer?", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("That's so strange... Do you even know what a Rune Fencer is or stands for?", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("And yet, here you are. What's that? Oh, sorry, I can't help you understand what a Runefencer is, but...", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("Travel to Gustaberg. There, somewhere, you will meet a man called Varado. He may be able to show you the path.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "Get lost, beggar.",
                                function(playerArg)
                                    player:PrintToPlayer("What the... What's your problem you jerk!?", 0, npc:getPacketName())
                                end,
                            },
                        },

                        onCancelled = function(playerArg)
                            player:PrintToPlayer("Another time then.", 0, npc:getPacketName())
                        end,

                        onEnd = function(playerArg)
                        end,
                    }
                    player:customMenu(menu)
                end)

            -- Next step reminder.
            elseif progVar == 1 then
                player:PrintToPlayer("Adventurer, travel to Gustaberg if you want to follow the beaten path to the truth.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("I'm sorry, I don't know exactly where Varado is.", 0, npc:getPacketName())
                end)

            -- Quest active dialog. Prints the "progVar" variable in case there is a problem.
            elseif progVar > 1 and progVar < 8 then
                player:PrintToPlayer(string.format("West Minstrel: You have taken %s steps towards the truth.", progVar))

            -- Quest completed dialog.
            elseif progVar == 8 then
                player:PrintToPlayer("You stand high and mighty before my eyes, as a true Runefencer.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("But the beaten path before you is still long.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("Who knows? Maybe our paths will meet again, someday.", 0, npc:getPacketName())
                end)

            -- Default dialog.
            else
                player:PrintToPlayer("Toss a coin to your Minstrel, oh valley of plenty, oh valley of plenty, oh ho-HO!", 0, npc:getPacketName())
            end
        end,
    })

    -- Return NPC
    utils.unused(runMinstrel)
end)

----------------------------------------------------------------------------------------------------
-- STEP 2 and 4: South Gustaberg - Varado ([RUN]AFprog == 1, 2)
----------------------------------------------------------------------------------------------------

m:addOverride("xi.zones.South_Gustaberg.Zone.onInitialize", function(zone)
    -- Call the zone's original function for onInitialize
    super(zone)

    -- Define NPC
    local runVarado = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "Varado",
        look     = "0x0000440300000000000000000000000000000000",
        x        =  239.095,
        y        =  -60.067,
        z        = -438.943,
        rotation =      133,
        widescan =        1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            local progVar = player:getCharVar("[RUN]AFprog")

            -- Quest dialog.
            if player:getMainJob() == xi.job.RUN and progVar == 1 then
                player:PrintToPlayer("Revya, the minstrel, told me a Rune Fencer would come asking for help.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("I never thought I would see a new Runefencer after we were banished from our home.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("But our path isn't an easy one. It may cost you everything you have.", 0, npc:getPacketName())
                end)
                npc:timer(4500, function(npcArg)
                    player:PrintToPlayer("I ask you, do you really want to follow our path?", 0, npc:getPacketName())
                end)

                npc:timer(4600, function(npcArg)
                    local menu =
                    {
                        title = "Undertake the path to the truth.",

                        onStart = function(playerArg)
                        end,

                        options =
                        {
                            {
                                "Of course.",
                                function(playerArg)
                                    player:setCharVar("[RUN]AFprog", 2)

                                    player:PrintToPlayer("Then so be it. I will guide you through the same beaten path I once traveled.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("First bring me a Yahse wildflower petal. It's used to make special ink.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("Normally it would be our general who draws the rune on you, but I'll do just fine.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                       player:PrintToPlayer("I wish you luck, adventurer.", 0, npc:getPacketName())
                                    end)                
                                end,
                            },
                            {
                                "I'm having second thoughts...",
                                function(playerArg)
                                    player:PrintToPlayer("So you are not prepared? That's perfectly fine. Not everyone can be.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("You aren't even a real Rune Fencer. Not yet anyway.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("If you change your mind, come back here.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "Great, another beggar.",
                                function(playerArg)
                                    player:PrintToPlayer("Insolent fool...", 0, npc:getPacketName())
                                end,
                            },
                        },

                        onCancelled = function(playerArg)
                            player:PrintToPlayer("Something came up?", 0, npc:getPacketName())
                        end,

                        onEnd = function(playerArg)
                        end,
                    }
                    player:customMenu(menu)
                end)

            -- Find flower reminder.
            elseif progVar == 2 and not player:hasKeyItem(xi.ki.YAHSE_WILDFLOWER_PETAL) then
                player:PrintToPlayer("It's said the flower only grows where great battles were fought.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("If I had to guess, from what I heard...", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("Maybe Lufaise Meadows is a good place to start looking.", 0, npc:getPacketName())
                end)

            -- Turn in flower.
            elseif progVar == 2 and player:hasKeyItem(xi.ki.YAHSE_WILDFLOWER_PETAL) then
                player:PrintToPlayer("I can't believe you managed to find a flower from my land.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("Excellent, I'll prepare the ink. It will take a while though.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("And that is exactly what this rune represents: Patience, the first of the five virtues.", 0, npc:getPacketName())
                end)

                npc:timer(3100, function(npcArg)
                    local menu =
                    {
                        title = "The First Virtue",

                        onStart = function(playerArg)
                        end,

                        options =
                        {
                            {
                                "I'll come back later then.",
                                function(playerArg)
                                    player:setCharVar("[RUN]AFprog", 3)
                                    player:needToZone(true)
                                    player:delKeyItem(xi.ki.YAHSE_WILDFLOWER_PETAL)

                                    player:PrintToPlayer("Consider yourself lucky. In my land, you had to ask for an audience with the queen.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("It took months, since getting the first rune was a ceremony.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("Queen Remedi would be present, and in the company of Princess Sarah and Prince Gordon.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("And in front of them, the general would draw it in your skin.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "I sure hope this is worth it.",
                                function(playerArg)
                                    player:setCharVar("[RUN]AFprog", 3)
                                    player:needToZone(true)
                                    player:delKeyItem(xi.ki.YAHSE_WILDFLOWER_PETAL)

                                    player:PrintToPlayer("Consider yourself lucky. In my land, you had to ask for an audience with the queen.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("It took months, since getting the first rune was a ceremony.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("Queen Remedi would be present, and in the company of Princess Sarah and Prince Gordon.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("And in front of them, the general would draw it in your skin.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                        },

                        onCancelled = function(playerArg)
                            player:PrintToPlayer("What, do you like the petal so much?", 0, npc:getPacketName())
                        end,

                        onEnd = function(playerArg)
                        end,
                    }
                    player:customMenu(menu)
                end)

            -- Need to wait
            elseif progVar == 3 and player:needToZone() then
                player:PrintToPlayer("It will take me a while to prepare the ink.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("Be patient and come back later.", 0, npc:getPacketName())
                end)

            -- Obtain first rune and first AF
            elseif progVar == 3 and not player:needToZone() then
                player:PrintToPlayer("The ink is ready. Can you smell it? It brings me back...", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("Back then, we were meant to protect our kingdom and seek the truth.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("But we failed both our tasks. And our punishment is to never be back.", 0, npc:getPacketName())
                end)
                npc:timer(4500, function(npcArg)
                    player:PrintToPlayer("I'm rambling, pardon me. Are you ready?", 0, npc:getPacketName())
                end)

                npc:timer(4600, function(npcArg)
                    local menu =
                    {
                        title = "Are you ready?",

                        onStart = function(playerArg)
                        end,

                        options =
                        {
                            {
                                "Yes.",
                                function(playerArg)
                                    player:PrintToPlayer("Varado swiftly draws a rune in your left hand. The ink crawls inside your skin and burns you.", xi.msg.channel.NS_SAY)
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("There, all done. Take this gear aswell, I don't need it anymore.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("If you want to learn more, you will have to meet Caida.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("Last I heard, she was studying the ruins in Ronfaure with her subordinate.", 0, npc:getPacketName())
                                    end)

                                    npc:timer(4600, function(npcArg)
                                        if npcUtil.giveItem(player, 28067) then -- Runeist Mitons
                                            player:setCharVar("[RUN]AFprog", 4)
                                        end
                                    end)
                                end,
                            },
                            {
                                "No.",
                                function(playerArg)
                                    player:PrintToPlayer("Really? You aren't? Stop acting like a complete McFly.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("I can tell you, you wouldn't dare to act this way in front of our general.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                        },

                        onCancelled = function(playerArg)
                            player:PrintToPlayer("Seriously? We were in the middle of something, you know?", 0, npc:getPacketName())
                        end,

                        onEnd = function(playerArg)
                        end,
                    }
                    player:customMenu(menu)
                end)

            -- Next step reminder.
            elseif progVar == 4 then
                player:PrintToPlayer("Last I heard from Caida, she was somewhere in Ronfaure.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("I do not know exactly where, but I remember her liking old ruins.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("Beware though... She was really something.", 0, npc:getPacketName())
                end)

            -- Mid-quest dialog.
            elseif progVar > 4 and progVar < 8 then
                player:PrintToPlayer("So you met Caida, huh? I'm glad she's doing well.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("...", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("She never deserved any of this.", 0, npc:getPacketName())
                end)

            -- Quest completed dialog.
            elseif progVar == 8 then
                player:PrintToPlayer("You must have impressed the general if he gave you the last rune.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("And to think I would end up seing how a new Runefencer was born.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("Life is full of surprises, indeed.", 0, npc:getPacketName())
                end)
                npc:timer(4500, function(npcArg)
                    player:PrintToPlayer("But that man is still out there. Our mission isn't over yet.", 0, npc:getPacketName())
                end)

            -- Default dialog.
            else
                player:PrintToPlayer("...", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("Please, leave me alone.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("There's nothing for either of us here, anyway.", 0, npc:getPacketName())
                end)
            end
        end,
    })

    -- Return NPC
    utils.unused(runVarado)
end)

----------------------------------------------------------------------------------------------------
-- STEP 3: Lufaise Meadows - Stranger Flower ([RUN]AFprog == 2)
----------------------------------------------------------------------------------------------------

m:addOverride("xi.zones.Lufaise_Meadows.Zone.onInitialize", function(zone)
    -- Call the zone's original function for onInitialize
    super(zone)

    -- Define NPC
    local runFlower = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "Stranger Flower",
        look     = "0x0000340000000000000000000000000000000000",
        x        = 196.291,
        y        = -22.765,
        z        = 344.253,
        rotation = 0,
        widescan = 1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            local progVar = player:getCharVar("[RUN]AFprog")

            -- Quest starting dialog.
            if player:getMainJob() == xi.job.RUN and progVar == 2 and not player:hasKeyItem(xi.ki.YAHSE_WILDFLOWER_PETAL) then
                player:PrintToPlayer("The moment you touch the flower, images start flashing before your eyes.", xi.msg.channel.NS_SAY)
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("You see a beautiful woman with a warm smile and yet, mighty, like a queen.", xi.msg.channel.NS_SAY)
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("By her side, a man stands tall. His eyes are looking directly at you.", xi.msg.channel.NS_SAY)
                end)
                npc:timer(4500, function(npcArg)
                    player:PrintToPlayer("The image changes. The woman lies dead, covered in blood. A young boy cries before the corpse.", xi.msg.channel.NS_SAY)
                end)
                npc:timer(6000, function(npcArg)
                    player:PrintToPlayer("That man is still there, unchanged, looking at you.", xi.msg.channel.NS_SAY)
                end)

                npc:timer(6100, function(npcArg)
                    local menu =
                    {
                        title = "Your mind is clouding...",

                        onStart = function(playerArg)
                        end,

                        options =
                        {
                            {
                                "Give up.",
                                function(playerArg)
                                    player:PrintToPlayer("You can't remove that man from your mind.", xi.msg.channel.NS_SAY)
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("He... Or rather, it, doesn't belong in this world.", xi.msg.channel.NS_SAY)
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("His menacing gaze feels like like a blazing spear to your very soul.", xi.msg.channel.NS_SAY)
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("You are burning. The fortress in the far distance is burning aswell. The whole world is covered in flames...", xi.msg.channel.NS_SAY)
                                    end)

                                    -- Kill player.
                                    npc:timer(4600, function(npcArg)
                                        player:setHP(0)
                                    end)
                                end,
                            },
                            {
                                "Focus.",
                                function(playerArg)
                                    player:PrintToPlayer("You can't remove that man from your mind.", xi.msg.channel.NS_SAY)
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("He... Or rather, it, doesn't belong in this world.", xi.msg.channel.NS_SAY)
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("His menacing gaze feels like like a blazing spear to your very soul.", xi.msg.channel.NS_SAY)
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("You focus on the flower and manage to take the petal.",xi.msg.channel.NS_SAY)
                                    end)
                                    npc:timer(6000, function(npcArg)
                                        player:PrintToPlayer("The moment you pulled your hand, you immediately felt better.",xi.msg.channel.NS_SAY)
                                    end)

                                    npc:timer(6100, function(npcArg)
                                        npcUtil.giveKeyItem(player, xi.ki.YAHSE_WILDFLOWER_PETAL)
                                    end)
                                end,
                            },
                        },

                        onCancelled = function(playerArg) -- See Nier Automata.
                            player:PrintToPlayer("This pain!", xi.msg.channel.NS_SAY)
                            npc:timer(1500, function(npcArg)
                                player:PrintToPlayer("This sadness!", xi.msg.channel.NS_SAY)
                            end)
                            npc:timer(3000, function(npcArg)
                                player:PrintToPlayer("This desperation!", xi.msg.channel.NS_SAY)
                            end)
                            npc:timer(4500, function(npcArg)
                                player:PrintToPlayer("You can't wistand it. With haste, you pull your hand, failing to take the petal.", xi.msg.channel.NS_SAY)
                            end)

                            npc:timer(4600, function(npcArg)
                                player:setHP(1)
                            end)
                        end,

                        onEnd = function(playerArg)
                        end,
                    }
                    player:customMenu(menu)
                end)

            -- Next step reminder.
            elseif player:getMainJob() == xi.job.RUN and progVar == 2 and player:hasKeyItem(xi.ki.YAHSE_WILDFLOWER_PETAL) then
                player:PrintToPlayer("Never again would you dare to touch those flowers.", xi.msg.channel.NS_SAY)

            -- Quest active or completed dialog.
            elseif progVar > 2 then
                player:PrintToPlayer("Was that a glimpse from a past tragedy? Or an omen of terrible things to come?", xi.msg.channel.NS_SAY)
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("You feel uneasy and decide to leave.", xi.msg.channel.NS_SAY)
                end)

            -- Default dialog.
            else
                player:PrintToPlayer("This flowers look otherworldly.", xi.msg.channel.NS_SAY)
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("The moment you stared at them, you felt the need to leave at once.", xi.msg.channel.NS_SAY)
                end)
            end
        end,
    })

    -- Return NPC
    utils.unused(runFlower)
end)

----------------------------------------------------------------------------------------------------
-- STEP 5: Ronfaure - Caida, Perdida (Interaction start variable at 4 and 5)
----------------------------------------------------------------------------------------------------

m:addOverride("xi.zones.East_Ronfaure.Zone.onInitialize", function(zone)
    -- Call the zone's original function for onInitialize
    super(zone)

    -- Define Caida NPC
    local runCaida = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "Caida",
        look     = "0x0000440300000000000000000000000000000000",
        x        =  352.2,
        y        =    -20,
        z        = -302.3,
        rotation =     63,
        widescan =      1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            local progVar = player:getCharVar("[RUN]AFprog")

            -- Quest starting dialog.
            if player:getMainJob() == xi.job.RUN and progVar == 4 then
                player:PrintToPlayer("Varado told me you would come. It's nice meeting another Runefencer!", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("He told me you are seeking the runes. Following the path of truth are we?", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("I can help you with three of them if you want. I'm glad to help!", 0, npc:getPacketName())
                end)
                npc:timer(4500, function(npcArg)
                    player:PrintToPlayer("So, do you want to seek the runes?", 0, npc:getPacketName())
                end)

                npc:timer(4600, function(npcArg)
                    local menu =
                    {
                        title = "What to do.",

                        onStart = function(playerArg)
                        end,

                        options =
                        {
                            {
                                "Of course.",
                                function(playerArg)
                                    player:setCharVar("[RUN]AFprog", 5)

                                    player:PrintToPlayer("Excellent! Then lets get started at once, shall we?", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("As I said, I can help you with three of the runes.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("The runes of Power, Wisdom and Courage.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("Ask me for any of the three.", 0, npc:getPacketName())
                                    end)

                                end,
                            },
                            {
                                "Not now.",
                                function(playerArg)
                                    player:PrintToPlayer("That's fine. The path of truth must not be taken hastieeely.", 0, npc:getPacketName())
                                end,
                            },
                            {
                                "Yet ANOTHER beggar.",
                                function(playerArg)
                                    player:PrintToPlayer("Better a beggar than a corpse, wouldn't you say?", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("I think someone should learn some respect.", 0, npc:getPacketName())
                                    end)

                                    -- Kill player.
                                    npc:timer(2500, function(npcArg)
                                        player:setHP(0)
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("The lord of death, Xaver, sends his regards.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                        },

                        onCancelled = function(playerArg)
                            player:PrintToPlayer("Another time then. Lali-ho!", 0, npc:getPacketName())
                        end,

                        onEnd = function(playerArg)
                        end,
                    }
                    player:customMenu(menu)
                end)

            -- Finish 3-branches.
            elseif player:getCharVar("[RUN]power") == 2 and player:getCharVar("[RUN]wisdom") == 2 and player:getCharVar("[RUN]courage") == 2 then
                player:PrintToPlayer("You have far surpassed my expectations...", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("And you have saved me tons of busywork too!", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("If we were back home, you would probably get promoted with ease.", 0, npc:getPacketName())
                end)
                npc:timer(4500, function(npcArg)
                    player:PrintToPlayer("Unfortunately, that will never be the case.", 0, npc:getPacketName())
                end)

                npc:timer(4600, function(npcArg)
                    local menu =
                    {
                        title = "That was long road.",

                        onStart = function(playerArg)
                        end,

                        options =
                        {
                            {
                                "I just did your chores.",
                                function(playerArg)
                                    player:PrintToPlayer("Oh, don't be angry with me.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("I just turned you into something actually useful!", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "I was glad to help.",
                                function(playerArg)
                                    player:PrintToPlayer("Heh. There's only one more rune to go for you, huh?", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("While you were gone, I spoke to the general about you.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("To make it short, he wants to meet you in person.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("You'll be able to find him somewhere in Altepa, near the outpost.", 0, npc:getPacketName())
                                    end)

                                    player:setCharVar("[RUN]AFprog", 6)

                                    -- Cleanup
                                    player:setCharVar("[RUN]power", 0)
                                    player:setCharVar("[RUN]wisdom", 0)
                                    player:setCharVar("[RUN]courage", 0)
                                end,
                            },
                        },

                        onCancelled = function(playerArg)
                            player:PrintToPlayer("Someone is mad, I see. Haha! Looser.", 0, npc:getPacketName())
                        end,

                        onEnd = function(playerArg)
                        end,
                    }
                    player:customMenu(menu)
                end)

            -- KI Turn-in power.
            elseif player:hasKeyItem(xi.ki.FLASK_OF_FRUISERUM) then
                player:PrintToPlayer("Thanks to the eight titans. You found it!", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("I dropped it some time ago and was never able to find it.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("Huh? A monster you say? Oh well, nevermind that...", 0, npc:getPacketName())
                end)
                npc:timer(4500, function(npcArg)
                    player:PrintToPlayer("You have proven your power! Take this rune with pride.", 0, npc:getPacketName())
                end)

                npc:timer(4600, function(npcArg)
                    if npcUtil.giveItem(player, 28347) then -- Runeist Bottes
                        player:delKeyItem(xi.ki.FLASK_OF_FRUISERUM)
                        player:setCharVar("[RUN]power", 2)

                        if player:getCharVar("[RUN]power") == 2 and player:getCharVar("[RUN]wisdom") == 2 and player:getCharVar("[RUN]courage") == 2 then
                            player:PrintToPlayer("You have obtained all three runes.", 0, npc:getPacketName())
                            npc:timer(4500, function(npcArg)
                                player:PrintToPlayer("I have something to tell you.", 0, npc:getPacketName())
                            end)
                        end
                    end
                end)

            -- KI Turn-in wisdom.
            elseif player:hasKeyItem(xi.ki.LETTER_FROM_OCTAVIEN) then
                player:PrintToPlayer("So THAT is what it meant!", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("My friend Octavien likes playing with this kind of stuff. He is a little weird.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("He just doesn't understand I don't have the time...", 0, npc:getPacketName())
                end)
                npc:timer(4500, function(npcArg)
                    player:PrintToPlayer("Anyway, here is your rune. Good job!", 0, npc:getPacketName())
                end)

                npc:timer(4600, function(npcArg)
                    if npcUtil.giveItem(player, 28207) then -- Runeist Trousers
                        player:delKeyItem(xi.ki.LETTER_FROM_OCTAVIEN)
                        player:setCharVar("[RUN]wisdom", 2)

                        if player:getCharVar("[RUN]power") == 2 and player:getCharVar("[RUN]wisdom") == 2 and player:getCharVar("[RUN]courage") == 2 then
                            player:PrintToPlayer("You have obtained all three runes.", 0, npc:getPacketName())
                            npc:timer(4500, function(npcArg)
                                player:PrintToPlayer("I have something to tell you.", 0, npc:getPacketName())
                            end)
                        end
                    end
                end)

            -- KI Turn-in courage.
            elseif player:hasKeyItem(xi.ki.FROST_ENCRUSTED_FLAME_GEM) then
                player:PrintToPlayer("At last! I've been meaning to snatch this lil one for some time.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("We'll be able to make some progress in our hunt now...", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("Take this rune. You have earned it!", 0, npc:getPacketName())
                end)

                npc:timer(3100, function(npcArg)
                    if npcUtil.giveItem(player, 27927) then-- Runeist Coat
                        player:delKeyItem(xi.ki.FROST_ENCRUSTED_FLAME_GEM)
                        player:setCharVar("[RUN]courage", 2)

                        if player:getCharVar("[RUN]power") == 2 and player:getCharVar("[RUN]wisdom") == 2 and player:getCharVar("[RUN]courage") == 2 then
                            player:PrintToPlayer("You have obtained all three runes.", 0, npc:getPacketName())
                            npc:timer(4500, function(npcArg)
                                player:PrintToPlayer("I have something to tell you.", 0, npc:getPacketName())
                            end)
                        end
                    end
                end)

            -- 3-way quest branch.
            elseif progVar == 5 then
                player:PrintToPlayer("Lali-ho! Make sure you ask me for all three runes before you start searching.", 0, npc:getPacketName())

                npc:timer(100, function(npcArg)
                    local menu =
                    {
                        title = "Ask about the runes.",

                        onStart = function(playerArg)
                        end,

                        options =
                        {
                            {
                                "Rune of Power",
                                function(playerArg)
                                    player:PrintToPlayer("The path is paved with the blood of those who came before.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("Travel to Rolanberry Fields, near the crystal line. Somewhere there, you will find a flask.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("Bring it back and don't you dare drink it!", 0, npc:getPacketName())
                                    end)

                                    if player:getCharVar("[RUN]power") == 0 then
                                        player:setCharVar("[RUN]power", 1)
                                    end
                                end,
                            },
                            {
                                "Rune of wisdom",
                                function(playerArg)
                                    player:PrintToPlayer("The path is paved with the knowledge of those who came before.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("You will need to solve this cipher. Be sure to write it down.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("*az sz kk hz cn vm rz fd cz qa nq*", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("The cipher will tell you where to go.", 0, npc:getPacketName())
                                    end)

                                    if player:getCharVar("[RUN]wisdom") == 0 then
                                        player:setCharVar("[RUN]wisdom", 1)
                                    end
                                end,
                            },
                            {
                                "Rune of Courage",
                                function(playerArg)
                                    player:PrintToPlayer("The path is paved with the deeds of those who came before.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("Have you ever heard of the great hero Beren?", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("Legend says he stole a relic from the dark lord, for love.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("Seek the leader of the orcs. Near him, there's a gem. Be sure to snatch it.", 0, npc:getPacketName())
                                    end)

                                    if player:getCharVar("[RUN]courage") == 0 then
                                        player:setCharVar("[RUN]courage", 1)
                                    end
                                end,
                            },
                        },

                        onCancelled = function(playerArg)
                            player:PrintToPlayer("Later.", 0, npc:getPacketName())
                        end,

                        onEnd = function(playerArg)
                        end,
                    }
                    player:customMenu(menu)
                end)

            -- Next step reminder.
            elseif progVar == 6 then
                player:PrintToPlayer("Our general awaits somewhere in Altepa, near the outpost.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("Don't make him wait.", 0, npc:getPacketName())
                end)

            -- Remaining of the quest.
            elseif progVar > 6 and progVar < 8 then
                player:PrintToPlayer("I miss how my general would boss me arround.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("If I could get one thing back, just one, it would be that.", 0, npc:getPacketName())
                end)

            -- Quest completed dialog.
            elseif progVar == 8 then
                player:PrintToPlayer("Our enemy is still out there, somewhere.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("For my queen and my people, I will not rest until we find him.", 0, npc:getPacketName())
                end)

            -- Default dialog.
            else
                player:PrintToPlayer("Lali-ho! Have the best of days!", 0, npc:getPacketName())
            end
        end,
    })

    -- Define Perdida NPC
    local runPerdida = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "Perdida",
        look     = "0x0100010414100A20083003400B50006000700000",
        x        =  347.8,
        y        =    -20,
        z        = -302.3,
        rotation =     63,
        widescan =      1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            -- Backstory time.
            if player:getCharVar("[RUN]AFprog") > 4 then
                player:PrintToPlayer("Rally-ho... Is there anything you want to ask?", 0, npc:getPacketName())

                npc:timer(100, function(npcArg)
                    local menu =
                    {
                        title = "Ask about...",

                        onStart = function(playerArg)
                        end,

                        options =
                        {
                            {
                                "The Runefencers",
                                function(playerArg)
                                    player:PrintToPlayer("They were the sacred guards of the Adoulin kingdom.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("They were tasked with it's protection and the search of the one true truth.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("However, after the death of the queen, Prince...I mean, King Gordon banished us.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("Now we roam this lands, searching for our one true enemy.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "Runeseeker Babus",
                                function(playerArg)
                                    player:PrintToPlayer("He was our general and personal guardian of princess Sarah.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("He was also the king's right arm, before his death.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("An explendid warrior. Word was he managed to reach the truth.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("However, said truth came at a terrible price for him.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "Queen Remedi",
                                function(playerArg)
                                    player:PrintToPlayer("She was a kind hearted and righteous woman.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("Not even when the king died did she loose her virtues.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("But when that man came, everything changed.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("She became a monster and even tried to kill her daughter. She died shortly afterwards.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "Princess Sarah",
                                function(playerArg)
                                    player:PrintToPlayer("She is the elder of the two.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("Some people wanter her to be the next queen, but that went against the law.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("When we were banished, she willingly came with us instead.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("I think she just wanted to stay with the general.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "Prince Gordon",
                                function(playerArg)
                                    player:PrintToPlayer("He was the younger of the two... And a brat.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("When our queen died, the prince became the king.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("And his first act was banishing all Runefencers from Adoulin.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("I understand he loved his mother, but why blame us all for her sins?", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "The Runes",
                                function(playerArg)
                                    player:PrintToPlayer("Each one represents one of the five main virtues.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                       player:PrintToPlayer("However, there are actually more than five.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                       player:PrintToPlayer("The rest are either unknown, or lost.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                       player:PrintToPlayer("Hence why our general was called *The Runeseeker* by all.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "The enemy",
                                function(playerArg)
                                    player:PrintToPlayer("That man appeared out of nowhere with the promise of bringing the king back from death.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("And the queen accepted. She did everything he said.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("He wanted to open a gate to bring back the king's soul from the other side.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("But it required a fitting sacrifice. A soul for a soul.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "The Gate",
                                function(playerArg)
                                    player:PrintToPlayer("The gate would only open with a fitting soul, the soul of a loved one.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("The queen chose her daughter Sarah, however, she was stoped.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("Killed, to be precise. But when that happened, the gate opened anyway.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("And a soul did came through. An otherworldly soul. That was that man's plan.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                        },

                        onCancelled = function(playerArg)
                            player:PrintToPlayer("Come back whenever you want.", 0, npc:getPacketName())
                        end,

                        onEnd = function(playerArg)
                        end,
                    }
                    player:customMenu(menu)
                end)

            -- Default dialog.
            else
                player:PrintToPlayer("San d'Orian ruins are fascinating.", 0, npc:getPacketName())
            end
        end,
    })

    -- Return NPCs
    utils.unused(runCaida)
    utils.unused(runPerdida)
end)

----------------------------------------------------------------------------------------------------
-- Step 5 Wisdom: Batallia downs - ???
----------------------------------------------------------------------------------------------------

m:addOverride("xi.zones.Batallia_Downs.Zone.onInitialize", function(zone)
    -- Call the zone's original function for onInitialize
    super(zone)

    -- Define NPC
    local runQMwisdom = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "???",
        look     = "0x0000340000000000000000000000000000000000",
        x        = -641.176,
        y        = -24,
        z        = 358.707,
        rotation = 0,
        widescan = 1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            -- Quest dialog.
            if player:getCharVar("[RUN]wisdom") == 1 and not player:hasKeyItem(xi.ki.LETTER_FROM_OCTAVIEN) then
                player:PrintToPlayer("There's a small letter in the ground, addressed to Caida.", xi.msg.channel.NS_SAY)
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("You decide to pick it up.", xi.msg.channel.NS_SAY)
                end)

                npc:timer(1600, function(npcArg)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_OCTAVIEN)
                end)

            -- Default dialog.
            else
                player:PrintToPlayer("There's nothing out of the ordinary.", xi.msg.channel.NS_SAY)
            end
        end,
    })

    -- Return NPC
    utils.unused(runQMwisdom)
end)

----------------------------------------------------------------------------------------------------
-- STEP 5 Power: Rolanbery fields - ???
----------------------------------------------------------------------------------------------------

m:addOverride("xi.zones.Rolanberry_Fields.Zone.onInitialize", function(zone)
    -- Call the zone's original function for onInitialize
    super(zone)

    -- Define NPC
    local runQMpower = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "???",
        look     = "0x0000340000000000000000000000000000000000",
        x        = 320.63,
        y        = -32,
        z        = -319.28,
        rotation = 0,
        widescan = 1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            -- Quest dialog.
            if player:getCharVar("[RUN]power") == 1 and not player:hasKeyItem(xi.ki.FLASK_OF_FRUISERUM) and not player:needToZone() then
                player:PrintToPlayer("A small, ominous flask lies on the ground...", xi.msg.channel.NS_SAY)
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("A monster appeared out of nowhere and snatched it!", xi.msg.channel.NS_SAY)
                end)

                npc:timer(1600, function(npcArg)
                    -- Set "need to zone" so we can't repeatedly pop the NM over and over.
                    player:needToZone(true)

                    -- Define zone
                    local zone = player:getZone()

                    -- Define NM (Miser Murphy)
                    local mob = zone:insertDynamicEntity({
                        objtype     = xi.objType.MOB,
                        name        = "Poison Eater",
                        x           =  320.63,
                        y           =  -32,
                        z           = -319.28,
                        rotation    =    0,
                        groupId     =    9,
                        groupZoneId =  204,

                        onMobDeath = function(mob, playerArg, isKiller)
                             if playerArg:getCharVar("[RUN]power") == 1 and not playerArg:hasKeyItem(xi.ki.FLASK_OF_FRUISERUM) then
                                 npcUtil.giveKeyItem(player, xi.ki.FLASK_OF_FRUISERUM)
                             end
                        end,

                        releaseIdOnDeath = true,
                        mixins = {},
                        specialSpawnAnimation = true,
                    })

                    mob:setSpawn(320.63, -32, -319.28, 0)
                    mob:setDropID(0)

                    mob:spawn()
                end)

            -- Default dialog.
            else
                player:PrintToPlayer("There's nothing out of the ordinary.", xi.msg.channel.NS_SAY)
            end
        end,
    })

    -- Return NPC
    utils.unused(runQMpower)
end)

----------------------------------------------------------------------------------------------------
-- Step 5 Courage: Monastic Cavern - ???
----------------------------------------------------------------------------------------------------

m:addOverride("xi.zones.Monastic_Cavern.Zone.onInitialize", function(zone)
    -- Call the zone's original function for onInitialize
    super(zone)

    -- Define NPC
    local runQMcourage = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "???",
        look     = "0x0000340000000000000000000000000000000000",
        x        =  219,
        y        =   -2.5,
        z        = -100,
        rotation =    0,
        widescan =    1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            -- Quest dialog.
            if player:getCharVar("[RUN]courage") == 1 and not player:hasKeyItem(xi.ki.FROST_ENCRUSTED_FLAME_GEM) then
                player:PrintToPlayer("A small blazing gem lies on the ground.", xi.msg.channel.NS_SAY)
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("You pick it up.", xi.msg.channel.NS_SAY)
                end)

                npc:timer(1600, function(npcArg)
                    npcUtil.giveKeyItem(player, xi.ki.FROST_ENCRUSTED_FLAME_GEM)
                end)

            -- Default dialog.
            else
                player:PrintToPlayer("There's nothing out of the ordinary.", xi.msg.channel.NS_SAY)
            end
        end,
    })

    -- Return NPC
    utils.unused(runQMcourage)
end)

----------------------------------------------------------------------------------------------------
-- STEP 6 and 8: Eastern Altepa Desert - Babus and Sarah
----------------------------------------------------------------------------------------------------
m:addOverride("xi.zones.Eastern_Altepa_Desert.Zone.onInitialize", function(zone)
    -- Call the zone's original function for onInitialize
    super(zone)

    -- Define Babus NPC
    local runBabus = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "Babus",
        look     = "0x0100020300101A2019301A401950006000700000",
        x        = -207,
        y        =    7,
        z        = -336.314,
        rotation =  180,
        widescan =    1,

        onTrade = function(player, npc, trade)
            -- Finish quest.
            if npcUtil.tradeHasExactly(trade, {1404, 1405, 1406, 1407}) and player:getCharVar("[RUN]AFprog") == 7 then
                player:PrintToPlayer("You may wonder why I asked you to undertake this trial.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("Fighting dangerous monsters and gathering all these seemingly useless items.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("Each one was a trial. One that cannot be undertaken alone.", 0, npc:getPacketName())
                end)
                npc:timer(4500, function(npcArg)
                    player:PrintToPlayer("That is the last virtue, honor, represented by cooperation by you and your companions.", 0, npc:getPacketName())
                end)

                npc:timer(4600, function(npcArg)
                    local menu =
                    {
                        title = "Honor...",

                        onStart = function(playerArg)
                        end,

                        options =
                        {
                            {
                                "I don't understand it.",
                                function(playerArg)
                                    player:PrintToPlayer("Companions are the greatest of virtues.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("The beaten path we travel is harsh and impossible to travel on your own.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("But with companions, it isn't as bad.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("Your path to the truth is far from over, but you have taken the first step.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(6000, function(npcArg)
                                        player:PrintToPlayer("Take this rune in dignity and use it to pave the path for others to come.", 0, npc:getPacketName())
                                    end)

                                    npc:timer(6100, function(npcArg)
                                        if npcUtil.giveItem(player, 27787) then -- Runeist Bandaeu
                                            player:setCharVar("[RUN]AFprog", 8)
                                        end
                                    end)
                                end,
                            },
                        },

                        onCancelled = function(playerArg)
                            player:PrintToPlayer("You offended the knight, who swiftly punches you in the face.", xi.msg.channel.NS_SAY)

                            -- Kill player
                            npc:timer(100, function(npcArg)
                                player:setHP(0)
                            end)
                        end,

                        onEnd = function(playerArg)
                        end,
                    }
                    player:customMenu(menu)
                end)
            end
        end,

        onTrigger = function(player, npc)
            local progVar = player:getCharVar("[RUN]AFprog")

            -- Quest starting dialog.
            if player:getMainJob() == xi.job.RUN and progVar == 6 then
                player:PrintToPlayer("So you are the Rune Fencer I've been hearing about.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("I was surprised reading Caida's and Varado's reports.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("I am Babus. I was once the general of the Sacred Rune Fencer Order...", 0, npc:getPacketName())
                end)
                npc:timer(4500, function(npcArg)
                    player:PrintToPlayer("And the one who bestows the fifth rune to those worthy of it. Are you prepared?", 0, npc:getPacketName())
                end)

                npc:timer(4600, function(npcArg)
                    local menu =
                    {
                        title = "What to say.",

                        onStart = function(playerArg)
                        end,

                        options =
                        {
                            {
                                "Inquire about the trial.",
                                function(playerArg)
                                    player:setCharVar("[RUN]AFprog", 7)

                                    player:PrintToPlayer("Regularly, we would duel one on one.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("However, I have something better in mind for you.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("Something that will truly test your virtues.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("Strength isn't all that matters.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(6000, function(npcArg)
                                        player:PrintToPlayer("That's the path of those who like imposing their beliefs on others.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(7500, function(npcArg)
                                        player:PrintToPlayer("Instead, I want you to bring me something.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                        },

                        onCancelled = function(playerArg)
                            player:PrintToPlayer( "You offended the knight, who swiftly punches you in the face.", xi.msg.channel.NS_SAY)

                            -- Kill player
                            npc:timer(100, function(npcArg)
                                player:setHP(0)
                            end)
                        end,

                        onEnd = function(playerArg)
                        end,
                    }
                    player:customMenu(menu)
                end)

            -- Next step reminder.
            elseif progVar == 7 then
                player:PrintToPlayer("I made up my mind. Bring me a Seal of Genbu, Seiryu, Byakko and Suzaku.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("Those will prove your virtues, if you truly have any.", 0, npc:getPacketName())
                end)

            -- Quest completed dialog.
            elseif progVar == 8 then
                player:PrintToPlayer("You have proven your worth.", 0, npc:getPacketName())
                npc:timer(1500, function(npcArg)
                    player:PrintToPlayer("Not as a Rune Fencer, but as a person, the only thing that really matters.", 0, npc:getPacketName())
                end)
                npc:timer(3000, function(npcArg)
                    player:PrintToPlayer("One final piece of advice. If you ever meet a man with a burning gaze, don't engage with him.", 0, npc:getPacketName())
                end)
                npc:timer(4500, function(npcArg)
                    player:PrintToPlayer("He is extremely dangerous. Come to me if you ever do, though.", 0, npc:getPacketName())
                end)

            -- Default dialog.
            else
                player:PrintToPlayer("The knight stares at you. You decide to leave him alone.", xi.msg.channel.NS_SAY)
            end
        end,
    })

    -- Define Sarah NPC
    local runSarah = zone:insertDynamicEntity({
        objtype  = xi.objType.NPC,
        name     = "Sarah",
        look     = "0x0100040400101320003008400850006000700000", -- TODO: Change model to a female.
        x        = -210,
        y        =    7.61,
        z        = -336.4,
        rotation =  180,
        widescan =    1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            -- Backstory time.
            if player:getCharVar("[RUN]AFprog") > 6 then
                player:PrintToPlayer("Is there something you need?", 0, npc:getPacketName())

                npc:timer(100, function(npcArg)
                    local menu =
                    {
                        title = "Choose your words.",

                        onStart = function(playerArg)
                        end,

                        options =
                        {
                            {
                                "So you are a princess.",
                                function(playerArg)
                                    player:PrintToPlayer("I'm afraid that is no longer true.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("I gave up my title the moment I sided with the Rune Fencers and started my own path.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("I have no regrets though. None at all.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("If I had the choice, I would choose to follow this path, over and over again.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "Why are you here.",
                                function(playerArg)
                                    player:PrintToPlayer("The man we are looking for rides a strange boat that sails through sand and stone.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("This seemed like an obvious place to continue the search.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("The journey is difficult, but we will never give up. Not until my mother is avenged.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("Then, maybe, Babus and I can find a peaceful place to call home.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                            {
                                "Tell me about adoulin.",
                                function(playerArg)
                                    player:PrintToPlayer("Far to the west, beyond the great gray veil, lies the Kingdom of Adoulin.", 0, npc:getPacketName())
                                    npc:timer(1500, function(npcArg)
                                        player:PrintToPlayer("It was once a peaceful place full of good people, surrounded by nature.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(3000, function(npcArg)
                                        player:PrintToPlayer("However, one day, forever to be cursed came a boat that sailed through sand and stone.", 0, npc:getPacketName())
                                    end)
                                    npc:timer(4500, function(npcArg)
                                        player:PrintToPlayer("It brought a man of great evil who carried nothing but lies and our kingdom downfall.", 0, npc:getPacketName())
                                    end)
                                end,
                            },
                        },

                        onCancelled = function(playerArg)
                            player:PrintToPlayer("Be safe.", 0, npc:getPacketName())
                        end,

                        onEnd = function(playerArg)
                        end,
                    }
                    player:customMenu(menu)
                end)

            -- Default dialog.
            else
                player:PrintToPlayer("Greetings, adventurer.", 0, npc:getPacketName())
            end
        end,
    })

    -- Return NPCs
    utils.unused(runBabus)
    utils.unused(runSarah)
end)

return m