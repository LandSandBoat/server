-----------------------------------
-- Area: Eastern Adoulin (257)
--  NPC: Ujlei Zelekk
-- Type: Peacekeepers Coalition Guard
-- !pos -102.754 -0.65 16.161 257
-- !gotoid 17830177
-----------------------------------
---@type TNpcEntity
local entity = {}

local items =
{
    [   4] = { cost = 2500, id = xi.item.COALITION_POTION },
    [ 260] = { cost = 2500, id = xi.item.COALITION_ETHER },
    [ 516] = { cost =   10, id = xi.item.SCROLL_OF_INSTANT_WARP },
    [ 772] = { cost =   10, id = xi.item.SCROLL_OF_INSTANT_RERAISE },
    [1028] = { cost = 1000, id = xi.item.SCROLL_OF_INSTANT_PROTECT },
    [1284] = { cost = 1000, id = xi.item.SCROLL_OF_INSTANT_SHELL },
    [1540] = { cost = 1000, id = xi.item.SCROLL_OF_INSTANT_STONESKIN },
    [1796] = { cost = 2000, id = xi.item.CIPHER_OF_MARGRETS_ALTER_EGO },
    [2052] = { cost = 2000, id = xi.item.CIPHER_OF_AMCHUCHUS_ALTER_EGO },
    [2308] = { cost = 2000, id = xi.item.CIPHER_OF_MORIMARS_ALTER_EGO },
}

entity.onTrigger = function(player, npc)
    local active = xi.extravaganza.campaignActive()
    local bayld = player:getCurrency('bayld')
    local edification = 0 -- TODO: Link Coalition Status to edification
    local ciphers =
    {
        [0] =   0, -- no campaign
        [1] =  20, -- Summer/NY campaign
        [2] =  96, -- Spring/Fall campaign
        [3] = 116, -- Both campaigns
    }

    if active > 0 then -- TODO: implement logic to know when to display full Coalition Menu
        player:startEvent(7513, 0, ciphers[active], edification, bayld)
    else
        -- Stare blankly For now
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local bayld = player:getCurrency('bayld')
    local ID = zones[player:getZoneID()]

    if csid == 7513 and option < 2309 then
        if bayld >= items[option].cost then
            if npcUtil.giveItem(player, items[option].id) then
                player:delCurrency('bayld', items[option].cost)
            end
        elseif bayld < items[option].cost then
            player:messageSpecial(ID.text.NOT_ENOUGH_BAYLD)
        end
    end
end

return entity
