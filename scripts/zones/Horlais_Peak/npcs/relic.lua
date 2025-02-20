-----------------------------------
-- Area: Horlais Peak
--  NPC: <this space intentionally left blank>
-- !pos 450 -40 -31 139
-----------------------------------
local ID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.TOTSUKANOTSURUGI and
        npcUtil.tradeHas(trade, { xi.item.RANPERRE_GOLDPIECE, xi.item.DIVINE_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.TOTSUKANOTSURUGI })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(13, xi.item.AMANOMURAKUMO)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 13 and
        npcUtil.giveItem(player, { xi.item.AMANOMURAKUMO, { xi.item.MONTIONT_SILVERPIECE, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
