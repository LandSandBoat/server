-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Spawn Anantaboga(ZNM T2))
-- !pos -368 -13 366 61
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.SLAB_OF_RAW_BUFFALO) and
        npcUtil.popFromQM(player, npc, ID.mob.ANANTABOGA, { hide = 0 })
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.STIFLING_STENCH)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
