-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: Excavation Point
-- Used in Quest: The Holy Crest
-- !pos 234 0.1 -110 198
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('TheHolyCrest_Event') == 3 and
        not player:hasItem(xi.item.WYVERN_EGG) and
        npcUtil.tradeHas(trade, xi.item.PICKAXE)
    then
        if npcUtil.giveItem(player, xi.item.WYVERN_EGG) then
            player:confirmTrade()
        end
    else
        xi.helm.onTrade(player, npc, trade, xi.helmType.EXCAVATION, 60)
    end
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helmType.EXCAVATION)
end

return entity
