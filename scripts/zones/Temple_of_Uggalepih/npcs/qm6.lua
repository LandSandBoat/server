-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Sacrificial Goblet NM)
-- !pos 300 1 255 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.UGGALEPIH_WHISTLE) and
        npcUtil.popFromQM(player, npc, ID.mob.SACRIFICIAL_GOBLET, { hide = 0 })
    then
        player:confirmTrade()
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

return entity
