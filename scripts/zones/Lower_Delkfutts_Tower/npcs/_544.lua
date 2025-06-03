-----------------------------------
-- Area: Lower Delkfutt's Tower
--  NPC: Cermet Door
-- Notes: Door opens when you trade Delkfutt Key to it
-- !pos 345 0.1 20 184
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.DELKFUTT_KEY) then
        player:startOptionalCutscene(16)
    end
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
        player:startOptionalCutscene(16)
    else
        player:startEvent(10) -- door is firmly shut
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 16 and option == 1 then
        if not player:hasKeyItem(xi.ki.DELKFUTT_KEY) then
            npcUtil.giveKeyItem(player, xi.ki.DELKFUTT_KEY)
            player:confirmTrade()
        end
    end
end

return entity
