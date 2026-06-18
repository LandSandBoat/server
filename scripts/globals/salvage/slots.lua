-----------------------------------
-- Salvage: Slot and Socket logic.
-----------------------------------
xi = xi or {}
xi.salvage = xi.salvage or {}

xi.salvage.handleSlot = function(player, npc, trade, card, mobID)
    if npcUtil.tradeHasExactly(trade, card) then
        local instance = npc:getInstance()
        SpawnMob(mobID, instance):updateClaim(player)
        player:confirmTrade()
        npc:setStatus(xi.status.DISAPPEAR)
    end
end

xi.salvage.handleSocket = function(player, npc, trade, mobID)
    local instance  = npc:getInstance()
    local mob       = GetMobByID(mobID, instance)
    local cellCount = trade:getItemCount()

    for cellType = xi.item.INCUS_CELL, xi.item.SPISSATUS_CELL do
        if cellCount <= 5 and trade:hasItemQty(cellType, cellCount) then
            player:tradeComplete()

            if mob then
                SpawnMob(mobID, instance):updateClaim(player)
                mob:setLocalVar('tradedCell', cellType)
                mob:setLocalVar('cellCount', cellCount)
                npc:setStatus(xi.status.DISAPPEAR)
            end
        end
    end
end

xi.salvage.handleSocketCells = function(mob, player)
    local amount = mob:getLocalVar('cellCount') * 2

    while amount > 0 do
        player:addTreasure(mob:getLocalVar('tradedCell'), mob)
        amount = amount - 1
    end
end
