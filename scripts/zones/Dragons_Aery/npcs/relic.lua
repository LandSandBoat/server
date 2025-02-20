-----------------------------------
-- Area: Dragon's Aery
--  NPC: <this space intentionally left blank>
-- !pos -20 -2 61 154
-----------------------------------
local ID = zones[xi.zone.DRAGONS_AERY]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.CALIBURN and
        npcUtil.tradeHas(trade, { xi.item.RANPERRE_GOLDPIECE, xi.item.HOLY_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.CALIBURN })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(3, xi.item.EXCALIBUR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 3 and
        npcUtil.giveItem(player, { xi.item.EXCALIBUR, { xi.item.MONTIONT_SILVERPIECE, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
