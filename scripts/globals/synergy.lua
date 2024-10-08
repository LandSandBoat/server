-----------------------------------
-- Synergy
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.synergy = xi.synergy or {}

-----------------------------------
-- Synergy Furnace
-----------------------------------

-- NOTE: These are baked into every zone
local synergyMessages =
{
    -- TODO: Remove the 32k offset here
    CLAIM_EXPIRE            = 32786, -- (White) Your claim over the synergy furnace will expire in ten seconds.
    CLAIM_WARNING           = 32946, -- (Yellow) Warning! Your claim over the synergy furnace will be nullified if you venture any further away.
    CLAIM_SET               = 32787, -- (White) {Synergy crucible} set. Please deposit your ingredients inside the furnace and initiate the synergy process within 0 minutes.
    UNSUITABLE_ITEMS        = 32788, -- (White) Please be aware that certain items are not suitable for use as synergy ingredients.
    CLAIM_RELINQUISHED      = 32944, -- (Cream) Your claim to the synergy furnace has been relinquished.
    SYNERGY_COMMENCE        = 32837, -- (White) Commencing synergy process.
    TOO_FAR_AWAY            = 32945, -- (Yellow) You are too far away to operate the synergy furnace.
    SYNERGY_IMAGE_ELUSIVE   = 32841, -- (White) The synergy image eludes you.
    FEED_FEWELL             = 32855, -- (White) You feed the furnace <n> portion of (fire) fewell. (fire) elemental power climbs to <n>.
    ELEMENTAL_POWER_CLIMB   = 32840, -- (White) (fire) elemental power climbs to 9.
    INTERNAL_PRESSURE       = 32842, -- (White) Internal pressure: <n> Pz/lm. Impurity ratio: <n>%.
    ELEMENTAL_POWER_LEAKING = 32922, -- (White) (fire) elemental power has begun leaking from the furnace.
    INTERNAL_PRESSURE_FALL  = 32890, -- (White) Internal pressure has fallen to <n> Pz/lm.
    SYNERGY_IMAGE_FORMED    = 32848, -- (White) The synergy image has taken form.
    END_SYNERGY             = 32849, -- (White) Select 'End synergy' now to retrieve it!
    ELEMENTAL_POWER_NO_LEAK = 32923, -- (White) (fire) elemental power is no longer leaking.
    SYNERGY_COMPLETE        = 32929, -- (White) Synergy complete!
    SMOOTH_SYNERGIZING      = 32932, -- (Yellow) Smooth synergizing! A {item} has been successfully synergized!
    OBTAIN_PONZES           = 32935, -- (Yellow) {player} obtains <n> ponzes of cinder. Total: <n> Pz.
    REMOVE_FROM_FURNACE     = 169, -- You remove % from the furnace.
    REMOVE_FROM_FURNACE_N   = 170, -- You remove # % from the furnace.
    REMOVE_INGREDIENTS      = 171, -- You remove the ingredients from the furnace.
}

local furnaceStates =
{
    AVAILABLE = 0,
    CLAIMED   = 1,
    ACTIVE    = 2,
    COMPLETED = 3,
}

local vars =
{
    SYNERGY_FURNACE_NPC_ID         = 'synergyFurnaceNPCID',
    SYNERGY_FURNACE_PLAYER_ID      = 'synergyFurnacePlayerID',
    SYNERGY_FURNACE_STATE          = 'synergyFurnaceState',
    SYNERGY_FURNACE_CURRENT_RECIPE = 'synergyFurnaceCurrentRecipe',
}

-- NOTE: The animation states for furnaces can be moved between 1-3 in
--       any order, but use of 0 seems broken.
--     : 0 = closed (flashes out, broken?)
--     : 1 (or 5) = open
--     : 2 (or 6) = closed, active
--     : 3 (or 7) = closed, very active
local setFurnaceOpen = function(npc)
    npc:setAnimationSub(5)
end

local setFurnaceClosed = function(npc)
    npc:setAnimationSub(6)
end

local setFurnaceVeryActive = function(npc)
    npc:setAnimationSub(7)

    -- TODO: What are the conditions for 'very active'?
    npc:timer(1000, function(npcArg)
        setFurnaceClosed(npcArg)
    end)
