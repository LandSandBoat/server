-----------------------------------
-- Area: Ru'Aun Gardens
--  NPC: <this space intentionally left blank>
-- !pos -241 -12 332 130
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.GAE_ASSAIL and
        npcUtil.tradeHasExactly(trade, { xi.item.RIMILALA_STRIPESHELL, xi.item.STELLAR_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.GAE_ASSAIL })
    then -- currency, shard, necropsyche, stage 4
        player:startEvent(60, xi.item.GUNGNIR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 60 and
        npcUtil.giveItem(player, { xi.item.GUNGNIR, { xi.item.LUNGO_NANGO_JADESHELL, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
