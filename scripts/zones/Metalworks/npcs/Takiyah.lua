-----------------------------------
-- Area: Metalworks
--  NPC: Takiyah
-- Type: Regional Merchant
-----------------------------------
local ID = zones[xi.zone.METALWORKS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.QUFIMISLAND) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.TAKIYAH_CLOSED_DIALOG)
    else
        local stock =
        {
            954, 4121,    -- Magic Pot Shard
        }

        player:showText(npc, ID.text.TAKIYAH_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