end

xi.synergy.relinquishFurnaceClaim = function(player)
    print('relinquishFurnaceClaim')

    local npcID = player:getLocalVar(vars.SYNERGY_FURNACE_NPC_ID)
    if npcID == 0 then
        print('No furnace claimed')
        return
    end

    player:setLocalVar(vars.SYNERGY_FURNACE_NPC_ID, 0)

    local npc = GetNPCByID(npcID)
    if npc == nil then
        print('NPC not found:', npcID)
        return
    end

    npc:setLocalVar(vars.SYNERGY_FURNACE_PLAYER_ID, 0)

    setFurnaceOpen(npc)

    npc:setLocalVar(vars.SYNERGY_FURNACE_STATE, furnaceStates.AVAILABLE)

    player:messageSpecial(synergyMessages.CLAIM_RELINQUISHED)
end

xi.synergy.synergyDistanceChecker = function(player)
    -- TODO: Ensure sure multiple of this can't be attached to player/npc

    local npcID = player:getLocalVar(vars.SYNERGY_FURNACE_NPC_ID)
    if npcID == 0 then
        return
    end

    local npc = GetNPCByID(npcID)
    if npc == nil then
        return
    end

    local distance = player:checkDistance(npc)
    -- print('Distance:', distance)

    if distance > 6 then -- TODO: What are these actual distances
        player:messageSpecial(synergyMessages.CLAIM_EXPIRE)

        -- TODO: Limit how often this message triggers

        player:timer(10000, function(playerArg)
            xi.synergy.relinquishFurnaceClaim(playerArg)
        end)

        return
    elseif distance > 3 then -- TODO: What are these actual distances
        -- (Yellow) Warning! Your claim over the synergy furnace will be nullified if you venture any further away.
        player:messageSpecial(synergyMessages.CLAIM_WARNING)

        -- TODO: Limit how often this message triggers
    end

    -- Check every second
    player:timer(1000, function(playerArg)
        xi.synergy.synergyDistanceChecker(playerArg)
    end)
end

xi.synergy.attachToSynergyFurnace = function(player, npc)
    -- TODO: Start 1 minute timer

    -- Pair these together so we can easily find them
    player:setLocalVar(vars.SYNERGY_FURNACE_NPC_ID, npc:getID())
    npc:setLocalVar(vars.SYNERGY_FURNACE_PLAYER_ID, player:getID())
    npc:setLocalVar(vars.SYNERGY_FURNACE_STATE, furnaceStates.CLAIMED)

    xi.synergy.synergyDistanceChecker(player)
end

