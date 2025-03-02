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
local ID = zones[xi.zone.APOLLYON]
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.APOLLYON,
    battlefieldId    = xi.battlefield.id.CENTRAL_APOLLYON,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 4,
    area             = 5,
    entryNpcs        = { '_12i', '_127' },
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, { xi.ki.RED_CARD, xi.ki.BLACK_CARD }, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.item.SMALT_CHIP, xi.item.SMOKY_CHIP, xi.item.CHARCOAL_CHIP, xi.item.MAGENTA_CHIP },
    name             = 'CENTRAL_APOLLYON',
    lootCrateId      = ID.npc.CENTRAL_LOOT_CRATE,
})

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
        mobs       = { 'Proto-Omega' },
        stationary = true,
        death      = function(mob, count)
            npcUtil.showCrate(GetNPCByID(ID.npc.CENTRAL_LOOT_CRATE))
        end,
    },

    {
        mobs    = { 'Gunpod' },
        spawned = false,
    }
}

content.loot =
{
    [ID.npc.CENTRAL_LOOT_CRATE] =
    {
        {
            quantity = 5,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            quantity = 2,
            { item = xi.item.PIECE_OF_OMEGAS_EYE,        weight = xi.loot.weight.NORMAL },
            { item = xi.item.SEGMENT_OF_OMEGAS_FORELEG,  weight = xi.loot.weight.LOW    },
            { item = xi.item.SEGMENT_OF_OMEGAS_HIND_LEG, weight = xi.loot.weight.LOW    },
            { item = xi.item.SEGMENT_OF_OMEGAS_TAIL,     weight = xi.loot.weight.LOW    },
        },

        {
            { item = xi.item.NONE,                  weight = xi.loot.weight.EXTREMELY_HIGH },
            { item = xi.item.PIECE_OF_OMEGAS_HEART, weight = xi.loot.weight.NORMAL         },
        },
    },
}

return content:register()
