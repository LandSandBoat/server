-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Blendare
-- !pos 33.033 0.999 -30.119 230
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 10) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    player:startEvent(606)  -- my brother always takes my sweets
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 606 then
        player:setCharVar('BrothersCS', 1)
    end
end

return entity
