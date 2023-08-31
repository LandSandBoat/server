-----------------------------------
-- Area:  Nyzul_Isle
-- NPC:   Rune of Transfer
-- Notes: Allows players to select a floor to transport to
-- !pos -20.000 -4.000 -11.000
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.nyzul.firstRuneOfTransferOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.nyzul.firstRuneOfTransferOnEventFinish(player, csid, option, npc)
end

return entity
