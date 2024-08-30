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

-- NOTE: Change this to play with the synergy furnace
local testSynergy = false

xi.synergy.synergyFurnaceOnTrade = function(player, npc, trade)
    if not testSynergy then
        return
    end

    -- TODO: Use trade to look up recipe information

    -- Test recipe: 2x Excalipoor -> Excalipoor II
    if not npcUtil.tradeHasExactly(trade, { { xi.item.EXCALIPOOR, 2 } }) then
        return
    end

    local recipeItemId  = xi.item.EXCALIPOOR_II
    local recipeItemQty = 1
    local recipeRank    = xi.craftRank.AMATEUR

    -- NOTE: Remember that FIRE is 1, so we're going to offset with -1 later
    -- NOTE: If the value is zero, the icon won't be shown
    local fewellCosts =
    {
        [xi.element.FIRE]    = 0,
        [xi.element.ICE]     = 0,
        [xi.element.WIND]    = 0,
        [xi.element.EARTH]   = 0,
        [xi.element.THUNDER] = 0,
        [xi.element.WATER]   = 0,
        [xi.element.LIGHT]   = 5,
        [xi.element.DARK]    = 5,
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
    if not testSynergy then
        return
    end

    -- local fireFewell = 99
    -- local iceFewell = 99
    -- local windFewell = 99
    -- local earthFewell = 99
    -- local lightningFewell = 99
    -- local waterFewell = 99
    -- local lightFewell = 99
    -- local darkFewell = 99

    -- Initially: Claim furnace
    -- Claim == system message
    -- Walk away == system message

    -- If you have claim: Relinquish csid
    -- player:startEvent(4520, fireFewell, iceFewell, windFewell, earthFewell, lightningFewell, waterFewell, lightFewell, darkFewell)

    -- If you've started synergy
    player:startEvent(4518, 0, 1, 0, 0, 0, 0, 0, 0)
end

xi.synergy.synergyFurnaceOnEventUpdate = function(player, csid, option, npc)
    if not testSynergy then
        return
    end

    print('> Update CSID:', csid, 'Option:', option)

    local optionByte0, _, optionByte2, _ = utils.toBytes(option)
    -- print('Bytes:', optionByte0, optionByte1, optionByte2, optionByte3)

    local fireFewell = 0
    local iceFewell = 1
    local windFewell = 2
    local earthFewell = 3
    local lightningFewell = 4
    local waterFewell = 5
    local lightFewell = 6
    local darkFewell = 7

    if csid == 4518 then
        local updateOperations =
        {
            [100] = function() -- Feed fewell: Fire
            end,

            [101] = function() -- Feed fewell: Ice
            end,

            [102] = function() -- Feed fewell: Wind
            end,

            [103] = function() -- Feed fewell: Earth
            end,

            [104] = function() -- Feed fewell: Lightning
            end,

            [105] = function() -- Feed fewell: Water
            end,

            [106] = function() -- Feed fewell: Light
            end,

            [107] = function() -- Feed fewell: Dark
            end,

            [120] = function() -- Operate furnace: Thwack furnace
            end,

            [121] = function() -- Operate furnace: Operate pressure handle
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
    if not testSynergy then
        return
    end

    print('> Finish CSID:', csid, 'Option:', option)

    if csid == 4520 and option == 146 then     -- Relinquish csid
        --
    elseif csid == 4521 and option == 150 then -- Commence synergy (150 yes, 151 no)
        -- system message: Commencing synergy process
        -- animation: Furnace lid closing
        player:confirmTrade() -- items are taken!
        -- player is free to move around
        -- You must be within a certain range to interact with the furnace
    elseif csid == 4518 and option == 0 then
        --
    end
end
