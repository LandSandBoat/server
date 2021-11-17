-----------------------------------
-- Abyssea Sturdy Pyxis - Key item
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.ki = {}

---------------------------------
-- drop id's for keyitems
-- use zone id as the key
---------------------------------
local drops =
{
    [xi.zone.ABYSSEA_KONSCHTAT]  = {
        xi.ki.FRAGRANT_TREANT_PETAL,
        xi.ki.FETID_RAFFLESIA_STALK,
        xi.ki.DECAYING_MORBOL_TOOTH,
        xi.ki.TURBID_SLIME_OIL,
        xi.ki.VENOMOUS_PEISTE_CLAW,
        xi.ki.TATTERED_HIPPOGRYPH_WING,
        xi.ki.CRACKED_WIVRE_HORN,
        xi.ki.MUCID_AHRIMAN_EYEBALL
    },
    [xi.zone.ABYSSEA_TAHRONGI   ] = {1476,1471,1477,1470,1472,1473,1474,1475,1469,1468},
    [xi.zone.ABYSSEA_LA_THEINE  ] = {1478,1479,1480,1485,1486,1483,1484,1482,1481},
    [xi.zone.ABYSSEA_ATTOHWA    ] = {1489,1490,1488,1491,1492,1494},
    [xi.zone.ABYSSEA_MISAREAUX  ] = {1502,1504,1499,1501,1505,1500},
    [xi.zone.ABYSSEA_VUNKERL    ] = {1509,1508,1510,1514,1511},
    [xi.zone.ABYSSEA_ALTEPA     ] = {0,0,0},
    [xi.zone.ABYSSEA_ULEGUERAND ] = {0,0,0},
    [xi.zone.ABYSSEA_GRAUBERG   ] = {0,0,0},
}

xi.pyxis.ki.setKeyItems = function(npc)
    local zoneId = npc:getZoneID()
    local ki = drops[zoneId][math.random(1, #drops[zoneId])]
    npc:setLocalVar("KI", ki)
end

xi.pyxis.ki.updateEvent = function(player, npc)
    player:updateEvent(npc:getLocalVar("KI"), 0, 0, 0, 0, 0, 0, 0)
end

xi.pyxis.ki.giveKeyItem = function(player, npc)
    local keyItem = npc:getLocalVar("KI")
    local zoneId = player:getZoneID()

    if keyItem == 0 then
        player:messageSpecial(zones[zoneId].text.KEYITEM_DISAPPEARED)
        return
    elseif player:hasKeyItem(keyItem) then
        player:messageSpecial(zones[zoneId].text.ALREADY_POSSESS_KEY_ITEM)
        return
    else
        player:addKeyItem(keyItem)
        xi.pyxis.messageChest(player, zones[zoneId].text.OBTAINS_KEYITEM, keyItem, 0, 0, 0)
        npc:setLocalVar("KI", 0)
    end

    if npc:getLocalVar("KI") == 0 then
        xi.pyxis.removeChest(player, npc, 0, 3)
    end
end
