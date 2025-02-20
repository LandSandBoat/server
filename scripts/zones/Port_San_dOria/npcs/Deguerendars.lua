-----------------------------------
-- Area: Port San d'Oria
--  NPC: Deguerendars
-- Tavnazian Archipelago Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.THE_SAVAGE then
        if GetRegionOwner(xi.region.TAVNAZIANARCH) ~= xi.nation.SANDORIA then
            player:showText(npc, ID.text.DEGUERENDARS_CLOSED_DIALOG)
        else
            local stock =
            {
                1523,  290,    -- Apple Mint
                5164, 1945,    -- Ground Wasabi
                17005,  99,    -- Lufaise Fly
                5195,  233,    -- Misareaux Parsley
                1695,  920,    -- Habanero Peppers
            }

            player:showText(npc, ID.text.DEGUERENDARS_OPEN_DIALOG)
            xi.shop.general(player, stock, xi.fameArea.SANDORIA)
        end
    else
        player:showText(npc, ID.text.DEGUERENDARS_COP_NOT_COMPLETED)
    end
end

return entity
