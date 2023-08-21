-----------------------------------
-- Area: Meriphataud Mountains [S]
--  NPC: ???
-- !pos 757 -16 -446 97
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS_S]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.JAR_OF_GNAT_PELLETS) and
        npcUtil.popFromQM(player, npc, ID.mob.BLOODLAPPER, { hide = 0 })
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
