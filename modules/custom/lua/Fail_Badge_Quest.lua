-----------------------------------
-- Fail Badge Custom Quest
-- Achieve Master: !pos -13.2891 1.99960 132.3310
-----------------------------------

xi = xi or {}
xi.failBadge = xi.failBadge or {}

xi.failBadge.progress = {
    QUEST_AVAILABLE           = 0,
    FADED_CRYSTAL_OBTAINED    = 5,
    TERRA_CRYSTAL_OBTAINED    = 7,
    GLACIER_CRYSTAL_OBTAINED  = 9,
    PLASMA_CRYSTAL_OBTAINED   = 11,
    INFERNO_CRYSTAL_OBTAINED  = 13,
    TWILIGHT_CRYSTAL_OBTAINED = 15,
    READY_FOR_PROVENANCE      = 16,
    BOSS_FIGHT                = 17,
    AURORA_CRYSTAL_OBTAINED   = 18,
    QUEST_FAILED              = 19,
}

xi.failBadge.crystals = {
    [5]  = { item = xi.item.FADED_CRYSTAL,    next = xi.item.TERRA_CRYSTAL },
    [7]  = { item = xi.item.TERRA_CRYSTAL,    next = xi.item.GLACIER_CRYSTAL },
    [9]  = { item = xi.item.GLACIER_CRYSTAL,  next = xi.item.PLASMA_CRYSTAL },
    [11] = { item = xi.item.PLASMA_CRYSTAL,   next = xi.item.INFERNO_CRYSTAL },
    [13] = { item = xi.item.INFERNO_CRYSTAL,  next = xi.item.TWILIGHT_CRYSTAL },
    [15] = { item = xi.item.TWILIGHT_CRYSTAL, next = nil },
    [17] = { item = nil,                      next = xi.item.AURORA_CRYSTAL },
}

xi.failBadge.locations = {
    [5]  = "Western Altepa Desert",
    [7]  = "Uleguerand Range",
    [9]  = "The Sanctuary of Zi'Tah",
    [11] = "Ifrit's Cauldron",
    [13] = "Castle Zvahl Keep",
    [15] = "Ru'Lude Gardens",
    [16] = "Provenance",
}

xi.failBadge.crystalNames = {
    [xi.item.FADED_CRYSTAL]    = "Faded Crystal",
    [xi.item.TERRA_CRYSTAL]    = "Terra Crystal",
    [xi.item.GLACIER_CRYSTAL]  = "Glacier Crystal",
    [xi.item.PLASMA_CRYSTAL]   = "Plasma Crystal",
    [xi.item.INFERNO_CRYSTAL]  = "Inferno Crystal",
    [xi.item.TWILIGHT_CRYSTAL] = "Twilight Crystal",
    [xi.item.AURORA_CRYSTAL]   = "Aurora Crystal",
}

xi.failBadge.crystalNames = {
    [xi.item.FADED_CRYSTAL]    = "Faded Crystal",
    [xi.item.TERRA_CRYSTAL]    = "Terra Crystal",
    [xi.item.GLACIER_CRYSTAL]  = "Glacier Crystal",
    [xi.item.PLASMA_CRYSTAL]   = "Plasma Crystal",
    [xi.item.INFERNO_CRYSTAL]  = "Inferno Crystal",
    [xi.item.TWILIGHT_CRYSTAL] = "Twilight Crystal",
    [xi.item.AURORA_CRYSTAL]   = "Aurora Crystal",
}

local function getCrystalName(itemId)
    return xi.failBadge.crystalNames[itemId] or "Unknown Crystal"
end

