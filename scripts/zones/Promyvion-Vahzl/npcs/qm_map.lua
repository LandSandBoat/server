-----------------------------------
-- Area: Promyvion-Vahzl
--  NPC: ??? (map acquisition)
-- TODO: QM moves every 20-30 minutes. need retail cap of all possible positions
-- known positions include:
-- !pos 252.000 -2.326 -119.994 22
-----------------------------------
local ID = zones[xi.zone.PROMYVION_VAHZL]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.WHITE_MEMOSPHERE) and
        not player:hasKeyItem(xi.ki.MAP_OF_PROMYVION_VAHZL)
    then
        player:startEvent(48)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.MAP_OF_PROMYVION_VAHZL) then
        player:messageSpecial(ID.text.EERIE_GREEN_GLOW)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY_MAP)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 48 then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_PROMYVION_VAHZL)
    end
end

return entity
