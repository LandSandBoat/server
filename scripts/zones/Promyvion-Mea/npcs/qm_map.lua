-----------------------------------
-- Area: Promyvion Mea
--  NPC: ??? (map acquisition)
-- TODO: QM moves every 20-30 minutes. need retail cap of all possible positions
-- known positions include:
-- !pos 280.001 -2.328 280.000 20
-- !pos 239.998 -2.329 120.000 20
-----------------------------------
local ID = zones[xi.zone.PROMYVION_MEA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.INDIGO_MEMOSPHERE) and
        not player:hasKeyItem(xi.ki.MAP_OF_PROMYVION_MEA)
    then
        player:startEvent(49)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.MAP_OF_PROMYVION_MEA) then
        player:messageSpecial(ID.text.EERIE_GREEN_GLOW)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 49 then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_PROMYVION_MEA)
    end
end

return entity
