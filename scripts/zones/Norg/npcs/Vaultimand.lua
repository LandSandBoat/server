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
    NorgFame = player:getFameLevel(NORG)

    player:startEvent(100 + (NorgFame - 1))
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
