-----------------------------------
-- Add some npcs for testers in starter cities.
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("wings_alpha_test_npcs")
m:setEnabled(true)

m:addOverride("xi.zones.Bastok_Mines.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)

    -- Insert NPC into zone
    local Lili = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Lilisette",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 3049,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 93.446,
        y = 0.623,
        z = -68.917,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 128,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            if player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) ~= 1 then
                player:PrintToPlayer(" Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
                player:PrintToPlayer(" To help you get on your way with testing I will be able to set your level to 99, SAM/WAR, and equipement.", 0,npc:getPacketName())
                player:PrintToPlayer(" Just talk to me again to start the process.", 0, npc:getPacketName())
                player:setCharVar(string.format("[ALPHA]Talked_to_%s", npc:getName()), 1)
            elseif player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) == 1 then
                local equipmentList =
                {
                    21956, -- Weapon Main
                    22212, -- Sub
                    21371, -- Ammo
                    25569, -- Head
                    25485, -- Neck
                    27544, -- Ear1
                    27545, -- Ear2
                    25733, -- Body
                    23520, -- Hands
                    26185, -- Ring1
                    26182, -- Ring2
                    26257, -- Back
                    28428, -- Waist
                    25856, -- Legs
                    27472, -- Feet
                }
                
                player:changeContainerSize(xi.inv.INVENTORY, 80)
                player:changeJob(xi.job.SAM)
                player:changesJob(xi.job.WAR)
                player:setLevel(99)
                player:setsLevel(player:getMainLvl()/2)
                player:capAllSkills()
                player:setUnkillable(true)

                for i = 1, 49 do
                    player:addLearnedWeaponskill(i)
                end

                for _, item in pairs(equipmentList) do
                    player:addItem(item, 1)
                end
            end
        end,
    })

    local Cait = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Cait Sith",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2197,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 93.228,
        y = 0.623,
        z = -72.038,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 128,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            if player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) ~= 1 then
                player:PrintToPlayer(" Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
                player:PrintToPlayer(" To help you get on your way with testing I will be able to set your level to 99, SCH/RDM, and equipement.", 0,npc:getPacketName())
                player:PrintToPlayer(" Just talk to me again to start the process.", 0, npc:getPacketName())
                player:setCharVar(string.format("[ALPHA]Talked_to_%s", npc:getName()), 1)
            elseif player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) == 1 then
                local equipmentList =
                {
                    21150, -- Weapon Main
                    22213, -- Sub
                    22271, -- Ammo
                    23417, -- Head
                    25533, -- Neck
                    26085, -- Ear1
                    27526, -- Ear2
                    25689, -- Body
                    27120, -- Hands
                    26194, -- Ring1
                    27563, -- Ring2
                    26265, -- Back
                    28419, -- Waist
                    27305, -- Legs
                    27476, -- Feet
                }
                
                player:changeContainerSize(xi.inv.INVENTORY, 80)
                player:changeJob(xi.job.SCH)
                player:changesJob(xi.job.RDM)
                player:setLevel(99)
                player:setsLevel(player:getMainLvl()/2)
                player:capAllSkills()
                player:setUnkillable(true)

                for i = 1, 49 do
                    player:addLearnedWeaponskill(i)
                end

                for _, item in pairs(equipmentList) do
                    player:addItem(item, 1)
                end
            end
        end,
    })

    local Lilit = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Lilith",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2289,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 93.253,
        y = 0.623,
        z = -75.164,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 128,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer(" Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
            player:PrintToPlayer(" My name is Lilith and my job is to help testers learn about what we are trying to do.", 0,npc:getPacketName())
            player:PrintToPlayer(" Testers are free to do whatever they want, but please follow directions given in server messages for objectives.", 0, npc:getPacketName())
            player:PrintToPlayer(" Here are some useful commands to help you in testing:", 0, npc:getPacketName())
            player:PrintToPlayer(" !zone (auto-translate zone name) will allow you to go between different zones easily.", 0, npc:getPacketName())
            player:PrintToPlayer(" !changejob (Job Abv) (Level) changes your main job and level.", 0, npc:getPacketName())
            player:PrintToPlayer(" !changesjob (Job Abv) (Level) will change your subjob. Please remember SJ level is MJ/2.", 0, npc:getPacketName())
            player:PrintToPlayer(" !additem (itemID) {qty} allows you to add an item to your inventory.", 0, npc:getPacketName())
            player:PrintToPlayer(" !setgil (amount) will set your gil to that amount.", 0, npc:getPacketName())
            player:PrintToPlayer(" !release will allow you to get out of cutscenes you do not want to watch.", 0, npc:getPacketName())
            player:PrintToPlayer(" !speed (1-200) will increase or decrease your speed. Default speed is 40, Flee is 100.", 0, npc:getPacketName())
            player:PrintToPlayer(" !togglegm will turn on your GM flag.", 0, npc:getPacketName())
            player:PrintToPlayer(" If you change jobs, use !capallskills.", 0, npc:getPacketName())
            player:PrintToPlayer(" You can also use !goto (player) to go to your friends.", 0, npc:getPacketName())
            player:PrintToPlayer(" You can also add spells by using !addallspells.", 0, npc:getPacketName())
        end,
    })

    -- Use the mob object however you like
    -- horro:getID() etc.
    -- We're not doing anything with it, so ignore this object
    utils.unused(Lili)
    utils.unused(Cait)
    utils.unused(Lilit)

    -- You could also just not capture the object
    -- zone:insertDynamicEntity({ ...
end)

m:addOverride("xi.zones.Port_Windurst.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)

    -- Insert NPC into zone
    local Lili = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Lilisette",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 3049,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 182.409,
        y = -12.000,
        z = 229.149,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 50,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            if player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) ~= 1 then
                player:PrintToPlayer(" Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
                player:PrintToPlayer(" To help you get on your way with testing I will be able to set your level to 99, SAM/WAR, and equipement.", 0,npc:getPacketName())
                player:PrintToPlayer(" Just talk to me again to start the process.", 0, npc:getPacketName())
                player:setCharVar(string.format("[ALPHA]Talked_to_%s", npc:getName()), 1)
            elseif player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) == 1 then
                local equipmentList =
                {
                    21956, -- Weapon Main
                    22212, -- Sub
                    21371, -- Ammo
                    25569, -- Head
                    25485, -- Neck
                    27544, -- Ear1
                    27545, -- Ear2
                    25733, -- Body
                    23520, -- Hands
                    26185, -- Ring1
                    26182, -- Ring2
                    26257, -- Back
                    28428, -- Waist
                    25856, -- Legs
                    27472, -- Feet
                }
                
                player:changeContainerSize(xi.inv.INVENTORY, 80)
                player:changeJob(xi.job.SAM)
                player:changesJob(xi.job.WAR)
                player:setLevel(99)
                player:setsLevel(player:getMainLvl()/2)
                player:capAllSkills()
                player:setUnkillable(true)

                for i = 1, 49 do
                    player:addLearnedWeaponskill(i)
                end

                for _, item in pairs(equipmentList) do
                    player:addItem(item, 1)
                end
            end
        end,
    })

    local Cait = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Cait Sith",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2197,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 186.788,
        y = -12.000,
        z = 229.149,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 50,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            if player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) ~= 1 then
                player:PrintToPlayer(" Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
                player:PrintToPlayer(" To help you get on your way with testing I will be able to set your level to 99, SCH/RDM, and equipement.", 0,npc:getPacketName())
                player:PrintToPlayer(" Just talk to me again to start the process.", 0, npc:getPacketName())
                player:setCharVar(string.format("[ALPHA]Talked_to_%s", npc:getName()), 1)
            elseif player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) == 1 then
                local equipmentList =
                {
                    21150, -- Weapon Main
                    22213, -- Sub
                    22271, -- Ammo
                    23417, -- Head
                    25533, -- Neck
                    26085, -- Ear1
                    27526, -- Ear2
                    25689, -- Body
                    27120, -- Hands
                    26194, -- Ring1
                    27563, -- Ring2
                    26265, -- Back
                    28419, -- Waist
                    27305, -- Legs
                    27476, -- Feet
                }
                
                player:changeContainerSize(xi.inv.INVENTORY, 80)
                player:changeJob(xi.job.SCH)
                player:changesJob(xi.job.RDM)
                player:setLevel(99)
                player:setsLevel(player:getMainLvl()/2)
                player:capAllSkills()
                player:setUnkillable(true)

                for i = 1, 49 do
                    player:addLearnedWeaponskill(i)
                end

                for _, item in pairs(equipmentList) do
                    player:addItem(item, 1)
                end
            end
        end,
    })

    local Lilit = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Lilith",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2289,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 191.660,
        y = -12.000,
        z = 229.149,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 50,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer(" Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
            player:PrintToPlayer(" My name is Lilith and my job is to help testers learn about what we are trying to do.", 0,npc:getPacketName())
            player:PrintToPlayer(" Testers are free to do whatever they want, but please follow directions given in server messages for objectives.", 0, npc:getPacketName())
            player:PrintToPlayer(" Here are some useful commands to help you in testing:", 0, npc:getPacketName())
            player:PrintToPlayer(" !zone (auto-translate zone name) will allow you to go between different zones easily.", 0, npc:getPacketName())
            player:PrintToPlayer(" !changejob (Job Abv) (Level) changes your main job and level.", 0, npc:getPacketName())
            player:PrintToPlayer(" !changesjob (Job Abv) (Level) will change your subjob. Please remember SJ level is MJ/2.", 0, npc:getPacketName())
            player:PrintToPlayer(" !additem (itemID) {qty} allows you to add an item to your inventory.", 0, npc:getPacketName())
            player:PrintToPlayer(" !setgil (amount) will set your gil to that amount.", 0, npc:getPacketName())
            player:PrintToPlayer(" !release will allow you to get out of cutscenes you do not want to watch.", 0, npc:getPacketName())
            player:PrintToPlayer(" !speed (1-200) will increase or decrease your speed. Default speed is 40, Flee is 100.", 0, npc:getPacketName())
            player:PrintToPlayer(" !togglegm will turn on your GM flag.", 0, npc:getPacketName())
            player:PrintToPlayer(" If you change jobs, use !capallskills.", 0, npc:getPacketName())
            player:PrintToPlayer(" You can also use !goto (player) to go to your friends.", 0, npc:getPacketName())
            player:PrintToPlayer(" You can also add spells by using !addallspells.", 0, npc:getPacketName())
        end,
    })

    -- Use the mob object however you like
    -- horro:getID() etc.
    -- We're not doing anything with it, so ignore this object
    utils.unused(Lili)
    utils.unused(Cait)
    utils.unused(Lilit)

    -- You could also just not capture the object
    -- zone:insertDynamicEntity({ ...
end)

m:addOverride("xi.zones.Northern_San_dOria.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)

    -- Insert NPC into zone
    local Lili = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Lilisette",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 3049,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 82.179,
        y = 0.000,
        z = 4.156,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 204,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            if player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) ~= 1 then
                player:PrintToPlayer(" Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
                player:PrintToPlayer(" To help you get on your way with testing I will be able to set your level to 99, SAM/WAR, and equipement.", 0,npc:getPacketName())
                player:PrintToPlayer(" Just talk to me again to start the process.", 0, npc:getPacketName())
                player:setCharVar(string.format("[ALPHA]Talked_to_%s", npc:getName()), 1)
            elseif player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) == 1 then
                local equipmentList =
                {
                    21956, -- Weapon Main
                    22212, -- Sub
                    21371, -- Ammo
                    25569, -- Head
                    25485, -- Neck
                    27544, -- Ear1
                    27545, -- Ear2
                    25733, -- Body
                    23520, -- Hands
                    26185, -- Ring1
                    26182, -- Ring2
                    26257, -- Back
                    28428, -- Waist
                    25856, -- Legs
                    27472, -- Feet
                }
                
                player:changeContainerSize(xi.inv.INVENTORY, 80)
                player:changeJob(xi.job.SAM)
                player:changesJob(xi.job.WAR)
                player:setLevel(99)
                player:setsLevel(player:getMainLvl()/2)
                player:capAllSkills()
                player:setUnkillable(true)

                for i = 1, 49 do
                    player:addLearnedWeaponskill(i)
                end

                for _, item in pairs(equipmentList) do
                    player:addItem(item, 1)
                end
            end
        end,
    })

    local Cait = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Cait Sith",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2197,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 78.948,
        y = 0.000,
        z = 7.239,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 204,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            if player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) ~= 1 then
                player:PrintToPlayer(" Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
                player:PrintToPlayer(" To help you get on your way with testing I will be able to set your level to 99, SCH/RDM, and equipement.", 0,npc:getPacketName())
                player:PrintToPlayer(" Just talk to me again to start the process.", 0, npc:getPacketName())
                player:setCharVar(string.format("[ALPHA]Talked_to_%s", npc:getName()), 1)
            elseif player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) == 1 then
                local equipmentList =
                {
                    21150, -- Weapon Main
                    22213, -- Sub
                    22271, -- Ammo
                    23417, -- Head
                    25533, -- Neck
                    26085, -- Ear1
                    27526, -- Ear2
                    25689, -- Body
                    27120, -- Hands
                    26194, -- Ring1
                    27563, -- Ring2
                    26265, -- Back
                    28419, -- Waist
                    27305, -- Legs
                    27476, -- Feet
                }
                
                player:changeContainerSize(xi.inv.INVENTORY, 80)
                player:changeJob(xi.job.SCH)
                player:changesJob(xi.job.RDM)
                player:setLevel(99)
                player:setsLevel(player:getMainLvl()/2)
                player:capAllSkills()
                player:setUnkillable(true)

                for i = 1, 49 do
                    player:addLearnedWeaponskill(i)
                end

                for _, item in pairs(equipmentList) do
                    player:addItem(item, 1)
                end
            end
        end,
    })

    local Lilit = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Lilith",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2289,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 74.813,
        y = 0.000,
        z = 11.578,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 204,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer(" Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
            player:PrintToPlayer(" My name is Lilith and my job is to help testers learn about what we are trying to do.", 0,npc:getPacketName())
            player:PrintToPlayer(" Testers are free to do whatever they want, but please follow directions given in server messages for objectives.", 0, npc:getPacketName())
            player:PrintToPlayer(" Here are some useful commands to help you in testing:", 0, npc:getPacketName())
            player:PrintToPlayer(" !zone (auto-translate zone name) will allow you to go between different zones easily.", 0, npc:getPacketName())
            player:PrintToPlayer(" !changejob (Job Abv) (Level) changes your main job and level.", 0, npc:getPacketName())
            player:PrintToPlayer(" !changesjob (Job Abv) (Level) will change your subjob. Please remember SJ level is MJ/2.", 0, npc:getPacketName())
            player:PrintToPlayer(" !additem (itemID) {qty} allows you to add an item to your inventory.", 0, npc:getPacketName())
            player:PrintToPlayer(" !setgil (amount) will set your gil to that amount.", 0, npc:getPacketName())
            player:PrintToPlayer(" !release will allow you to get out of cutscenes you do not want to watch.", 0, npc:getPacketName())
            player:PrintToPlayer(" !speed (1-200) will increase or decrease your speed. Default speed is 40, Flee is 100.", 0, npc:getPacketName())
            player:PrintToPlayer(" !togglegm will turn on your GM flag.", 0, npc:getPacketName())
            player:PrintToPlayer(" If you change jobs, use !capallskills.", 0, npc:getPacketName())
            player:PrintToPlayer(" You can also use !goto (player) to go to your friends.", 0, npc:getPacketName())
            player:PrintToPlayer(" You can also add spells by using !addallspells.", 0, npc:getPacketName())
        end,
    })

    -- Use the mob object however you like
    -- horro:getID() etc.
    -- We're not doing anything with it, so ignore this object
    utils.unused(Lili)
    utils.unused(Cait)
    utils.unused(Lilit)

    -- You could also just not capture the object
    -- zone:insertDynamicEntity({ ...
end)

return m