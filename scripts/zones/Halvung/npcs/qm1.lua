-----------------------------------
-- Area: Halvung
--  NPC: ??? (Spawn Big Bomb)
-- !pos -233.830 13.613 286.714 62
-----------------------------------
local ID = zones[xi.zone.HALVUNG]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.SMOKE_FILLED_FLASK) and
        npcUtil.popFromQM(player, npc, ID.mob.BIG_BOMB)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.BLUE_FLAMES)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
