-----------------------------------
-- A.M.A.N. Trove (Mars)
-- Mars Orb : !additem 9275
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.AMAN_TROVE_MARS_BALGAS_DAIS,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 24,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.MARS_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

function content:setupBattlefield(battlefield)
    xi.amanTrove.setupBattlefield(battlefield)
end

content.groups =
{
    {
        mobIds =
        {
            {
                balgasID.mob.CHEST_O_PLENTY,
                balgasID.mob.CHEST_O_PLENTY + 1,
                balgasID.mob.CHEST_O_PLENTY + 2,
                balgasID.mob.CHEST_O_PLENTY + 3,
                balgasID.mob.CHEST_O_PLENTY + 4,
                balgasID.mob.CHEST_O_PLENTY + 5,
                balgasID.mob.CHEST_O_PLENTY + 6,
                balgasID.mob.CHEST_O_PLENTY + 7,
                balgasID.mob.CHEST_O_PLENTY + 8,
                balgasID.mob.CHEST_O_PLENTY + 9,
            },

            {
                balgasID.mob.CHEST_O_PLENTY + 11,
                balgasID.mob.CHEST_O_PLENTY + 12,
                balgasID.mob.CHEST_O_PLENTY + 13,
                balgasID.mob.CHEST_O_PLENTY + 14,
                balgasID.mob.CHEST_O_PLENTY + 15,
                balgasID.mob.CHEST_O_PLENTY + 16,
                balgasID.mob.CHEST_O_PLENTY + 17,
                balgasID.mob.CHEST_O_PLENTY + 18,
                balgasID.mob.CHEST_O_PLENTY + 19,
                balgasID.mob.CHEST_O_PLENTY + 20,
            },

            {
                balgasID.mob.CHEST_O_PLENTY + 22,
                balgasID.mob.CHEST_O_PLENTY + 23,
                balgasID.mob.CHEST_O_PLENTY + 24,
                balgasID.mob.CHEST_O_PLENTY + 25,
                balgasID.mob.CHEST_O_PLENTY + 26,
                balgasID.mob.CHEST_O_PLENTY + 27,
                balgasID.mob.CHEST_O_PLENTY + 28,
                balgasID.mob.CHEST_O_PLENTY + 29,
                balgasID.mob.CHEST_O_PLENTY + 30,
                balgasID.mob.CHEST_O_PLENTY + 31,
            },
        },
    },
}

return content:register()
