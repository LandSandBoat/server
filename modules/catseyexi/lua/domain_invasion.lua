-----------------------------------
-- Domain Invasion (custom module)
-- Coded with love by Carver, Xaver, Graves, Demetrie
-- 2022, CatsEyeXI (http://catseyexi.com) / --server server.catseyexi.com
-----------------------------------
require("modules/module_utils")
require("scripts/globals/teleports")
require("scripts/zones/Kamihr_Drifts/Zone")
-----------------------------------
local m = Module:new("domain_invasion")

-- Server Crash Failsafe, could hook on any zone, really.
m:addOverride("xi.zones.GM_Home.Zone.onInitialize", function(zone)
    super(zone)

    -- cleanup variables
    if GetServerVariable("[Domain]NMToD") < 1 then
        SetServerVariable("[Domain]NMToD", 1)
    end
    
    if GetServerVariable("[Domain]NMSpawned") == 1 then
        SetServerVariable("[Domain]NMSpawned", 0)
    end

end)

-- NM 1
m:addOverride("xi.zones.Kamihr_Drifts.Zone.onZoneTick", function(zone)
--    super(zone)

    -- Spawn mob if its the correct mob and if it isnt spawned already
    if
        GetServerVariable("[Domain]NM") == 0 and               -- Correct NM
        GetServerVariable("[Domain]NMSpawned") == 0 and        -- NM isn't spawned
        (os.time() - GetServerVariable("[Domain]NMToD")) > 300 -- NM Cooldown
    then
        local mob = zone:insertDynamicEntity({
            objtype = xi.objType.MOB,
            name = "Amphisbaena",
            look = "0x0000950100000000000000000000000000000000",
            x = 372.03,
            y = 20.92,
            z = 258.70,
            rotation = 190,
            widescan = 1,
            groupId = 1,
            groupZoneId = 222,

            onMobSpawn = function(mob)
                SetServerVariable("[Domain]NMSpawned", 1)

                -- Debug
                printf("SPAWNING MOB!!!!!!!!!!")
                printf("Current value of Spawned flag should be 1: %s", GetServerVariable("[Domain]NMSpawned"))
            end,    

            onMobFight = function(mob, target)
            end,

            onMobDeath = function(mob, player, isKiller, noKiller)
                -- Variable control
                SetServerVariable("[Domain]NMToD", os.time())
                SetServerVariable("[Domain]NM", 1)
                SetServerVariable("[Domain]NMSpawned", 0)
				SetServerVariable("[Domain]Notification", 0)
				
                -- Server-wide message
                player:PrintToArea("{Apururu} Oh dear, one of our members-wembers in Reisenjima Henge says that Tortuga could appear anytime in the next 5 minutes.", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
                player:PrintToArea("{Apururu} Would you please go and see if she's alrightaru?", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)

                -- Reward escha beads
                local beadsRewarded = math.random(425, 750)
                local players = mob:getZone():getPlayers()
                
                for i, participant in pairs(players) do
                    if participant:hasStatusEffect(xi.effect.ELVORSEAL) then
                        participant:delStatusEffect(xi.effect.ELVORSEAL)
                        participant:addCurrency("escha_beads", beadsRewarded)
                        participant:PrintToPlayer(string.format("You've earned %s escha beads for your efforts in battle.", beadsRewarded), xi.msg.channel.SYSTEM_3)
                    else
                        participant:PrintToPlayer("You have not contributed enough to claim a reward.", xi.msg.channel.SYSTEM_3)
                    end
                end

            end,
        })

        mob:setSpawn(372.03, 20.92, 258.70, 190)
        mob:setDropID(3900)
        mob:spawn()

        -- Set MobMods 
        mob:setMobLevel(80)
        mob:addMod(xi.mod.STR, 20)
        mob:addMod(xi.mod.VIT, 10)
        mob:addMod(xi.mod.INT, 30)
        mob:addMod(xi.mod.MND, 10)
        mob:addMod(xi.mod.CHR, 10)
        mob:addMod(xi.mod.AGI, 10)
        mob:addMod(xi.mod.DEX, 20)
        mob:addMod(xi.mod.DEFP, 15)
        mob:addMod(xi.mod.RATTP, 75)
        mob:addMod(xi.mod.ACC, 100)
        mob:setMod(xi.mod.SILENCERES, 50)
        mob:setMod(xi.mod.STUNRES, 50)
        mob:setMod(xi.mod.BINDRES, 50)
        mob:setMod(xi.mod.GRAVITYRES, 50)
        mob:setMod(xi.mod.SLEEPRES, 10000)
        mob:setMod(xi.mod.POISONRES, 100)
        mob:setMod(xi.mod.PARALYZERES, 100)
        mob:setMod(xi.mod.LULLABYRES, 10000)
        mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
--        mob:addStatusEffect(xi.effect.REGEN, 30, 3, 0)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 817)
        mob:setMobMod(xi.mobMod.SPELL_LIST, 0)
    end

end)

-- NM 2
m:addOverride("xi.zones.Reisenjima_Henge.Zone.onZoneTick", function(zone)
--    super(zone)

    -- Spawn mob if its the correct mob and if it isnt spawned already.
    if
        GetServerVariable("[Domain]NM") == 1 and               -- Correct NM
        GetServerVariable("[Domain]NMSpawned") == 0 and        -- NM isn't spawned
        (os.time() - GetServerVariable("[Domain]NMToD")) > 300 -- NM Cooldown
    then
        local mob = zone:insertDynamicEntity({
            objtype = xi.objType.MOB,
            name = "Tortuga",
            look = "0x0000480900000000000000000000000000000000",
            x = 0.195,
            y = 5.50,
            z = -1.378,
            rotation = 65,
    
            groupId = 1,
            groupZoneId = 222,

            onMobSpawn = function(mob)
                SetServerVariable("[Domain]NMSpawned", 1)
                SetServerVariable("[Domain]PushMessage", 1)
            end,    

            onMobFight = function(mob, target)
--[[                if mob:getHPP() < 10 then
                    local players = mob:getZone():getPlayers()
                    printf("players: %s", players)
                    
                    for i, participant in pairs(players) do
                        if participant:hasEnmity() then
                            participant:setLocalVar("[Domain]Participant", 1)
                        end    
                    end
                end  ]]--
            end,

            onMobDeath = function(mob, player, isKiller, noKiller)                
                -- Roll for HQ version and handle next mob pop.
                local hqChance = math.random(1, 100)
                
                if hqChance <= 15 then
                    SetServerVariable("[Domain]NM", 3) -- HQ: Bahamut Pop
                    player:PrintToArea("{Apururu} Ohsie-nosey! We just received a report from our scouts that Bahamut has entered the airspace in Provenance!", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
                    player:PrintToArea("{Apururu} Rally the troops, we can't let him get away!", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
                else
                    SetServerVariable("[Domain]NM", 2)  -- NQ: Battosai Pop
                    player:PrintToArea("{Apururu} Oh dear, one of our members-wembers in Provenance says that Battosai could appear anytime in the next 5 minutes.", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
                    player:PrintToArea("{Apururu} Would you please go and see if she's alrightaru?", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
                end

                SetServerVariable("[Domain]NMToD", os.time())
                SetServerVariable("[Domain]NMSpawned", 0)
                SetServerVariable("[Domain]Notification", 0)
				
                -- Reward escha beads
                local beadsRewarded = math.random(425, 750)
                local players = mob:getZone():getPlayers()
                
                for i, participant in pairs(players) do
                    if participant:hasStatusEffect(xi.effect.ELVORSEAL) then
                        participant:delStatusEffect(xi.effect.ELVORSEAL)
                        participant:addCurrency("escha_beads", beadsRewarded)
                        participant:PrintToPlayer(string.format("You've earned %s escha beads for your efforts in battle.", beadsRewarded), xi.msg.channel.SYSTEM_3)
                    else
                        participant:PrintToPlayer("You have not contributed enough to claim a reward.", xi.msg.channel.SYSTEM_3)
                    end
                end

            end,
        })
    
        mob:setSpawn(0.195, 5.500, -1.378, 65)
        mob:setDropID(3900)
        mob:spawn()

        -- Set MobMods 
        mob:setMobLevel(78)
        mob:addMod(xi.mod.MAIN_DMG_RATING, 50)
        mob:addMod(xi.mod.STR, 20)
        mob:addMod(xi.mod.VIT, 10)
        mob:addMod(xi.mod.INT, 25)
        mob:addMod(xi.mod.MND, 10)
        mob:addMod(xi.mod.CHR, 10)
        mob:addMod(xi.mod.AGI, 10)
        mob:addMod(xi.mod.DEX, 20)
        mob:addMod(xi.mod.DEFP, 25)
        mob:addMod(xi.mod.RATTP, 75)
        mob:addMod(xi.mod.ACC, 100)
        mob:setMod(xi.mod.MATT, 150)
        mob:setMod(xi.mod.MACC, 450)
        mob:setMod(xi.mod.SILENCERES, 100)
        mob:setMod(xi.mod.STUNRES, 50)
        mob:setMod(xi.mod.BINDRES, 100)
        mob:setMod(xi.mod.GRAVITYRES, 100)
        mob:setMod(xi.mod.SLEEPRES, 10000)
        mob:setMod(xi.mod.POISONRES, 100)
        mob:setMod(xi.mod.PARALYZERES, 100)
        mob:setMod(xi.mod.LULLABYRES, 10000)
        mob:setMod(xi.mod.FASTCAST, 10)
        mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
        mob:addStatusEffect(xi.effect.SHOCK_SPIKES, 50, 0, 0)
--        mob:addStatusEffect(xi.effect.REGEN, 30, 3, 0)
        mob:addStatusEffect(xi.effect.ENTHUNDER_II, 100, 0, 0)
        mob:addStatusEffect(xi.effect.REFRESH, 50, 3, 0)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 277)
        mob:setMobMod(xi.mobMod.SPELL_LIST, 24)
    end
        
end)

-- NM 3
m:addOverride("xi.zones.Provenance.Zone.onZoneTick", function(zone)
    super(zone)
    
    --------------------
    -- NM 3 (Regular)
    --------------------
    if
        GetServerVariable("[Domain]NM") == 2 and               -- Correct NM
        GetServerVariable("[Domain]NMSpawned") == 0 and        -- NM isn't spawned
        (os.time() - GetServerVariable("[Domain]NMToD")) > 300 -- NM Cooldown
    then
        local mob = zone:insertDynamicEntity({
            objtype     = xi.objType.MOB,
            name        = "Battosai",
            look        = 3601,
            x           = -580,
            y           = -228,
            z           = 540,
            rotation    = 65,
            widescan    = 1,
            groupId     = 1,
            groupZoneId = 222,
            
            onMobSpawn = function(mob)
                SetServerVariable("[Domain]NMSpawned", 1)
                SetServerVariable("[Domain]PushMessage", 1)
            end,

            onMobFight = function(mob, target)
            end,

            onMobDeath = function(mob, player, isKiller, noKiller)     
                
                -- Variable control
                SetServerVariable("[Domain]NMToD", os.time()) -- Set NM ToD
                SetServerVariable("[Domain]NM", 0)            -- Set NM to be spawned next
                SetServerVariable("[Domain]NMSpawned", 0)     -- Set NM spawned flag (To not spawn infinite NMs)
				SetServerVariable("[Domain]Notification", 0)

                -- Server-wide message
                player:PrintToArea("{Apururu} Oh dear, one of our members-wembers in Kamihr Drifts says that Amphisbaena could appear anytime in the next 5 minutes.", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
                player:PrintToArea("{Apururu} Would you please go and see if she's alrightaru?", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)

                -- Reward escha beads
                local beadsRewarded = math.random(425, 750)
                local players = mob:getZone():getPlayers()
                
                for i, participant in pairs(players) do
                    if participant:hasStatusEffect(xi.effect.ELVORSEAL) then
                        participant:delStatusEffect(xi.effect.ELVORSEAL)
                        participant:addCurrency("escha_beads", beadsRewarded)
                        participant:PrintToPlayer(string.format("You've earned %s escha beads for your efforts in battle.", beadsRewarded), xi.msg.channel.SYSTEM_3)
                    else
                        participant:PrintToPlayer("You have not contributed enough to claim a reward.", xi.msg.channel.SYSTEM_3)
                    end
                end
            end,
        })
    
        mob:setSpawn(-580, -228, 540, 65)
        mob:setDropID(3900)
        mob:spawn()

        -- Set MobMods 
        mob:setMobLevel(76)
        mob:setMod(xi.mod.SILENCERES, 100)
        mob:setMod(xi.mod.STUNRES, 50)
        mob:setMod(xi.mod.BINDRES, 100)
        mob:setMod(xi.mod.GRAVITYRES, 100)
        mob:setMod(xi.mod.SLEEPRES, 10000)
        mob:setMod(xi.mod.POISONRES, 100)
        mob:setMod(xi.mod.PARALYZERES, 100)
        mob:setMod(xi.mod.LULLABYRES, 10000)
        mob:setMod(xi.mod.FASTCAST, 10)
        mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
        mob:addStatusEffect(xi.effect.SHOCK_SPIKES, 10, 0, 0)
        mob:addStatusEffect(xi.effect.REGEN, 30, 3, 0)
        mob:addStatusEffect(xi.effect.ENTHUNDER_II, 10, 0, 0)
        mob:addStatusEffect(xi.effect.REFRESH, 1, 3, 0)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 164)
    end

end)

--------------------
-- NM4 (Lottery)
--------------------
m:addOverride("xi.zones.Provenance.Zone.onZoneTick", function(zone)
    super(zone)

    -- Spawn mob if its the correct mob and if it isnt spawned already.
    if
        GetServerVariable("[Domain]NM") == 3 and               -- Correct NM
        GetServerVariable("[Domain]NMSpawned") == 0 and        -- NM isn't spawned
        (os.time() - GetServerVariable("[Domain]NMToD")) > 300 -- NM Cooldown
    then
        local mob = zone:insertDynamicEntity({
            objtype = xi.objType.MOB,
            name = "Bahamut",
            x = -580,
            y = -228,
            z = 540,
            rotation = 65,
            widescan = 1,
    
            groupId = 17,
            groupZoneId = 29,
            
            onMobSpawn = function(mob)
                SetServerVariable("[Domain]NMSpawned", 1)
                SetServerVariable("[Domain]PushMessage", 1)

                -- Debug
                printf("Bahamut is Spawned")
            end,

            onMobFight = function(mob, target)

                local lifePercent = mob:getHPP()
				
                if lifePercent < 70 and mob:getLocalVar("MegaFlareUsed") == 0 then
                    mob:useMobAbility(1551)
                    mob:setLocalVar("MegaFlareUsed", 1)
                end
                
				if lifePercent < 45 and mob:getLocalVar("MegaFlareUsed") == 1 then
                    mob:useMobAbility(1551)
                    mob:setLocalVar("MegaFlareUsed", 2)
                end
                
				if lifePercent < 25 and mob:getLocalVar("GigaFlareUsed") == 0 then
                    mob:useMobAbility(1552)
                    mob:setLocalVar("GigaFlareUsed", 1)
                end
                
				if lifePercent < 5 and mob:getLocalVar("GigaFlareUsed") == 1 then
                    mob:useMobAbility(1552)
                    mob:setMod(xi.mod.TRIPLE_ATTACK, 20)
                    mob:setLocalVar("GigaFlareUsed", 2)
                end            
            
            
                if mob:getHPP() < 10 then
                    local players = mob:getZone():getPlayers()
                    
                    for i, participant in pairs(players) do
                        if participant:hasEnmity() then
                            participant:setLocalVar("[Domain]Participant", 1)
                        end    
                    end
                end
            end,
            
            onMobDeath = function(mob, player, isKiller, noKiller)
                -- Variable control
                SetServerVariable("[Domain]NMToD", os.time()) -- Set NM ToD
                SetServerVariable("[Domain]NM", 0)            -- Set NM to be spawned next
                SetServerVariable("[Domain]NMSpawned", 0)     -- Set NM spawned flag (To not spawn infinite NMs)
				SetServerVariable("[Domain]Notification", 0)

                -- Server-wide message
                player:PrintToArea("{Apururu} Oh dear, one of our members-wembers in Kamihr Drifts says that Amphisbaena could appear anytime in the next 5 minutes.", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
                player:PrintToArea("{Apururu} Would you please go and see if she's alrightaru?", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)

                -- Reward escha beads
                local beadsRewarded = math.random(1250, 2000)
                local players = mob:getZone():getPlayers()
                
                for i, participant in pairs(players) do
                    if participant:hasStatusEffect(xi.effect.ELVORSEAL) then
                        participant:delStatusEffect(xi.effect.ELVORSEAL)
                        participant:addCurrency("escha_beads", beadsRewarded)
                        participant:PrintToPlayer(string.format("You've earned %s escha beads for your efforts in battle.", beadsRewarded), xi.msg.channel.SYSTEM_3)
                    else
                        participant:PrintToPlayer("You have not contributed enough to claim a reward.", xi.msg.channel.SYSTEM_3)
                    end
                end
            end,
        })
  
        mob:setSpawn(-580, -228, 540, 65)
        mob:setDropID(3901)
        mob:spawn()

        --  Set MobMods
--        mob:addMod(xi.mod.HUMANOID_KILLER, 7)
        mob:addMod(xi.mod.MAIN_DMG_RATING, 50)
        mob:setMobLevel(76)
		mob:addMod(xi.mod.MDEF, 60)
        mob:addMod(xi.mod.STR, 20)
        mob:addMod(xi.mod.VIT, 10)
        mob:addMod(xi.mod.INT, 25)
        mob:addMod(xi.mod.MND, 10)
        mob:addMod(xi.mod.CHR, 10)
        mob:addMod(xi.mod.AGI, 10)
        mob:addMod(xi.mod.DEX, 20)
        mob:addMod(xi.mod.DEFP, 50)
        mob:addMod(xi.mod.RATTP, 35)
        mob:addMod(xi.mod.ACC, 100)
        mob:setMod(xi.mod.MATT, 380)
        mob:setMod(xi.mod.MACC, 400)
        mob:setMod(xi.mod.SILENCERES, 100)
        mob:setMod(xi.mod.STUNRES, 50)
        mob:setMod(xi.mod.BINDRES, 100)
        mob:setMod(xi.mod.GRAVITYRES, 100)
        mob:setMod(xi.mod.SLEEPRES, 10000)
        mob:setMod(xi.mod.POISONRES, 100)
        mob:setMod(xi.mod.PARALYZERES, 100)
        mob:setMod(xi.mod.LULLABYRES, 10000)
        mob:setMod(xi.mod.FASTCAST, 10)
        mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
        mob:addStatusEffect(xi.effect.SHOCK_SPIKES, 10, 0, 0)
        mob:addStatusEffect(xi.effect.REGEN, 10, 3, 0)
        mob:addStatusEffect(xi.effect.ENTHUNDER_II, 10, 0, 0)
--        mob:addStatusEffect(xi.effect.REFRESH, 50, 3, 0)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 726)
        mob:setMobMod(xi.mobMod.SPELL_LIST, 144)
    end
        
end)

--------------------
-- Entrances
--------------------
-- Xarcabard -> Kamihr Drifts
m:addOverride("xi.zones.Xarcabard.Zone.onInitialize", function(zone)
    super(zone)

    local driftsPort = zone:insertDynamicEntity({

        objtype = xi.objType.NPC,
        name = "Black Cloud",
		look = 2941,
        x = 116.623,
        y = -24.00,
        z = -77.702,
        rotation = 28,

        onTrigger = function(player, npc)
            npcUtil.giveItem(player, xi.items.SCROLL_OF_INSTANT_WARP) -- scroll_of_instant_warp
            player:injectActionPacket(6, 600, 0, 0, 0)
		          
		    player:timer(2000, function(playerArg)
       	    	player:setPos(347.177, 20.616, 293.256, 36, 267)
		    end)
		    
            player:addStatusEffect(xi.effect.ELVORSEAL, 1, 0, 0)
		    if GetServerVariable("[Domain]Notification") ~= 1 then
		        SetServerVariable("[Domain]Notification", 1)
                player:PrintToArea("{Apururu} Looks like our forces-warses are gathering for domain invasion! Hurry-worry and join them!", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
		    end	
		end,
    })
	
	utils.unused(driftsPort)
	
end)

--Lock players in designated  area
m:addOverride("xi.zones.Kamihr_Drifts.Zone.onInitialize", function(zone)
    zone:registerRegion(1, 320.835, 19.534, 294.411, 332.153, 20.000, 304.651)
end)

m:addOverride("xi.zones.Kamihr_Drifts.Zone.onRegionLeave", function(player, region)
    player:setPos(336.885, 20.742, 293.693)
end)

-- Qufim Island -> Escha_ZiTah or Provenance
m:addOverride("xi.zones.Qufim_Island.npcs.Undulating_Confluence.onTrigger", function(player, npc)
    player:startEvent(65)
end)

m:addOverride("xi.zones.Qufim_Island.npcs.Undulating_Confluence.onEventFinish", function(player, csid, option)
    if csid == 65 and option == 1 then
	    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.IN_DEFIANT_CHALLENGE) == QUEST_COMPLETED then
	        local menu =
            {
                title = "Select your destination",
                onStart = function(playerArg)
                    -- NOTE: This could be used to lock the player in place
                    -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
                end,
		    	
                options =
                {
                    {
                        "Escha - Zi'Tah",
                        function(playerArg)
                            xi.teleport.to(player, xi.teleport.id.ESCHA_ZITAH)
                        end,
                    },
                    {
                        "Provenance (Domain Invasion)",
                        function(playerArg)
                            npcUtil.giveItem(player, xi.items.SCROLL_OF_INSTANT_WARP) -- scroll_of_instant_warp
                            player:setPos(-576.140, -228.000, 503.928, 120, 222)
                            player:addStatusEffect(xi.effect.ELVORSEAL, 1, 0, 0)
                    		if GetServerVariable("[Domain]Notification") ~= 1 then
                    		    SetServerVariable("[Domain]Notification", 1)
                                player:PrintToArea("{Apururu} Looks like our forces-warses are gathering for domain invasion! Hurry-worry and join them!", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
                    		end	
                        end,
                    },
                },
		    	
                onCancelled = function(playerArg)
                    playerArg:PrintToPlayer("Aborting ...", xi.msg.channel.NS_SAY)
                end,
                
                onEnd = function(playerArg)
                    if GetServerVariable("[Domain]NM") == 1 then
                		if GetServerVariable("[Domain]Notification") ~= 1 then
                		    SetServerVariable("[Domain]Notification", 1)
                            player:PrintToArea("{Apururu} Looks like our forces-warses are gathering for domain invasion! Hurry-worry and join them!", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
                		end	
                    end    
                end,
            }
            player:customMenu(menu)
		else
		    xi.teleport.to(player, xi.teleport.id.ESCHA_ZITAH)
		end
    end
end)

-- La Theine Plateau
m:addOverride("xi.zones.La_Theine_Plateau.npcs.Dimensional_Portal.onTrigger", function(player, npc)
    local menu =
    {
        title = "Select your destination",
        onStart = function(playerArg)
            -- NOTE: This could be used to lock the player in place
            -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Option 1: Al'Taieu",
                function(playerArg)
                    if player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_WARRIORS_PATH then
                        player:setAnimation(101)
                        player:setPos(25.299, -2.799, 579, 193, 33) -- To AlTaieu {R}
                    else 
                        player:PrintToPlayer("You don't have access to this area.")
                    end    
                end,
            },
            {
                "Option 2: Reisenjima",
                function(playerArg)
                    npcUtil.giveItem(player, xi.items.SCROLL_OF_INSTANT_WARP) -- scroll_of_instant_warp
                    player:setAnimation(101)
                    player:addStatusEffect(xi.effect.ELVORSEAL, 1, 0, 0)
                    player:setPos(-23.00, 5.50, 0.00, 0, 292) -- To Reisenjima
                end,
            },
        },
        onCancelled = function(playerArg)
            playerArg:PrintToPlayer("Aborting ...", xi.msg.channel.NS_SAY)
        end,
        
        onEnd = function(playerArg)
            if GetServerVariable("[Domain]NM") == 1 then
        		if GetServerVariable("[Domain]Notification") ~= 1 then
        		    SetServerVariable("[Domain]Notification", 1)
                    player:PrintToArea("{Apururu} Looks like our forces-warses are gathering for domain invasion! Hurry-worry and join them!", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
        		end	
            end    
        end,
    }
    player:customMenu(menu)
end)

-- Konschat Highlands
m:addOverride("xi.zones.Konschtat_Highlands.npcs.Dimensional_Portal.onTrigger", function(player, npc)
    local menu =
    {
        title = "Select your destination",
        onStart = function(playerArg)
            -- NOTE: This could be used to lock the player in place
            -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Option 1: Al'Taieu",
                function(playerArg)
                    if player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_WARRIORS_PATH then
                        player:setAnimation(101)
                        player:setPos(-635.599, -2.799, 163.8, 193, 33) -- To AlTaieu {R}
                    else 
                        player:PrintToPlayer("You don't have access to this area.")
                    end    
                end,
            },
            {
                "Option 2: Reisenjima",
                function(playerArg)
                    npcUtil.giveItem(player, xi.items.SCROLL_OF_INSTANT_WARP) -- scroll_of_instant_warp
                    player:setAnimation(101)
                    player:addStatusEffect(xi.effect.ELVORSEAL, 1, 0, 0)
                    player:setPos(-23.00, 5.50, 0.00, 0, 292) -- To Reisenjima
                end,
            },
        },
        onCancelled = function(playerArg)
            playerArg:PrintToPlayer("Aborting ...", xi.msg.channel.NS_SAY)
        end,
        
        onEnd = function(playerArg)
            if GetServerVariable("[Domain]NM") == 1 then
        		if GetServerVariable("[Domain]Notification") ~= 1 then
        		    SetServerVariable("[Domain]Notification", 1)
                    player:PrintToArea("{Apururu} Looks like our forces-warses are gathering for domain invasion! Hurry-worry and join them!", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
        		end	
            end    
        end,
    }
    player:customMenu(menu)
end)

-- Tahrongi Canyon
m:addOverride("xi.zones.Tahrongi_Canyon.npcs.Dimensional_Portal.onTrigger", function(player, npc)
    local menu =
    {
        title = "Select your destination",
        onStart = function(playerArg)
            -- NOTE: This could be used to lock the player in place
            -- playerArg:PrintToPlayer("Test Menu Opening", xi.msg.channel.NS_SAY)
        end,
        options =
        {
            {
                "Option 1: Al'Taieu",
                function(playerArg)
                    if player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_WARRIORS_PATH then
                        player:setAnimation(101)
                        player:setPos(654.200, -2.799, 100.700, 193, 33) -- To AlTaieu {R}
                    else 
                        player:PrintToPlayer("You don't have access to this area.")
                    end    
                end,
            },
            {
                "Option 2: Reisenjima",
                function(playerArg)
                    npcUtil.giveItem(player, xi.items.SCROLL_OF_INSTANT_WARP) -- scroll_of_instant_warp
                    player:setAnimation(101)
                    player:addStatusEffect(xi.effect.ELVORSEAL, 1, 0, 0)
                    player:setPos(-23.00, 5.50, 0.00, 0, 292) -- To Reisenjima
                end,
            },
        },
        onCancelled = function(playerArg)
            playerArg:PrintToPlayer("Aborting ...", xi.msg.channel.NS_SAY)
        end,
        
        onEnd = function(playerArg)
            if GetServerVariable("[Domain]NM") == 1 then
        		if GetServerVariable("[Domain]Notification") ~= 1 then
        		    SetServerVariable("[Domain]Notification", 1)
                    player:PrintToArea("{Apururu} Looks like our forces-warses are gathering for domain invasion! Hurry-worry and join them!", xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM)
        		end	
            end    
        end,
    }
    player:customMenu(menu)
end)

-- Exit Checks
-- Make sure we remove xi.effect.ELVORSEAL from players when they zone
m:addOverride("xi.zones.Kamihr_Drifts.Zone.onZoneOut", function(player)
--    super(zone)
    player:delStatusEffect(xi.effect.ELVORSEAL)
end)

m:addOverride("xi.zones.Reisenjima_Henge.Zone.onZoneOut", function(player)
--    super(zone)
    player:delStatusEffect(xi.effect.ELVORSEAL)
end)

m:addOverride("xi.zones.Provenance.Zone.onZoneOut", function(player)
--    super(zone)
    player:delStatusEffect(xi.effect.ELVORSEAL)
end)

-- Decorative Beams
m:addOverride("xi.zones.Kamihr_Drifts.Zone.onInitialize", function(zone)
    super(zone)
    local beam1 = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = " ",
        flag = 2056,
        look = 2472,
        x = 329.847,
        y = 20.00,
        z = 298.611,
        rotation = 65,
    })

    local beam2 = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = " ",
        flag = 2056,
        look = 2472,
        x = 327.879,
        y = 19.999,
        z = 296.135,
        rotation = 65,
    })

    local beam3 = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = " ",
        flag = 2056,
        look = 2472,
        x = 331.768,
        y = 20,
        z = 300.841,
        rotation = 65,
    })

end)
-- End Decorations

-- Elvorseal food (Pearlscale 5714)
m:addOverride("xi.globals.items.pearlscale.onItemCheck", function(target)
    if target:hasStatusEffect(xi.effect.ELVORSEAL) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end)

m:addOverride("xi.globals.items.pearlscale.onItemUse", function(target)
    target:addStatusEffect(xi.effect.ELVORSEAL, 1, 0, 3600)
end)

m:addOverride("xi.globals.items.pearlscale.onEffectGain", function(target)
end)

m:addOverride("xi.globals.items.pearlscale.onEffectLose", function(target)
end)

return m