xi.synergy.synergyFurnaceOnTrade = function(player, npc, trade)
    if not xi.settings.main.ENABLE_SYNERGY then
        return
    end

    local furnaceState = npc:getLocalVar(vars.SYNERGY_FURNACE_STATE)

    if furnaceState ~= furnaceStates.CLAIMED then
        return
    end

    local claimedByYou = npc:getLocalVar(vars.SYNERGY_FURNACE_PLAYER_ID) == player:getID()
    if not claimedByYou then
        return
    end

    local recipe = GetSynergyRecipeByTrade(trade)
    if recipe == nil then
        print('Recipe not found')
        return
    end

    for i = 0, 7 do
        trade:confirmSlot(i)
    end

    local recipeId      = recipe['id'] -- This is for writing to the furnace so it can be pulled out later with GetSynergyRecipeByID()
    local recipeItemId  = recipe['result']
    local recipeItemQty = recipe['resultQty']
    local recipeRank    = recipe['primary_rank']

    npc:setLocalVar(vars.SYNERGY_FURNACE_CURRENT_RECIPE, recipeId)

    -- NOTE: Remember that FIRE is 1, so we're going to offset with -1 later
    -- NOTE: If the value is zero, the icon won't be shown
    local fewellCosts =
    {
        [xi.element.FIRE]    = recipe['cost_fire_fewell'],
        [xi.element.ICE]     = recipe['cost_ice_fewell'],
        [xi.element.WIND]    = recipe['cost_wind_fewell'],
        [xi.element.EARTH]   = recipe['cost_earth_fewell'],
        [xi.element.THUNDER] = recipe['cost_lightning_fewell'],
        [xi.element.WATER]   = recipe['cost_water_fewell'],
        [xi.element.LIGHT]   = recipe['cost_light_fewell'],
        [xi.element.DARK]    = recipe['cost_dark_fewell'],
    }

    local fewellMask = 0x00
    for key, value in pairs(fewellCosts) do
        if value > 0 then
            fewellMask = bit.bor(fewellMask, bit.lshift(1, key - 1)) -- The offset inside xi.element because of NONE
        end
    end

    local fewellCosts0 = bit.bor(
        bit.lshift(fewellCosts[xi.element.FIRE], 0),
        bit.lshift(fewellCosts[xi.element.ICE], 8),
        bit.lshift(fewellCosts[xi.element.WIND], 16),
        bit.lshift(fewellCosts[xi.element.EARTH], 24))

    local fewellCosts1 = bit.bor(
        bit.lshift(fewellCosts[xi.element.THUNDER], 0),
        bit.lshift(fewellCosts[xi.element.WATER], 8),
        bit.lshift(fewellCosts[xi.element.LIGHT], 16),
        bit.lshift(fewellCosts[xi.element.DARK], 24))

    local itemInfo = bit.bor(
        bit.lshift(recipeItemId, 0),
        bit.lshift(recipeItemQty, 16))

    player:startEvent(4521, fewellMask, fewellCosts0, fewellCosts1, itemInfo, recipeRank)
end

xi.synergy.synergyFurnaceOnTrigger = function(player, npc)
    if not xi.settings.main.ENABLE_SYNERGY then
        return
    end

    local fireFewell      = 99
    local iceFewell       = 99
    local windFewell      = 99
    local earthFewell     = 99
    local lightningFewell = 99
    local waterFewell     = 99
    local lightFewell     = 99
    local darkFewell      = 99

    local claimedByYou = npc:getLocalVar(vars.SYNERGY_FURNACE_PLAYER_ID) == player:getID()

    local furnaceState = npc:getLocalVar(vars.SYNERGY_FURNACE_STATE)
    print('Furnace state:', furnaceState)

    local handleFurnaceState =
    {
        [furnaceStates.AVAILABLE] = function()
            player:messageSpecial(synergyMessages.CLAIM_SET, xi.ki.SYNERGY_CRUCIBLE, 1)

            xi.synergy.attachToSynergyFurnace(player, npc)
        end,

        [furnaceStates.CLAIMED] = function()
            if not claimedByYou then
                -- TODO: Message
                return
            end

            player:startEvent(4520,
                fireFewell, iceFewell, windFewell, earthFewell,
                lightningFewell, waterFewell, lightFewell, darkFewell)
        end,

        [furnaceStates.ACTIVE] = function()
            if not claimedByYou then
                -- TODO: Message
                return
            end

            if player:checkDistance(npc) > 1.5 then
                player:messageSpecial(synergyMessages.TOO_FAR_AWAY)
                return
            end

            player:startEvent(4518, 0, 1, 0, 0, 0, 0, 0, 0)
        end,

        [furnaceStates.COMPLETED] = function()
            if not claimedByYou then
                -- TODO: Message
                return
            end

            local recipeId = npc:getLocalVar(vars.SYNERGY_FURNACE_CURRENT_RECIPE)
            local recipe = GetSynergyRecipeByID(recipeId)
            if recipe == nil then
                print('Recipe not found:', recipeId)
                return
            end

            local resultId  = recipe['result']
            local resultQty = recipe['resultQty']

            -- TODO: Look up and see if this HQ'd

            player:addItem(resultId, resultQty)

            if resultQty > 1 then
                player:messageSpecial(synergyMessages.REMOVE_FROM_FURNACE_N, resultId, resultQty)
            else
                player:messageSpecial(synergyMessages.REMOVE_FROM_FURNACE, resultId)
            end

            xi.synergy.relinquishFurnaceClaim(player)
        end,
    }

    handleFurnaceState[furnaceState]()
end

