-----------------------------------
-- Area: Eastern Adoulin (257)
--  NPC: Sifa Alani
-- Type: Map Vendor
-- !pos -103.834 -0.65 -50.226 257
-----------------------------------
local eastAdoulinID = zones[xi.zone.EASTERN_ADOULIN]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- NOTE: This table is 1-Indexed and needs to be subtracted by
-- one when generating the bitmask.
local mapList =
{ --  KeyItem                             Cost
    { xi.ki.MAP_OF_ADOULIN,                  0 },
    { xi.ki.MAP_OF_RALA_WATERWAYS,           0 },
    { xi.ki.MAP_OF_CEIZAK_BATTLEGROUNDS,     0 },
    { xi.ki.MAP_OF_YAHSE_HUNTING_GROUNDS,    0 },
    { xi.ki.MAP_OF_SIH_GATES,             1000 },
    { xi.ki.MAP_OF_MOH_GATES,             1000 },
    { xi.ki.MAP_OF_FORET_DE_HENNETIEL,    1000 },
    { xi.ki.MAP_OF_MORIMAR_BASALT_FIELDS, 1000 },
    { xi.ki.MAP_OF_CIRDAS_CAVERNS,        2000 },
    { xi.ki.MAP_OF_DHO_GATES,             2000 },
    { xi.ki.MAP_OF_MARJAMI_RAVINE,        2000 },
    { xi.ki.MAP_OF_YORCIA_WEALD,          2000 },
    { xi.ki.MAP_OF_WOH_GATES,             2000 },
    { xi.ki.MAP_OF_KAMIHR_DRIFTS,         2000 },
    { xi.ki.MAP_OF_RAKAZNAR,              2000 },
}

entity.onTrigger = function(player, npc)
    -- Event Parameter options:
    -- 0 : Unknown (Does not appear to impact CS)
    -- 1 : Bitmask based on the mapList table corresponding to player having the KI
    -- 2 : Bitmask for established Frontier Stations
    -- 3 : Player's current amount of Bayld

    -- TODO: Frontier Station bitmask currently locked to make all maps available, and
    -- needs to change once Frontier Station logic has been implemented.

    -- TODO: Needs verification to see if the map vendor is available prior to becoming
    -- a Pioneer

    local mapMask      = 0
    local frontierMask = 8388607 -- All Maps Available
    local playerBayld  = player:getCurrency('bayld')

    for maskPos, mapItem in ipairs(mapList) do
        if player:hasKeyItem(mapItem[1]) then
            mapMask = utils.mask.setBit(mapMask, 15 + maskPos, true)
        end
    end

    player:startEvent(7530, 0, mapMask, frontierMask, playerBayld)
end

entity.onEventFinish = function(player, csid, option, npc)
    local eventOption    = bit.band(option, 0xF)
    local eventSelection = bit.rshift(option, 8) + 1
    local playerBayld    = player:getCurrency('bayld')

    if eventOption == 1 then
        if playerBayld >= mapList[eventSelection][2] then
            player:delCurrency('bayld', mapList[eventSelection][2])
            npcUtil.giveKeyItem(player, mapList[eventSelection][1])
        else
            player:messageSpecial(eastAdoulinID.text.NOT_ENOUGH_BAYLD)
        end
    end
end

return entity
