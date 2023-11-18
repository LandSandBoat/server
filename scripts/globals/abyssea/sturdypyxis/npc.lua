-----------------------------------
-- Abyssea Sturdy Pyxis Npc
-----------------------------------
require('scripts/globals/abyssea/sturdypyxis/chest')
require('scripts/globals/abyssea/sturdypyxis/red_chest')
require('scripts/globals/abyssea/sturdypyxis/blue_chest')
require('scripts/globals/abyssea/sturdypyxis/gold_chest')
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.npc = {}

xi.pyxis.npc.contentMessage =
{
-----------------------------------
-- | Key | Value |          Description           | --
-----------------------------------
    [1]  = 0x0010000, -- Feeble soothing light
    [2]  = 0x0020000, -- Miniscule curor
    [3]  = 0x0030000, -- Tiny exp
    [4]  = 0x0050000, -- Faint soothing light
    [5]  = 0x0060000, -- Small cruor
    [6]  = 0x0070000, -- little exp
    [7]  = 0x0090000, -- Mild soothing light
    [8]  = 0x00A0000, -- Moderate cruor
    [9]  = 0x00B0000, -- Some exp
    [10] = 0x00D0000, -- Strong soothing light
    [11] = 0x00E0000, -- Considerable cruor
    [12] = 0x00F0000, -- Considerable exp
    [13] = 0x0110000, -- Intense soothing light
    [14] = 0x0120000, -- Numerous temp items (Does NOT show items when peering into chest, just drops what ever into inventory like normal chests)
    [15] = 0x0130000, -- Princely crour
    [16] = 0x0140000, -- Tremendous exp
    [17] = 0x0150000, -- Stone fragment (Time Extension)
    [18] = 0x0160000, -- Faint Pearl light
    [19] = 0x0170000, -- Faint Azure light
    [20] = 0x0180000, -- Faint Ruby light
    [21] = 0x0190000, -- Faint Amber light
    [22] = 0x01A0000, -- Mild Pearl light
    [23] = 0x01B0000, -- Mild Azure light
    [24] = 0x01C0000, -- Mild Ruby light
    [25] = 0x01D0000, -- Mild Amber light
    [26] = 0x01E0000, -- Strong Pearl light
    [27] = 0x01F0000, -- Strong Azure light
    [28] = 0x0200000, -- Strong Ruby light
    [29] = 0x0210000, -- Strong Amber light
    [30] = 0x0220000, -- Faint Gold light
    [31] = 0x0230000, -- Faint Silver light
    [32] = 0x0240000, -- Faint Ebon light
    [33] = 0x0250000, -- Intense Azure light
    [34] = 0x0260000, -- Intense Ruby light
    [35] = 0x0270000, -- Intense Amber light
    [36] = 0x0280000, -- Mild Gold light
    [37] = 0x0290000, -- Mild Silver light
    [38] = 0x02A0000, -- Mild Ebon light
    [39] = 0x02B0000, -- Strong Gold light
    [40] = 0x02C0000, -- Strong Silver light
    [41] = 0x02D0000, -- Strong Ebon light
    [42] = 0x1000000, -- Temp items
    [43] = 0x2000000, -- Items
    [44] = 0x3000000, -- Poweful items
    [45] = 0x4000000, -- Key items
    -- Total 45
}

local function GetEvents(chestTier)
    local lockedEvent = 2003 + chestTier
    local unlockedEvent = lockedEvent + 64

    return lockedEvent, unlockedEvent
end

xi.pyxis.npc.onPyxisTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    local chestTier = npc:getLocalVar('TIER')
    local dropType = npc:getLocalVar('DROPTYPE')

    if not xi.pyxis.canOpenChest(player, npc) then
        return
    end

    if npc:getAnimationSub() == 12 then
        if
            trade:hasItemQty(xi.item.FORBIDDEN_KEY, 1) and
            trade:getItemCount() == 1
        then
            player:tradeComplete()
            xi.pyxis.getDrops(npc, dropType, chestTier)
            xi.pyxis.messageChest(player, ID.text.TRADE_KEY_OPEN, 2490, 0, 0, 0, npc)
            xi.pyxis.openChest(player, npc)
        end
    end
end

