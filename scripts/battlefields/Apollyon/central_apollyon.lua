-----------------------------------
-- Area: Appolyon
-- Name: SE Apollyon
-- !addkeyitem black_card
-- !addkeyitem cosmo_cleanse
-- !additem 1909
-- !additem 1910
-- !additem 1987
-- !additem 1988
-- !pos 600 -0.5 -600 38
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.APOLLYON,
    battlefieldId    = xi.battlefield.id.CENTRAL_APOLLYON,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 4,
    area             = 5,
    entryNpc         = '_12i',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, { xi.ki.RED_CARD, xi.ki.BLACK_CARD }, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.items.SMALT_CHIP, xi.items.SMOKY_CHIP, xi.items.CHARCOAL_CHIP, xi.items.MAGENTA_CHIP },
    name             = "CENTRAL_APOLLYON",
})

function content:isValidEntry(player, npc)
    return self.entryNpc == '_12i' or self.entryNpc == '_127'
end

function content:onEntryEventUpdate(player, csid, option, npc)
    if Battlefield.onEntryEventUpdate(self, player, csid, option, npc) then
        if npc:getName() == '_12i' then
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
    {
        mobs = { "Proto-Omega" },
        stationary = true,
        death = function(mob, count)
            npcUtil.showCrate(GetNPCByID(ID.CENTRAL_APOLLYON.npc.LOOT_CRATE))
        end,
    },

    {
        mobs = { "Gunpod" },
        spawned = false,
    }
}

content.loot =
{
    [ID.CENTRAL_APOLLYON.npc.LOOT_CRATE] =
    {
        {
            quantity = 5,
            { item = xi.items.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            quantity = 2,
            { item = xi.items.PIECE_OF_OMEGAS_EYE, weight = xi.loot.weight.NORMAL },
            { item = xi.items.SEGMENT_OF_OMEGAS_FORELEG, weight = xi.loot.weight.LOW },
            { item = xi.items.SEGMENT_OF_OMEGAS_HIND_LEG, weight = xi.loot.weight.LOW },
            { item = xi.items.SEGMENT_OF_OMEGAS_TAIL, weight = xi.loot.weight.LOW },
        },

        {
            { item = xi.items.NONE, weight = xi.loot.weight.EXTREMELY_HIGH },
            { item = xi.items.PIECE_OF_OMEGAS_HEART, weight = xi.loot.weight.NORMAL },
        },
    },
}

return content:register()
