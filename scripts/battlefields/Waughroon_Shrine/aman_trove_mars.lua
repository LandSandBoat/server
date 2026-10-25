-----------------------------------
-- A.M.A.N. Trove (Mars Orb)
-- Waughroon Shrine
-- !additem 9275
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.WAUGHROON_SHRINE,
    battlefieldId = xi.battlefield.id.AMAN_TROVE_MARS_WAUGHROON_SHRINE,
    maxPlayers    = 6,
    timeLimit     = utils.minutes(30),
    index         = 25,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    allowTrusts   = true,
    canLoseExp    = false,
    delayToExit   = 4, -- Observed on retail: the win cutscene plays about 4 seconds after the coffer opens.
    requiredItems = { xi.item.MARS_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },
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
