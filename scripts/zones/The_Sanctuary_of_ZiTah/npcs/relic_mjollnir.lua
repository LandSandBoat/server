-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  NPC: <this space intentionally left blank>
-- !pos -18 0 55 121
-----------------------------------
local ID = zones[xi.zone.THE_SANCTUARY_OF_ZITAH]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local currentRelic = player:getCharVar('RELIC_IN_PROGRESS')

    if
        currentRelic == xi.item.GULLINTANI and
        npcUtil.tradeHas(trade, { xi.item.RANPERRE_GOLDPIECE, xi.item.HEAVENLY_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.GULLINTANI })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(216, xi.item.MJOLLNIR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 216 and
        npcUtil.giveItem(player, { xi.item.MJOLLNIR, { xi.item.MONTIONT_SILVERPIECE, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
