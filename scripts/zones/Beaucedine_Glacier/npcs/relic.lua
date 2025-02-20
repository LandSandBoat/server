-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: <this space intentionally left blank>
-- !pos -89 0 -374 111
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.VALHALLA and
        npcUtil.tradeHas(trade, { xi.item.RANPERRE_GOLDPIECE, xi.item.INTRICATE_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.VALHALLA })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(139, xi.item.RAGNAROK)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 139 and
        npcUtil.giveItem(player, { xi.item.RAGNAROK, { xi.item.MONTIONT_SILVERPIECE, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