local function sendLocationHint(player, progress)
    local location = xi.failBadge.locations[progress]
    local crystal = xi.failBadge.crystals[progress]

    if progress == xi.failBadge.progress.TWILIGHT_CRYSTAL_OBTAINED then
        player:printToPlayer("Return to Achieve Master in Ru'Lude Gardens.", xi.msg.channel.SYSTEM_3)
        return
    end
    
    if location and crystal and crystal.item then
        local crystalName = getCrystalName(crystal.item)
        player:printToPlayer("The next chest is in " .. location .. ".", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("Place the '" .. crystalName .. "' inside of it.", xi.msg.channel.SYSTEM_3)
    end
end

-----------------------------------
-- Ru'Lude Gardens NPC (Main Quest Giver)
-----------------------------------

xi.failBadge.onTriggerRulude = function(player, npc)
    local prog = player:getVar('FailBadge')
    local p = xi.failBadge.progress
    
    if prog == p.QUEST_AVAILABLE then
        -- Start the quest
        player:printToPlayer("A new challenger arrises!", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("There are several magical chests hidden across Vana'diel.", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("The first chest is somewhere in Western Altepa Desert.", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("Take the 'Faded Crystal' to the chest there to reveal the next step.", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("At the end of your journey you will face a tremendous challenge.", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("If you succeed, you will win 1 billion gil!", xi.msg.channel.SYSTEM_3)
        player:setVar("FailBadge", p.FADED_CRYSTAL_OBTAINED)
        npcUtil.giveItem(player, xi.item.FADED_CRYSTAL)
    elseif prog == p.FADED_CRYSTAL_OBTAINED or
           prog == p.TERRA_CRYSTAL_OBTAINED or
           prog == p.GLACIER_CRYSTAL_OBTAINED or
           prog == p.PLASMA_CRYSTAL_OBTAINED or
           prog == p.INFERNO_CRYSTAL_OBTAINED then
        -- Give location hint for current crystal
        sendLocationHint(player, prog)
    elseif prog == p.TWILIGHT_CRYSTAL_OBTAINED then
        -- Ready for final challenge
        player:printToPlayer("You've done it! The challenge isn't over yet though.", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("Take the Twilight Crystal to a final chest in Provenance to see the true challenge.", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("Return to me once you have faced your final trial, win or lose.", xi.msg.channel.SYSTEM_3)
        player:setVar("FailBadge", p.READY_FOR_PROVENANCE)
    elseif prog == p.READY_FOR_PROVENANCE then
        -- Remind about Provenance
        player:printToPlayer("Take the Twilight Crystal to the chest in Provenance.", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("There you will find your final challenge.", xi.msg.channel.SYSTEM_3)
    elseif prog == p.BOSS_FIGHT then
        -- Give Aurora Crystal after boss
        player:printToPlayer("So you have faced the final challenge?", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("Place this crystal in the chest in Provenance for your reward.", xi.msg.channel.SYSTEM_3)
        player:printToPlayer("If you were successful, 1,000,000,000 gil will appear in the chest!", xi.msg.channel.SYSTEM_3)
        player:setVar("FailBadge", p.AURORA_CRYSTAL_OBTAINED)
        npcUtil.giveItem(player, xi.item.AURORA_CRYSTAL)
    elseif prog == p.AURORA_CRYSTAL_OBTAINED then
        -- Remind to return to Provenance
        player:printToPlayer("Take the Aurora Crystal to the chest in Provenance to receive your reward.", xi.msg.channel.SYSTEM_3)
    elseif prog == p.QUEST_FAILED then
        -- Quest failed message
        player:printToPlayer("You failed! No second chances!", xi.msg.channel.SYSTEM_3)
    end
end

-----------------------------------
-- Generic Chest Functions
-----------------------------------

xi.failBadge.handleChestTrade = function(player, npc, trade, expectedProgress, requiredCrystal, nextProgress)
    local prog = player:getVar('FailBadge')
    
    if prog == expectedProgress and npcUtil.tradeHasExactly(trade, requiredCrystal) then
        player:confirmTrade()
        
        -- Special case for Castle Zvahl Keep (return to Ru'Lude)
        if expectedProgress == xi.failBadge.progress.INFERNO_CRYSTAL_OBTAINED then
            player:printToPlayer("Go back to Achieve Master in Ru'Lude Gardens.", xi.msg.channel.SYSTEM_3)
            player:setVar("FailBadge", nextProgress)
            npcUtil.giveItem(player, xi.item.TWILIGHT_CRYSTAL)
            return true
        end
        
        -- Normal chest progression
        local crystalData = xi.failBadge.crystals[expectedProgress]
        if crystalData and crystalData.next then
            -- Give next crystal and hint
            local nextLocation = xi.failBadge.locations[nextProgress]
            local nextCrystalName = getCrystalName(crystalData.next)
            
            player:printToPlayer("The next chest is in " .. nextLocation .. ".", xi.msg.channel.SYSTEM_3)
            player:printToPlayer("Place the '" .. nextCrystalName .. "' inside of it.", xi.msg.channel.SYSTEM_3)
            player:setVar("FailBadge", nextProgress)
            npcUtil.giveItem(player, crystalData.next)
        end
        return true
    end
    return false
end

xi.failBadge.handleChestTrigger = function(player, npc, currentProgress, nextProgress)
    local prog = player:getVar('FailBadge')

    if prog == nextProgress then
        -- Player is at correct stage, give hint
        sendLocationHint(player, prog)
    else
        -- Generic message
        player:printToPlayer("A mysterious chest. It seems to be waiting for something.", xi.msg.channel.SYSTEM_3)
    end
end

-----------------------------------
-- Zone-Specific Chest Functions
-----------------------------------

xi.failBadge.onTradeAltepa = function(player, npc, trade)
    local p = xi.failBadge.progress
    return xi.failBadge.handleChestTrade(player, npc, trade,
        p.FADED_CRYSTAL_OBTAINED,
        xi.item.FADED_CRYSTAL,
        p.TERRA_CRYSTAL_OBTAINED)
end

xi.failBadge.onTriggerAltepa = function(player, npc)
    local p = xi.failBadge.progress
    xi.failBadge.handleChestTrigger(player, npc, 
        p.FADED_CRYSTAL_OBTAINED, 
        p.TERRA_CRYSTAL_OBTAINED)
end

xi.failBadge.onTradeUleguerand = function(player, npc, trade)
    local p = xi.failBadge.progress
    return xi.failBadge.handleChestTrade(player, npc, trade, 
        p.TERRA_CRYSTAL_OBTAINED, 
        xi.item.TERRA_CRYSTAL, 
        p.GLACIER_CRYSTAL_OBTAINED)
end

xi.failBadge.onTriggerUleguerand = function(player, npc)
    local p = xi.failBadge.progress
    xi.failBadge.handleChestTrigger(player, npc, 
        p.TERRA_CRYSTAL_OBTAINED, 
        p.GLACIER_CRYSTAL_OBTAINED)
end

xi.failBadge.onTradeZitah = function(player, npc, trade)
    local p = xi.failBadge.progress
    return xi.failBadge.handleChestTrade(player, npc, trade, 
        p.GLACIER_CRYSTAL_OBTAINED, 
        xi.item.GLACIER_CRYSTAL, 
        p.PLASMA_CRYSTAL_OBTAINED)
end

xi.failBadge.onTriggerZitah = function(player, npc)
    local p = xi.failBadge.progress
    xi.failBadge.handleChestTrigger(player, npc, 
        p.GLACIER_CRYSTAL_OBTAINED, 
        p.PLASMA_CRYSTAL_OBTAINED)
end

xi.failBadge.onTradeIfrits = function(player, npc, trade)
    local p = xi.failBadge.progress
    return xi.failBadge.handleChestTrade(player, npc, trade, 
        p.PLASMA_CRYSTAL_OBTAINED, 
        xi.item.PLASMA_CRYSTAL, 
        p.INFERNO_CRYSTAL_OBTAINED)
end

xi.failBadge.onTriggerIfrits = function(player, npc)
    local p = xi.failBadge.progress
    xi.failBadge.handleChestTrigger(player, npc, 
        p.PLASMA_CRYSTAL_OBTAINED, 
        p.INFERNO_CRYSTAL_OBTAINED)
end

xi.failBadge.onTradeZvahl = function(player, npc, trade)
    local p = xi.failBadge.progress
    return xi.failBadge.handleChestTrade(player, npc, trade, 
        p.INFERNO_CRYSTAL_OBTAINED, 
        xi.item.INFERNO_CRYSTAL, 
        p.TWILIGHT_CRYSTAL_OBTAINED)
end

xi.failBadge.onTriggerZvahl = function(player, npc)
    local p = xi.failBadge.progress
    local prog = player:getVar('FailBadge')

    xi.failBadge.handleChestTrigger(player, npc, 
        p.INFERNO_CRYSTAL_OBTAINED, 
        p.TWILIGHT_CRYSTAL_OBTAINED)
end

xi.failBadge.onTradeProvenance = function(player, npc, trade)
    local prog = player:getVar('FailBadge')
    local p = xi.failBadge.progress
    
    if prog == p.READY_FOR_PROVENANCE and npcUtil.tradeHasExactly(trade, xi.item.TWILIGHT_CRYSTAL) then
        local mobId = zones[xi.zone.PROVENANCE].mob.PROVENANCE_WATCHER
        local mob = GetMobByID(mobId)

        -- Teleport to boss area
        player:setVar("FailBadge", p.BOSS_FIGHT)
        player:setPos(-582, -228, 507, 194)
        player:printToPlayer("Defeat the Provenance Watcher to obtain what you seek.", xi.msg.channel.SYSTEM_3)
        player:confirmTrade()
        
        if mob and not mob:isSpawned() then
            mob:setSpawn(-580.000, -228.500, 540.000, 64)
            mob:spawn()
        end
        
        return true
    elseif prog == p.AURORA_CRYSTAL_OBTAINED and npcUtil.tradeHasExactly(trade, xi.item.AURORA_CRYSTAL) then
        -- Quest completion
        npcUtil.giveKeyItem(player, xi.ki.FAIL_BADGE)
        player:printToPlayer("You have failed...", xi.msg.channel.SYSTEM_3)
        player:confirmTrade()
        player:setVar("FailBadge", p.QUEST_FAILED)
        return true
    end
    return false
end

xi.failBadge.onTriggerProvenance = function(player, npc)
    local prog = player:getVar('FailBadge')
    local p = xi.failBadge.progress

    if prog == p.READY_FOR_PROVENANCE then
        player:printToPlayer("Trade me the Twilight Crystal to begin your final challenge.", xi.msg.channel.SYSTEM_3)
    elseif prog == p.BOSS_FIGHT then
        player:printToPlayer("Return to Achieve Master in Ru'Lude Gardens.", xi.msg.channel.SYSTEM_3)
    elseif prog == p.AURORA_CRYSTAL_OBTAINED then
        player:printToPlayer("Trade me the Aurora Crystal to receive your reward.", xi.msg.channel.SYSTEM_3)
    elseif prog == p.QUEST_FAILED then
        player:printToPlayer("You're a failure!", xi.msg.channel.SYSTEM_3)
    end
end

return xi.failBadge
