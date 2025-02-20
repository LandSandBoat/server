-----------------------------------
-- Area: Cape Teriggan
--  NPC: <this space intentionally left blank>
-- !pos 73 4 -174 113
-----------------------------------
local ID = zones[xi.zone.CAPE_TERIGGAN]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.FUTATOKOROTO and
        npcUtil.tradeHas(trade, { xi.item.RANPERRE_GOLDPIECE, xi.item.SNARLED_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.FUTATOKOROTO })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(18, xi.item.YOICHINOYUMI)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 18 and
        npcUtil.giveItem(player, { xi.item.YOICHINOYUMI, { xi.item.MONTIONT_SILVERPIECE, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