xi.pyxis.npc.onPyxisTrigger = function(player, npc)
    local tier            = npc:getLocalVar('TIER')
    local dropType        = npc:getLocalVar('DROPTYPE')
    local chestType       = npc:getLocalVar('CHESTTYPE')         -- 1:Blue 'twist dial' || 2:Red 'pressure' || 3:Gold 'enter two-digit combination (10~99)'.
    local messagetype     = npc:getLocalVar('MESSAGE')
    local timeleft        = os.time() - npc:getLocalVar('[pyxis]SPAWNTIME')
    local contentMessage  = xi.pyxis.npc.contentMessage[messagetype] + chestType
    local lockedEvent, unlockedEvent = GetEvents(tier)

    if not xi.pyxis.canOpenChest(player, npc) then
        return
    end

    xi.pyxis.getDrops(npc, dropType, tier)

    timeleft = timeleft * 60
    --------------------------------------------------
    -- Chest Locked
    -------------------------------------------------

    if npc:getAnimationSub() == 12 then

        switch(chestType): caseof
        {
            [xi.pyxis.chestType.BLUE] = function()
                xi.pyxis.blueChest.startEvent(player, npc, lockedEvent, contentMessage, timeleft)
            end,

            [xi.pyxis.chestType.RED] = function()
                xi.pyxis.redChest.startEvent(player, npc, lockedEvent, contentMessage, timeleft)
            end,

            [xi.pyxis.chestType.GOLD] = function()
                xi.pyxis.goldChest.startEvent(player, npc, lockedEvent, contentMessage, timeleft)
            end,
        }
    --------------------------------------------------
    -- Chest Unlocked
    -------------------------------------------------
    elseif npc:getAnimationSub() == 13 then -- NOTE: Maybe change this incase players can alter npc animations
        local dropTypeEvent = 0
        switch(dropType): caseof
        {
            [xi.pyxis.chestDropType.TEMPORARY_ITEM] = function()
                dropTypeEvent = 1
            end,

            [xi.pyxis.chestDropType.POPITEM] = function()
                dropTypeEvent = 2
            end,

            [xi.pyxis.chestDropType.ITEM] = function()
                dropTypeEvent = 2
            end,

            [xi.pyxis.chestDropType.AUGMENTED_ITEM] = function()
                dropTypeEvent = 3
            end,

            [xi.pyxis.chestDropType.KEY_ITEM] = function()
                dropTypeEvent = 4
            end,
        }

        player:startEvent(unlockedEvent, 1, 1, 1, dropTypeEvent, 1, timeleft, 1, 1) -- Gold
    end
end

xi.pyxis.npc.onPyxisEventUpdate = function(player, csid, option, input)
    local npc            = player:getEventTarget()
    local dropType       = npc:getLocalVar('DROPTYPE')
    local tier           = npc:getLocalVar('TIER')
    local lockedEvent, unlockedEvent = GetEvents(tier)

    if csid == lockedEvent or csid == unlockedEvent then
        switch(dropType): caseof
        {
            [xi.pyxis.chestDropType.TEMPORARY_ITEM] = function() -- temps
                xi.pyxis.tempItem.updateEvent(player, npc)
            end,

            [xi.pyxis.chestDropType.ITEM] = function() -- basic items
                xi.pyxis.item.updateEvent(player, npc)
            end,

            [xi.pyxis.chestDropType.POPITEM] = function() -- pop items
                xi.pyxis.popitem.updateEvent(player, npc)
            end,

            [xi.pyxis.chestDropType.AUGMENTED_ITEM] = function() -- aug items
                xi.pyxis.augItem.updateEvent(player, npc)
            end,

            [xi.pyxis.chestDropType.KEY_ITEM] = function() -- ki's
                xi.pyxis.ki.updateEvent(player, npc)
            end,
        }
    end
end

xi.pyxis.npc.onPyxisEventFinish = function(player, csid, option, npc)
    local ID               = zones[player:getZoneID()]
    local spawnstatus      = npc:getLocalVar('SPAWNSTATUS')
    local chestTier        = npc:getLocalVar('TIER')
    local chestType        = npc:getLocalVar('CHESTTYPE')
    local dropType         = npc:getLocalVar('DROPTYPE')

    local lockedEvent, unlockedEvent = GetEvents(chestTier)
    local openchoice       = bit.lshift(1, option - 65)

    if option > 0 and spawnstatus ~= 1 then
        player:messageSpecial(ID.text.CHEST_DESPAWNED)
        return
    end

    if option == 999 then
        xi.pyxis.removeChest(player, npc, 1, 1)
        return
    end

    if csid == lockedEvent then
        switch(chestType): caseof
        {
            [xi.pyxis.chestType.BLUE] = function()
                xi.pyxis.blueChest.unlock(player, csid, option, npc)
            end,

            [xi.pyxis.chestType.RED] = function()
                xi.pyxis.redChest.unlock(player, csid, option, npc)
            end,

            [xi.pyxis.chestType.GOLD] = function()
                xi.pyxis.goldChest.unlock(player, csid, option, npc)
            end,
        }
    elseif csid == unlockedEvent then
    ------------------------------------
    -- Grab items out of the chest
    ------------------------------------
        if openchoice == 1 then
            switch(dropType): caseof
            {
                [xi.pyxis.chestDropType.TEMPORARY_ITEM] = function() -- Temp item
                    xi.pyxis.tempItem.giveTemporaryItem(player, npc, option)
                end,

                [xi.pyxis.chestDropType.ITEM] = function() -- Item
                    xi.pyxis.item.giveItem(player, npc, option)
                end,

                [xi.pyxis.chestDropType.POPITEM] = function() -- Item
                    xi.pyxis.popitem.givePopItem(player, npc, option)
                end,

                [xi.pyxis.chestDropType.AUGMENTED_ITEM] = function() -- AugmentedItem
                    xi.pyxis.augItem.giveAugItem(player, npc, option)
                end,

                [xi.pyxis.chestDropType.KEY_ITEM] = function() -- KI
                    xi.pyxis.ki.giveKeyItem(player, npc)
                end,
            }
        elseif openchoice == 2 then
            xi.pyxis.removeChest(player, npc, 1, 1)
        end
    end
end
