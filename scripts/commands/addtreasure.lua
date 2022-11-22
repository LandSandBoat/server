-----------------------------------
-- func: addtreasure <itemId> <target player/party/alliance>
-- desc: Adds an item directly to the treasure pool.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "isi"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!addtreasure <itemID> (player) (npcID)")
end

function onTrigger(player, itemId, target, dropper)
    -- validate itemId
    if itemId ~= nil then
        itemId = tonumber(itemId)
    end

    if itemId == nil or itemId == 0 then
        error(player, "Invalid itemID.")
        return
    end

    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- validate dropper
    if dropper ~= nil then
        dropper = GetNPCByID(dropper)
        if dropper == nil then
            error(player, "Invalid npcID.")
            return
        end
    end

    -- add treasure to pool
    targ:addTreasure(itemId, dropper)
    player:PrintToPlayer(string.format("Item of ID %d was added to the treasure pool of %s or their party/alliance.", itemId, targ:getName()))
end
