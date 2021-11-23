-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Runic Portal
-- Aht Urhgan Teleporter to Other Areas
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------
require("scripts/globals/besieged")
require("scripts/globals/keyitems")
require("scripts/globals/teleports")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local hasAssault, keyitem = xi.besieged.hasAssaultOrders(player)

    if hasAssault > 0 then
        player:messageSpecial(ID.text.RUNIC_PORTAL + 9, keyitem)
        player:startEvent(hasAssault)
    else
        local hasPermit    = player:hasKeyItem(xi.ki.RUNIC_PORTAL_USE_PERMIT)
        local runicPortals = player:getTeleport(xi.teleport.type.RUNIC_PORTAL)
        local mercRank     = xi.besieged.getMercenaryRank(player)
        local points       = player:getCurrency("imperial_standing")
        local hasAstral    = xi.besieged.getAstralCandescence()

        player:startEvent(101, hasPermit and xi.ki.RUNIC_PORTAL_USE_PERMIT or 0, runicPortals, mercRank, points, 0, hasAstral, hasPermit and 1 or 0)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 101 then
        -- Runic Portal Use Permit.
        if option == 101 then
            xi.teleport.to(player, xi.teleport.id.AZOUPH_SP)
            player:delKeyItem(xi.ki.RUNIC_PORTAL_USE_PERMIT)
        elseif option == 102 then
            xi.teleport.to(player, xi.teleport.id.DVUCCA_SP)
            player:delKeyItem(xi.ki.RUNIC_PORTAL_USE_PERMIT)
        elseif option == 103 then
            xi.teleport.to(player, xi.teleport.id.MAMOOL_SP)
            player:delKeyItem(xi.ki.RUNIC_PORTAL_USE_PERMIT)
        elseif option == 104 then
            xi.teleport.to(player, xi.teleport.id.HALVUNG_SP)
            player:delKeyItem(xi.ki.RUNIC_PORTAL_USE_PERMIT)
        elseif option == 105 then
            xi.teleport.to(player, xi.teleport.id.ILRUSI_SP)
            player:delKeyItem(xi.ki.RUNIC_PORTAL_USE_PERMIT)
        elseif option == 106 then
            xi.teleport.to(player, xi.teleport.id.NYZUL_SP)
            player:delKeyItem(xi.ki.RUNIC_PORTAL_USE_PERMIT)

        -- Imperial Standing
        elseif option == 1001 then
            xi.teleport.to(player, xi.teleport.id.AZOUPH_SP)
            player:delCurrency("imperial_standing", 200)
        elseif option == 1002 then
            xi.teleport.to(player, xi.teleport.id.DVUCCA_SP)
            player:delCurrency("imperial_standing", 200)
        elseif option == 1003 then
            xi.teleport.to(player, xi.teleport.id.MAMOOL_SP)
            player:delCurrency("imperial_standing", 200)
        elseif option == 1004 then
            xi.teleport.to(player, xi.teleport.id.HALVUNG_SP)
            player:delCurrency("imperial_standing", 200)
        elseif option == 1005 then
            xi.teleport.to(player, xi.teleport.id.ILRUSI_SP)
            player:delCurrency("imperial_standing", 200)
        elseif option == 1006 then
            xi.teleport.to(player, xi.teleport.id.NYZUL_SP)
            player:delCurrency("imperial_standing", 200)
        end

    -- Assault Orders csid
    elseif csid == 120 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.AZOUPH_SP)
    elseif csid == 121 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.MAMOOL_SP)
    elseif csid == 122 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.HALVUNG_SP)
    elseif csid == 123 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.DVUCCA_SP)
    elseif csid == 124 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.ILRUSI_SP)
    elseif csid == 125 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.NYZUL_SP)
    end
end

return entity
