-----------------------------------
-- Assault Loot Functions
-----------------------------------
xi = xi or {}
xi.assault = xi.assault or {}
-----------------------------------

xi.assault.canGetUnappraisedItem = function(player, assaultID)
    local cap            = player:getInstance():getLevelCap()
    local content        = xi.assault.contents[assaultID]
    local suggestedLevel = content and content.suggestedLevel or 0

    return cap == 0 or cap >= suggestedLevel
end

xi.assault.pickUnappraisedItem = function(player, npc, qItemTable)
    if npc:getLocalVar('UnappraisedItem') == 0 then
        local selectedLoot = utils.selectFromLootGroups(player, qItemTable)
        if #selectedLoot > 0 then
            npc:setLocalVar('UnappraisedItem', selectedLoot[1].itemId)
        end
    end

    return npc:getLocalVar('UnappraisedItem')
end

xi.assault.assaultChestTrigger = function(player, npc, qItemTable, regItemTable)
    -- Early return: Chest already opened.
    if npc:getLocalVar('open') ~= 0 then
        return
    end

    -- Early return: No instance.
    local instance = player:getInstance()
    if not instance then
        return
    end

    -- Early return: Instance is not complete.
    if not instance:completed() then
        return
    end

    local assaultID = player:getCurrentAssault()
    if xi.assault.canGetUnappraisedItem(player, assaultID) then
        local unappraisedItem = xi.assault.pickUnappraisedItem(player, npc, qItemTable)
        if unappraisedItem ~= 0 then
            local zoneText = zones[player:getZoneID()].text

            -- Player has full inventory, send message and skip item reward
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(zoneText.ITEM_CANNOT_BE_OBTAINED, unappraisedItem)
                return
            end

            player:addItem({ id = unappraisedItem, appraisal = assaultID })

            for _, member in pairs(instance:getChars()) do
                member:messageName(zoneText.PLAYER_OBTAINS_ITEM, player, unappraisedItem)
            end
        end
    end

    npc:entityAnimationPacket(xi.animationString.OPEN_CRATE_GLOW)
    npc:setLocalVar('open', 1)
    npc:setUntargetable(true)
    npc:timer(15000, function(npcArg)
        npcArg:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
    end)

    npc:timer(16000, function(npcArg)
        npcArg:setStatus(xi.status.DISAPPEAR)
    end)

    local selectedLoot = utils.selectFromLootGroups(player, regItemTable)
    for _, entry in ipairs(selectedLoot) do
        -- regItemTable is guaranteed to not have xi.item.GIL in the table
        player:addTreasure(entry.itemId, npc)
    end
end

xi.assault.onLockboxTrigger = function(player, npc)
    local assaultID = player:getCurrentAssault()
    local content   = xi.assault.contents[assaultID]

    if not content then
        return
    end

    if type(content.onLockboxOpen) == 'function' then
        content:onLockboxOpen(player, npc)
    elseif content.loot and content.loot.appraisalReward then
        xi.assault.assaultChestTrigger(player, npc, content.loot.appraisalReward, content.loot.bonusLoot or {})
    end
end
