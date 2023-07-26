-----------------------------------
-- Area: Norg
--  NPC: Vaultimand
-- Type: Fame Checker
-- !pos -10.839 -1 18.730 252
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local norgFame = player:getFameLevel(xi.quest.fame_area.NORG)

    player:startEvent(100 + (norgFame - 1))
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
