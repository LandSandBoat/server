-----------------------------------
-- Area: Uleguerand Range
--  NPC: Eternal Ice
--  Gives key item Mystic Ice upon examining
-- !pos 575 -26 -101 5
-- !pos 455 -82 421 5
-- !pos -95 -146 378 5
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.MYSTIC_ICE) then
        npcUtil.giveKeyItem(player, xi.ki.MYSTIC_ICE)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
