-----------------------------------
-- Area: Pso'xja
--  NPC: ???
-- Notes: Used to spawn Golden-Tongued Culberry
-- !pos -270.063 31.395 256.812 9
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local pendantChance = 0

    if npcUtil.tradeHasExactly(trade, xi.item.ODOROUS_KNIFE) then
        pendantChance = 500
    elseif npcUtil.tradeHasExactly(trade, xi.item.ODOROUS_KNIFE_P1) then
        pendantChance = 1000
    end

    if
        pendantChance > 0 and
        npcUtil.popFromQM(player, npc, ID.mob.GOLDEN_TONGUED_CULBERRY)
    then
        player:confirmTrade()
        GetMobByID(ID.mob.GOLDEN_TONGUED_CULBERRY):setLocalVar('DropRate', pendantChance)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.BROKEN_KNIFE)
end

return entity
