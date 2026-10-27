-----------------------------------
-- A.M.A.N. Trove (Venus Orb)
-- Balga's Dais
-- !additem 9276
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.BALGAS_DAIS,
    battlefieldId = xi.battlefield.id.AMAN_TROVE_VENUS_BALGAS_DAIS,
    maxPlayers    = 6,
    timeLimit     = utils.minutes(30),
    index         = 25,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    allowTrusts   = true,
    canLoseExp    = false,
    delayToExit   = 4, -- Observed on retail: the win cutscene plays about 4 seconds after the coffer opens.
    requiredItems = { xi.item.VENUS_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return xi.settings.main.ENABLE_AMAN_TROVE == 1
end

function content:setupBattlefield(battlefield)
    xi.amanTrove.setupBattlefield(battlefield)
end

content.groups =
{
    {
        mobs = { 'Coffer_OPlenty' },
    },
}

return content:register()
