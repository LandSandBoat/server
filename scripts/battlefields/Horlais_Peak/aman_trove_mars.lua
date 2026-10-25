-----------------------------------
-- A.M.A.N. Trove (Mars Orb)
-- Horlais Peak
-- !additem 9275
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.HORLAIS_PEAK,
    battlefieldId = xi.battlefield.id.AMAN_TROVE_MARS_HORLAIS_PEAK,
    maxPlayers    = 6,
    timeLimit     = utils.minutes(30),
    index         = 24,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    allowTrusts   = true,
    canLoseExp    = false,
    delayToExit   = 4, -- Observed on retail: the win cutscene plays about 4 seconds after the coffer opens.
    requiredItems = { xi.item.MARS_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
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
        mobs = { 'Chest_OPlenty' },
    },
}

return content:register()
