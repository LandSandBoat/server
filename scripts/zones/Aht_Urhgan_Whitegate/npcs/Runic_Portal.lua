-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Runic Portal
-- Aht Urhgan Teleporter to Other Areas
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local runicPortals  = player:getTeleport(xi.teleport.type.RUNIC_PORTAL)
    local assaultOrders =
    {
        [0] = { KI = xi.ki.LEUJAOAM_ASSAULT_ORDERS,   tele = 0x02, valid = 2,  event = 120 },
        [1] = { KI = xi.ki.MAMOOL_JA_ASSAULT_ORDERS,  tele = 0x08, valid = 8,  event = 121 },
        [2] = { KI = xi.ki.LEBROS_ASSAULT_ORDERS,     tele = 0x10, valid = 16, event = 122 },
        [3] = { KI = xi.ki.PERIQIA_ASSAULT_ORDERS,    tele = 0x04, valid = 4,  event = 123 },
        [4] = { KI = xi.ki.ILRUSI_ASSAULT_ORDERS,     tele = 0x20, valid = 32, event = 124 },
        [5] = { KI = xi.ki.NYZUL_ISLE_ASSAULT_ORDERS, tele = 0x40, valid = 64, event = 125 },
    }

    if xi.assault.hasOrders(player) then
        for k, v in pairs(assaultOrders) do
            if player:hasKeyItem(v.KI) then
                local validTeleport = bit.band(runicPortals, v.tele)
                player:messageSpecial(ID.text.CONFIRMING, v.KI)

                if validTeleport == v.valid then
                    player:startEvent(v.event)
                else
                    player:messageSpecial(ID.text.RUNIC_DENIED_ASSAULT_OFFSET + k)
                end

                break
            end
        end
    else
        local hasPermit = player:hasKeyItem(xi.ki.RUNIC_PORTAL_USE_PERMIT)
        local mercRank  = xi.besieged.getMercenaryRank(player)
        local points    = player:getCurrency('imperial_standing')
        local hasAstral = xi.besieged.getAstralCandescence()
        local isCaptain = player:hasKeyItem(xi.ki.CAPTAIN_WILDCAT_BADGE)

        if isCaptain then
            player:messageSpecial(ID.text.IMPERIAL_AUTHORIZATION) -- TODO: This may show in other cases
            hasPermit = false -- #1 and  #7 are always set to 0 for Captains
        end

        player:startEvent(101, hasPermit and xi.ki.RUNIC_PORTAL_USE_PERMIT or 0, runicPortals, mercRank, points, isCaptain and 1 or 0, hasAstral, hasPermit and 1 or 0, 0)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local portalPick =
    {
        [1]    = xi.teleport.id.AZOUPH_SP,
        [2]    = xi.teleport.id.DVUCCA_SP,
        [3]    = xi.teleport.id.MAMOOL_SP,
        [4]    = xi.teleport.id.HALVUNG_SP,
        [5]    = xi.teleport.id.ILRUSI_SP,
        [6]    = xi.teleport.id.NYZUL_SP,
        [101]  = xi.teleport.id.AZOUPH_SP,
        [102]  = xi.teleport.id.DVUCCA_SP,
        [103]  = xi.teleport.id.MAMOOL_SP,
        [104]  = xi.teleport.id.HALVUNG_SP,
        [105]  = xi.teleport.id.ILRUSI_SP,
        [106]  = xi.teleport.id.NYZUL_SP,
        [120]  = xi.teleport.id.AZOUPH_SP,
        [121]  = xi.teleport.id.MAMOOL_SP,
        [122]  = xi.teleport.id.HALVUNG_SP,
        [123]  = xi.teleport.id.DVUCCA_SP,
        [124]  = xi.teleport.id.ILRUSI_SP,
        [125]  = xi.teleport.id.NYZUL_SP,
        [1001] = xi.teleport.id.AZOUPH_SP,
        [1002] = xi.teleport.id.DVUCCA_SP,
        [1003] = xi.teleport.id.MAMOOL_SP,
        [1004] = xi.teleport.id.HALVUNG_SP,
        [1005] = xi.teleport.id.ILRUSI_SP,
        [1006] = xi.teleport.id.NYZUL_SP,
    }

    if csid == 101 and option > 100 and option < 1007 then
        if option >= 101 and option <= 106 then
            player:delKeyItem(xi.ki.RUNIC_PORTAL_USE_PERMIT)
            xi.teleport.to(player, portalPick[option])
        elseif option >= 1001 and option <= 1006 then
            if player:getCurrency('imperial_standing') >= 200 then
                player:delCurrency('imperial_standing', 200)
                xi.teleport.to(player, portalPick[option])
            else
                player:messageSpecial(ID.text.SUFFICIENT_IMPERIAL_STANDING)
            end
        end
    elseif csid == 101 and option >= 1 and option <= 6 then -- Captains dont lose permit
        xi.teleport.to(player, portalPick[option])
    elseif csid >= 120 and csid <= 125 and option == 1 then
        xi.teleport.to(player, portalPick[csid])
    end
end

return entity
