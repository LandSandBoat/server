-----------------------------------
-- Area: Norg
--  NPC: Vaultimand
-- Type: Fame Checker
-- !pos -10.839 -1 18.730 252
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local norgFame = player:getFameLevel(xi.fameArea.NORG)

    player:startEvent(100 + (norgFame - 1))
end

return entity
