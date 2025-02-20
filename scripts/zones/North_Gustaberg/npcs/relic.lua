-----------------------------------
-- Area: North Gustaberg
--  NPC: <this space intentionally left blank>
-- !pos -217 97 461 106
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.BEC_DE_FAUCON and
        npcUtil.tradeHas(trade, { xi.item.RIMILALA_STRIPESHELL, xi.item.TENEBROUS_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.BEC_DE_FAUCON })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(254, xi.item.APOCALYPSE)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 254 and
        npcUtil.giveItem(player, { xi.item.APOCALYPSE, { xi.item.LUNGO_NANGO_JADESHELL, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
