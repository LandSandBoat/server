-----------------------------------
-- Area: Al'Taieu
--  NPC: Rubious Crystal (East Tower)
-- !pos 683.718 -6.250 -222.167 33
-----------------------------------
local ALTAIEU = require("scripts/zones/AlTaieu/globals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    ALTAIEU.rubiousCrystalOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    ALTAIEU.rubiousCrystalOnEventFinish(player, csid, option)
end

return entity