xi.synergy.synergyFurnaceOnEventUpdate = function(player, csid, option, npc)
    if not xi.settings.main.ENABLE_SYNERGY then
        return
    end

    -- print('> Update CSID:', csid, 'Option:', option)

    local optionByte0, _, optionByte2, _ = utils.toBytes(option)
    -- print('Bytes:', optionByte0, optionByte1, optionByte2, optionByte3)

    local fireFewell      = 0
    local iceFewell       = 1
    local windFewell      = 2
    local earthFewell     = 3
    local lightningFewell = 4
    local waterFewell     = 5
    local lightFewell     = 6
    local darkFewell      = 7

    if csid == 4518 then
        local updateOperations =
        {
            [100] = function() -- Feed fewell: Fire
                npc:entityAnimationPacket(xi.animationString.SYNERGY_FIRE_FEWELL)

                player:messageSpecial(synergyMessages.ELEMENTAL_POWER_LEAKING, 0)
                npc:entityAnimationPacket(xi.animationString.SYNERGY_FIRE_LEAK)
            end,

            [101] = function() -- Feed fewell: Ice
                npc:entityAnimationPacket(xi.animationString.SYNERGY_ICE_FEWELL)
            end,

            [102] = function() -- Feed fewell: Wind
                npc:entityAnimationPacket(xi.animationString.SYNERGY_WIND_FEWELL)
            end,

            [103] = function() -- Feed fewell: Earth
                npc:entityAnimationPacket(xi.animationString.SYNERGY_EARTH_FEWELL)
            end,

            [104] = function() -- Feed fewell: Lightning
                npc:entityAnimationPacket(xi.animationString.SYNERGY_LIGHTNING_FEWELL)
            end,

            [105] = function() -- Feed fewell: Water
                npc:entityAnimationPacket(xi.animationString.SYNERGY_WATER_FEWELL)
            end,

            [106] = function() -- Feed fewell: Light
                npc:entityAnimationPacket(xi.animationString.SYNERGY_LIGHT_FEWELL)
            end,

            [107] = function() -- Feed fewell: Dark
                npc:entityAnimationPacket(xi.animationString.SYNERGY_DARK_FEWELL)
            end,

            [120] = function() -- Operate furnace: Thwack furnace
            end,

            [121] = function() -- Operate furnace: Operate pressure handle
                npc:entityAnimationPacket(xi.animationString.SYNERGY_STEAM)
                setFurnaceVeryActive(npc)
                npc:timer(500, function(npcArg)
                    -- TODO: Look up what kind of leak we've just fixed
                    player:messageSpecial(synergyMessages.ELEMENTAL_POWER_LEAKING + 1, 0)
                    setFurnaceClosed(npcArg)
                end)
            end,

            [123] = function() -- Operate furnace: Operate safety lever
            end,

            [122] = function() -- Operate furnace: Repair furnace
            end,

            [124] = function() -- Operate furnace: Recycle strewn fewell
            end,

            [125] = function() -- Operate furnace: Fishing: Lunar Smarts
            end,

            [126] = function() -- Operate furnace: Fishing: Precision Thwack
            end,

            [127] = function() -- Operate furnace: Woodworking: Cyclical Smarts
            end,

            [128] = function() -- Operate furnace: Woodworking: Earth Affinity
            end,

            [129] = function() -- Operate furnace: Smithing: Combustive Smarts
            end,

            [130] = function() -- Operate furnace: Smithing: Fire Affinity
            end,

            [131] = function() -- Operate furnace: Goldsmithing: Engraver's Touch
            end,

            [132] = function() -- Operate furnace: Goldsmithing: Wind Affinity
            end,

            [133] = function() -- Operate furnace: Clothcraft: Restorer's Touch
            end,

            [134] = function() -- Operate furnace: Clothcraft: Lightning Affinity
            end,

            [135] = function() -- Operate furnace: Leathercraft: Pressurization Smarts
            end,

            [136] = function() -- Operate furnace: Leathercraft: Ice Affinity
            end,

            [137] = function() -- Operate furnace: Bonecraft: Carbonization Smarts
            end,

            [138] = function() -- Operate furnace: Bonecraft: Dark Affinity
            end,

            [139] = function() -- Operate furnace: Alchemy: Alchemical Smarts
            end,

            [140] = function() -- Operate furnace: Alchemy: Light Affinity
            end,

            [141] = function() -- Operate furnace: Cooking: Healing Smarts
            end,

            [142] = function() -- Operate furnace: Cooking: Water Affinity
            end,

            [145] = function() -- Operate furnace: DEBUG: Forced perfection
            end,

            [148] = function() -- Operate furnace: DEBUG: Set level (Requires a {Judge's arrow})
                local menuValue = optionByte2
                utils.unused(menuValue)
            end,

            [165] = function() -- Operate furnace: DEBUG: Set pressure/impurities -> pressure
                local menuValue = optionByte2
                utils.unused(menuValue)
            end,

            [166] = function() -- Operate furnace: DEBUG: Set pressure/impurities -> impurities
                local menuValue = optionByte2
                utils.unused(menuValue)
            end,

            [167] = function() -- Operate furnace: DEBUG: Something good
                local menuValue = optionByte2
                utils.unused(menuValue)
            end,

            [112] = function() -- View furnace readings 1
            end,

            [111] = function() -- View furnace readings 2
            end,

            [110] = function() -- End synergy (goes to finish)
            end,

            [163] = function() -- Review objective: LOCKS THE CLIENT, NEEDS TO BE PROPERLY POPULATED
            end,

            [164] = function() -- Toggle command confirmation off
            end,

            [143] = function() -- Populating fewell data
                player:updateEvent(
                    fireFewell, iceFewell, windFewell, earthFewell,
                    lightningFewell, waterFewell, lightFewell, darkFewell)
            end,

            [147] = function() -- first update when interacting with synergy action menu
            end,
        }

        --Execute
        updateOperations[optionByte0]()
    end
end

xi.synergy.synergyFurnaceOnEventFinish = function(player, csid, option, npc)
    if not xi.settings.main.ENABLE_SYNERGY then
        return
    end

    -- print('> Finish CSID:', csid, 'Option:', option)

    if csid == 4520 and option == 146 then -- Relinquish csid
        print('Relinquish furnace')

        xi.synergy.relinquishFurnaceClaim(player)
    elseif csid == 4521 and option == 150 then -- Commence synergy (150 yes, 151 no)
        print('Commence synergy')

        player:messageSpecial(synergyMessages.SYNERGY_COMMENCE)

        player:confirmTrade() -- items are taken!

        local npcId = player:getLocalVar(vars.SYNERGY_FURNACE_NPC_ID)
        local furnaceNpc = GetNPCByID(npcId)
        if furnaceNpc == nil then
            print('NPC not found:', npcId)
            return
        end

        setFurnaceClosed(furnaceNpc)
        npc:timer(2000, function(furnaceNpcArg)
            furnaceNpcArg:entityAnimationPacket(xi.animationString.SYNERGY_STEAM)
        end)

        furnaceNpc:setLocalVar(vars.SYNERGY_FURNACE_STATE, furnaceStates.ACTIVE)
    elseif csid == 4521 and option == 151 then -- Cancel after trade
        print('Cancel synergy')

        player:getTrade():clean()
    elseif csid == 4518 and option == 110 then -- Finish Synergy
        print('Finish synergy')

        local npcId = player:getLocalVar(vars.SYNERGY_FURNACE_NPC_ID)
        local furnaceNpc = GetNPCByID(npcId)
        if furnaceNpc == nil then
            print('NPC not found:', npcId)
            return
        end

        local recipeId = furnaceNpc:getLocalVar(vars.SYNERGY_FURNACE_CURRENT_RECIPE)
        local recipe = GetSynergyRecipeByID(recipeId)
        if recipe == nil then
            print('Recipe not found:', recipeId)
            return
        end

        player:messageSpecial(synergyMessages.SMOOTH_SYNERGIZING, recipeId)
        player:messageSpecial(synergyMessages.OBTAIN_PONZES, 1, 1)

        setFurnaceOpen(furnaceNpc)

        furnaceNpc:setLocalVar(vars.SYNERGY_FURNACE_STATE, furnaceStates.COMPLETED)
    end
end
