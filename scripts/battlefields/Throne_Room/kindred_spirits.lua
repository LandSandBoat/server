-----------------------------------
-- Area: Throne Room
-- BCNM 60 - Kindred Spirits
-- !pos -111 -6 0.1 165
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/items")
require("scripts/globals/zone")
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.THRONE_ROOM,
    battlefieldId = xi.battlefield.id.KINDRED_SPIRITS,
    maxPlayers    = 6,
    levelCap      = 60,
    timeLimit     = utils.minutes(30),
    index         = 2,
    entryNpc      = "_4l1",
    exitNpcs      = { "_4l2", "_4l3", "_4l4" },
    requiredItems = { xi.items.MOON_ORB, message = ID.text.A_CRACK_HAS_FORMED },

})

function content:isValidEntry(player, npc)
    return self.entryNpc == '_4l1'
end

function content:onEntryEventUpdate(player, csid, option, npc)
    if Battlefield.onEntryEventUpdate(self, player, csid, option, npc) then
        if npc:getName() == '_4l1' then
            self.exitLocation = 1
            self.lossEventParams  = { [5] = 1 }
        else
            self.exitLocation = 0
            self.lossEventParams  = {}
        end
    end
end

content.groups =
{
    { mobs = { "Demons_Elemental" } },
}

content:addEssentialMobs({ "Count_Andromalius", "Duke_Amduscias", "Grand_Marquis_Chomiel", "Duke_Dantalian" })
content.loot =
{

    {
        { itemid = xi.items.DEMON_HORN, droprate = xi.battlefield.dropChance.NORMAL },
    },

    {
        { itemid = xi.items.FORSETIS_AXE, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.ARAMISS_RAPIER, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.SPARTAN_CESTI, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.SAIREN, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.ARCHALAUSS_POLE, droprate = xi.battlefield.dropChance.NORMAL },
    },

    {
        { itemid = xi.items.LIGHT_BOOMERANG, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.ARMBRUST, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.SCHWARZ_LANCE, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.OMOKAGE, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.ARCHALAUSS_POLE, droprate = xi.battlefield.dropChance.NORMAL },
    },

    {
        { itemid = xi.items.VASSAGOS_SCYTHE, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.KABRAKANS_AXE, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.DRAGVANDIL, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.HAMELIN_FLUTE, droprate = xi.battlefield.dropChance.NORMAL },
    },

    {
        { itemid = xi.items.NONE, droprate = xi.battlefield.dropChance.HIGH },
        { itemid = xi.items.SCROLL_OF_CARNAGE_ELEGY, droprate = xi.battlefield.dropChance.NORMAL },
        { itemid = xi.items.ICE_SPIRIT_PACT, droprate = xi.battlefield.dropChance.NORMAL },
    },
}

return content:register()
