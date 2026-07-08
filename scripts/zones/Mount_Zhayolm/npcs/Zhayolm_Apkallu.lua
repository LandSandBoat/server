-----------------------------------
-- Area: Mount Zhayolm
--  NPO: Zhayolm Apkallu
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeSetInList(trade, xi.apkallu.fish) then
        player:confirmTrade()
        npc:follow(player, xi.followType.ROAM)
    end
end

return entity
