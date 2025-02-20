-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Eugballion
-- Only sells when San d'Oria controlls Qufim Region
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.QUFIMISLAND) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.EUGBALLION_CLOSED_DIALOG)
    else
        local stock =
        {
            954, 4121,    -- Magic Pot Shard
        }

        player:showText(npc, ID.text.EUGBALLION_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
