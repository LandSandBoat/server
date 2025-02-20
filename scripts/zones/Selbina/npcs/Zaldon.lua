-----------------------------------
-- Area: Selbina
--  NPC: Zaldon
-- Involved in Quests: Under the sea, A Boy's Dream
-- Starts and Finishes: Inside the Belly
-- !pos -13 -7 -5 248
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- A BOY'S DREAM
    if
        player:getCharVar('aBoysDreamCS') == 5 and
        npcUtil.tradeHasExactly(trade, xi.item.ODONTOTYRANNUS)
    then
        player:startEvent(85)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- A BOY'S DREAM
    if csid == 85 then
        npcUtil.giveKeyItem(player, xi.ki.KNIGHTS_BOOTS)
        player:setCharVar('aBoysDreamCS', 6)
        player:confirmTrade()
    end
end

return entity
